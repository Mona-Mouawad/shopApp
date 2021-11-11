import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/LoginCubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/layout.dart';
import 'package:shop_app/modules/registerscreen.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/helper/cach_Helper.dart';

class loginScreen extends StatelessWidget {
  
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  var loginformkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     
      return BlocProvider(
        create: (BuildContext context)=>Logincubit(),
        child: BlocConsumer<Logincubit,shopStates>(
           listener: (context,state){
            if(state is Successloginstate)
            {
              if(state.loginmodel.status)
              { 
               //print(state.loginmodel.message);
                Cach_helper.SaveData(
                  key: 'Token', 
                  value: state.loginmodel.data!.token
                  ).then((value) {
                     token = state.loginmodel.data!.token!;
                     print(state.loginmodel.message);
                     print(token);
                     toast(
                  text: state.loginmodel.message.toString(), 
                  state: toastStates.Success);
                     NavigatorAndFinish(context, 
                     layout_screen());
                  }).catchError(
                    (error){print(error.toString());});
              }
              else{
                print(state.loginmodel.message);
                toast(
                  text: state.loginmodel.message.toString(), 
                  state: toastStates.Error);
              }
            }
           },      
          builder: (context,state){
            var cubit=Logincubit.get(context);
          return  Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: loginformkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.black),
                        ),
                       Text('Login now to browse our hot offers',
                      style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 20,),
                      defultTextField(
                        context: context,
                         vaildate: (value)
                         {
                           if(value!.isEmpty){
                             return'Email Addreas must not be empty';
                           }
                         },
                         type: TextInputType.emailAddress,
                         labal: 'Email',
                         prefix: Icons.email_outlined,
                         controller: emailcontroller,
                         ),
                      SizedBox(height: 20,),
                      defultTextField(
                        context: context,
                         vaildate: (value)
                         {
                           if(value!.isEmpty){
                             return'Password must not be empty';
                           }
                         },
                         type: TextInputType.visiblePassword,
                         labal: 'Password',
                         prefix: Icons.lock_open,
                         ispassword: cubit.ispassword,
                         controller: passwordcontroller,
                         suffix: cubit.icon,
                         suffixpressed: (){
                           cubit.changeVisibilty();
                         },
                         onsubmit: (value){
                           if(loginformkey.currentState!.validate()){
              
                           }
                         }
                         ),
                      SizedBox(height: 20,),
                      BuildCondition(
                        condition:state is !Loadingloginstate ,
                        builder: (context)=>defultButton(text: 'LOGIN',
                         ontap: (){
                           if(loginformkey.currentState!.validate())
                           {
                              cubit.UserLogin(
                               email: emailcontroller.text,
                               password: passwordcontroller.text);
                           }  
                         }
                         ),
                        fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have account',
                          style:TextStyle(fontSize: 16) ,),
                          SizedBox(width: 10,),
                          defultTextButton(
                            text: 'Requester', 
                            ontap: (){
                              NavigatorAndFinish(context, register_screen());
                            }),
                           ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          );
        
          },
          )
      );
  }
}