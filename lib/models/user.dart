class UserModel {
  final String email;
  final String password;
  final String? username;
  final String? telp;
  final String? imageUrl;

  UserModel(
      {required this.email,
      required this.password,
      this.username,
      this.telp,
      this.imageUrl});
}
