class User {
  String name;
  String phone;
  String email;
  String password;

  User ({
    this.name,
    this.phone,
    this.email,
    this.password
});

  factory User.fromJson(Map<String, dynamic> json) {
    return User (
      name: json['name']==null? 'N/A' : json['name'],
      phone: json['phone'],
      email: json['email'],
      password: json['password']
    );
  }
}