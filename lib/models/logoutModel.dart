
class LogOutModel{
  bool? status;
  String? message;
  Data? data;

  LogOutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data{
  
  int ? id;
  String ? token;

  Data.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    token=json['token'];
  }
   
}