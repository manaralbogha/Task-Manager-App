class LoginModel {
  final int id;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String token;

  LoginModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(
      id: jsonData["id"],
      userName: jsonData["username"],
      email: jsonData["email"],
      firstName: jsonData["firstName"],
      lastName: jsonData["lastName"],
      gender: jsonData["gender"],
      image: jsonData["image"],
      token: jsonData["token"],
    );
  }
}
