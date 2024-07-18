class GetUserData {
  String? phoneNumber;
  String? id;
  String? username;
  String? email;
  String? birthdate;
  String? address;
  GetUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['name'];
    email = json['email'];
    birthdate = json['birthdate'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
  }
}
class Balance {
  String? balance;
  Balance.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
  }
}