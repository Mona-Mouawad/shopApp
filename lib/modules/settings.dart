import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/Login.dart';
import 'package:shop_app/shared/component.dart';

class Settings_screen extends StatelessWidget {

  TextEditingController namecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();

  @override
  
Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,shopStates>(
      builder: (context,state){
        var cubit= ShopCubit.get(context);
        var model=cubit.Usermodel!.data;
        namecontroller.text=model!.name!;
        phonecontroller.text=model.phone!;
        emailcontroller.text=model.email!;
       return 
       BuildCondition(
        
          condition:cubit.Usermodel != null ,
           builder: (context)=>Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20),
           child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           // SizedBox(height: 10,),
                            defultTextField(
                              context: context,
                               vaildate: (value)
                               {
                                 if(value!.isEmpty){
                                   return'Please enter your Name';
                                 }
                               },
                               type: TextInputType.name,
                               labal: 'Name',
                               prefix: Icons.person,
                               controller: namecontroller,
                               ),
                            SizedBox(height: 10,),
                            defultTextField(
                              context: context,
                               vaildate: (value)
                               {
                                 if(value!.isEmpty){
                                   return'Please enter your Email Addreas ';
                                 }
                               },
                               type: TextInputType.emailAddress,
                               labal: 'Email',
                               prefix: Icons.email_outlined,
                               controller: emailcontroller,
                               ),
                            SizedBox(height: 10,),
                            defultTextField(
                              context: context,
                               vaildate: (value)
                               {
                                 if(value!.isEmpty){
                                   return'Please enter your Password';
                                 }
                               },
                               type: TextInputType.visiblePassword,
                               labal: 'Password',
                               prefix: Icons.lock_open,
                               ispassword: true,
                               controller: passwordcontroller,
                               suffix: Icons.remove_red_eye_outlined,
                               suffixpressed: (){},
                            ),
                            SizedBox(height: 10,),
                            defultTextField(
                              context: context,
                               vaildate: (value)
                               {
                                 if(value!.isEmpty){
                                   return'Please enter your Phone';
                                 }
                               },
                               type: TextInputType.phone,
                               labal: 'Phone',
                               prefix: Icons.phone,
                               ispassword: true,
                               controller: phonecontroller,
                              
                               ),
                            SizedBox(height: 10,),
                            BuildCondition(
                              condition: state is ! LoadingUpdataState,
                              builder: (context)=>defultButton(text: 'Updata',
                               ontap: (){
                                // if(registerKey.currentState!.validate())
                                 {
                                 }
                              }),
                               fallback:(context)=> Center(child: CircularProgressIndicator()),
                            
                            ),
                             SizedBox(height: 15,),
                            BuildCondition(
                              condition: state is ! LoadingSignOutState,
                              builder: (context)=>defultButton(text: 'SignOut',
                               ontap: (){
                                 //if(registerKey.currentState!.validate())
                                 {
                                    cubit.SignOut(token);
                                 }
                              }),
                               fallback:(context)=> Center(child: CircularProgressIndicator()),
                            
                            ),
                             SizedBox(height: 20,),
                             
                          ],
                        
                      
            
             ),
         ),
       fallback: (context)=>Center(child: CircularProgressIndicator(),),
       );
    
      }
      , 
      listener: (context,state){
         var cubit= ShopCubit.get(context);
        if(state is SuccessSearchState)
        {
          if(cubit.LogOutmodel!.status ==true)
          {
            toast(text: cubit.LogOutmodel!.message!, 
            state: toastStates.Success);
            NavigatorTo(context, loginScreen());
          }
          else{
            toast(text: cubit.LogOutmodel!.message!, 
            state: toastStates.Error);
          }
        }
      })
      ;
  }
}