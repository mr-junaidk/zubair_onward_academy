class UserModel {
  String? token;
  String? name;
  String? email;
  String? customerId;
  int? role;

  UserModel({this.token, this.name, this.email, this.customerId, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['data']?['payload']?['name'];
    email = json['data']?['payload']?['email'];
    customerId = json['data']?['payload']?['customerId'];
    role = json['data']?['payload']?['role'];
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'name': name,
      'email': email,
      'customerId': customerId,
      'role': role,
    };
  }
}
