class User {
  String userType;
  String userEmail;
  String userPassword;

  User(this.userType, this.userEmail, this.userPassword);

  factory User.fromJson(dynamic json) {
    return User(json['userType'] as String, json['userEmail'] as String, json['userPassword'] as String);
  }

  @override
  String toString() {
    return '{ ${this.userType}, ${this.userEmail}, ${this.userPassword} }';
  }
}