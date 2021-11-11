import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/RegisterModel.dart';
import 'package:shop_app/models/loginM.dart';
import 'package:shop_app/shared/end_point.dart';
import 'package:shop_app/shared/helper/Dio_Helper.dart';

class RegisterCubit extends Cubit<shopStates>{

  RegisterCubit() : super(ShopinitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  
  
  loginModel? loginmodel;
 IconData icon=Icons.visibility_outlined;
 bool ispassword =true;
  
  void changeVisibilty()
  {
    ispassword=!ispassword;
    icon=ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangeVisibilityloginstate());
  }
  
  
RegisterModel? Registermodel;
void Register({ required String name,
required String phone,required String email,
required String Password})
{
  emit(LoadingRegisterState());
  Dio_Helper.PostData(
    url: REGISTER,
   data: {
       "name": name,
        "phone": phone,
        "email":email,
        "password":Password
   }).then((value) {
     Registermodel =RegisterModel.fromJson(value.data);
     print(value.data);
     print(Registermodel!.message);
   emit(SuccessRegisterState());

   }).catchError((error){
     print(error.toString());
     emit(ErrorRegisterState(error.toString()));});
}



}