class loginModel{
 late bool status;
  String? message;
  loginData? data;

  loginModel.fromJson(Map<String,dynamic>json)
  {
   status = json['status'];
    message = json['message'];
    data = json['data'] != null ? loginData.fromJson(json['data']) : null;
  }

}

class loginData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? token;
  String? image;
  int? points;
  int? credit;
 
  loginData.fromJson(Map<String,dynamic>json)
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