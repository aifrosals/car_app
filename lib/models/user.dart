class User{
  String phone;
  String email;
  String password;

  User({
    this.phone,
    this.email,
    this.password
});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phone: json['phone'],
      email: json['email'],
      password: json['password']
    );
  }
}