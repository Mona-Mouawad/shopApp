import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/loginM.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/end_point.dart';
import 'package:shop_app/shared/helper/Dio_Helper.dart';

class Logincubit extends Cubit<shopStates>{

  Logincubit() : super(ShopinitialState());
  static Logincubit get(context)=>BlocProvider.of(context);
  
  
  loginModel? loginmodel;
 IconData icon=Icons.visibility_outlined;
 bool ispassword =true;
  
  void changeVisibilty()
  {
    ispassword=!ispassword;
    icon=ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangeVisibilityloginstate());
  }
  
  
  void UserLogin({
    required String email,
    required String password,
  })
  {
    emit(Loadingloginstate());
    Dio_Helper.PostData(
      url: LOGIN,
     data:{
       'email':email,
       'password':password
     } ).then(
       (value) {
         print("object_1");
         loginmodel =loginModel.fromJson(value.data);
         print(loginmodel!.data);
         print("object_2");
         token=loginmodel!.data!.token!;
       emit(Successloginstate(loginmodel!));
     }).catchError((error){
       print("object_3");
         emit(Errorloginstate(error.toString()));
    });

  }
}