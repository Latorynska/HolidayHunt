import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wisata_app/constants.dart';
import 'package:wisata_app/helper/keyboard.dart';
import 'package:wisata_app/helper/session_manager.dart';
import 'package:wisata_app/screens/login_screen.dart';
import 'package:wisata_app/screens/login_success_screen.dart';
import 'package:wisata_app/services/auth_services.dart';
import 'package:wisata_app/size_config.dart';
import 'package:wisata_app/widgets/custom_snackbar.dart';
import 'package:wisata_app/widgets/custom_suffix_icon.dart';
import 'package:wisata_app/widgets/default_button.dart';
import 'package:wisata_app/widgets/form_error.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

Future<void> checkIsLogin(BuildContext context) async {
  await SessionManager().isLogin(context);
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  String _error = '';
  final List<String?> errors = [];
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void initState() {
    super.initState();
    checkIsLogin(context);
  }

  Future<void> _login() async {
    try {
      final user = await AuthService().login(email!, password!);

      if (user.email.isNotEmpty) {
        setState(() {
          _error = '';
        });

        // Simpan data pengguna ke SharedPreferences
        final prefs = await SessionManager.getInstance();
        await prefs.saveUserData(user.email);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const LoginSuccessScreen();
        }));
      } else {
        setState(() {
          _error = 'Wrong Email or Password';
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _error = 'Login Failed';
      });
    }

    if (_error.isNotEmpty) {
      CustomSnackbar.show(
        scaffoldMessengerKey.currentState!,
        _error,
        SnackbarType.error,
      );
      setState(() {
        _error = '';
      });
    }
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          // Background image container
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content container for form and text
          Column(
            children: [
              // Move the AppBar outside the Center widget
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              // Use Expanded to take remaining space and Align to center the content
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: SizeConfig.screenHeight * 0.04),
                          SizedBox(height: SizeConfig.screenHeight * 0.08),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                buildUsernameFormField(),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                buildEmailFormField(),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                buildPasswordFormField(),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                FormError(
                                    errors: errors, textColor: Colors.white),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                DefaultButton(
                                  text: "Register",
                                  press: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      KeyboardUtil.hideKeyboard(context);
                                      _login();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(30)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(16),
                                        color: Colors.white,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "Sudah Punya Akun? ",
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(16),
                                        color: Colors.white,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "Masuk ",
                                        ),
                                        TextSpan(
                                          text: "Disini",
                                          style: TextStyle(
                                            color: primaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return LoginScreen();
                                              }));
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: Color(0xFFE6E0E9),
        labelText: "Password",
        hintText: "Enter your password",
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        labelStyle: TextStyle(color: Colors.black87),
        hintStyle: TextStyle(color: Colors.black87),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: Color(0xFFE6E0E9),
        labelText: "Email",
        hintText: "Enter your email",
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        labelStyle: TextStyle(color: Colors.black87),
        hintStyle: TextStyle(color: Colors.black87),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: Color(0xFFE6E0E9),
        labelText: "Username",
        hintText: "Enter your Username",
        labelStyle: TextStyle(color: Colors.black87),
        hintStyle: TextStyle(color: Colors.black87),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
