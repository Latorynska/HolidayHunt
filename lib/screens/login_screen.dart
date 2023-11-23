import 'package:flutter/material.dart';
import 'package:wisata_app/constants.dart';
import 'package:wisata_app/helper/keyboard.dart';
import 'package:wisata_app/helper/session_manager.dart';
import 'package:wisata_app/screens/login_success_screen.dart';
import 'package:wisata_app/services/auth_services.dart';
import 'package:wisata_app/size_config.dart';
import 'package:wisata_app/widgets/custom_snackbar.dart';
import 'package:wisata_app/widgets/custom_suffix_icon.dart';
import 'package:wisata_app/widgets/default_button.dart';
import 'package:wisata_app/widgets/form_error.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

Future<void> checkIsLogin(BuildContext context) async {
  await SessionManager().isLogin(context);
}

class _LoginScreenState extends State<LoginScreen> {
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
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
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
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.04),
                        SizedBox(height: SizeConfig.screenHeight * 0.08),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              buildEmailFormField(),
                              SizedBox(
                                  height: getProportionateScreenHeight(30)),
                              buildPasswordFormField(),
                              SizedBox(
                                  height: getProportionateScreenHeight(30)),
                              FormError(errors: errors),
                              SizedBox(
                                  height: getProportionateScreenHeight(30)),
                              DefaultButton(
                                text: "Login",
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
                        SizedBox(height: SizeConfig.screenHeight * 0.08),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account? ",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(16),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(16),
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
      style: TextStyle(color: Colors.white), // Set text color to white
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        labelStyle: TextStyle(color: Colors.white), // Set label color to white
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white), // Set enabled border color to white
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
      style: TextStyle(color: Colors.white), // Set text color to white
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        labelStyle: TextStyle(color: Colors.white), // Set label color to white
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white), // Set enabled border color to white
        ),
      ),
    );
  }
}
