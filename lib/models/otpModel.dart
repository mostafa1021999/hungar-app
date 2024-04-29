class LoginOTP {
  String? message;
  String? token;
  LoginOTP.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];

  }
}