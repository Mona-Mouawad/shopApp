class UserModel{
 late bool status;
 late String message;
  UserData? data;

  UserModel.fromJson(Map<String,dynamic>json)
  {
   status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

}

class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? token;
  String? image;
  int? points;
  int? credit;
 
  UserData.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];

  }
}