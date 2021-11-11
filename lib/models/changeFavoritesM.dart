class ChangeFavoritesModel{

  late bool status ;
  String ? message;

  ChangeFavoritesModel.fromJosn(Map<String,dynamic> josn)
  {
    status =josn['status'];
    message =josn['message'];
  } 
}