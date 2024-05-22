class SignupModel {
  int id;
  String name;
  String email;
  String login;

  SignupModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.login});

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      login: json['login'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'login': login,
    };
  }
}
