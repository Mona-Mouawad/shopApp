import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/RegisterCubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/Login.dart';
import 'package:shop_app/modules/layout.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/helper/cach_Helper.dart';

class register_screen extends StatelessWidget {
  
  var registerKey =GlobalKey<FormState>();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>RegisterCubit() ,
      child: BlocConsumer<RegisterCubit,shopStates>(
         builder: (context,state){
            var cubit=RegisterCubit.get(context);
            return Scaffold(
        appBar: AppBar(),
         body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: registerKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Register'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.black),
                        ),
                       Text('Register now to browse our hot offers',
                      style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 20,),
                      defultTextField(
                        context: context,
                         vaildate: (value)
                         {
                           if(value!.isEmpty){
                             return'Please enter your Name';
                           }
                         },
                         type: TextInputType.name,
                         labal: 'Nmae',
                         prefix: Icons.person,
                         controller: namecontroller,
                         ),
                      SizedBox(height: 20,),
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
                      SizedBox(height: 20,),
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
                         onsubmit: (value){
                           if(registerKey.currentState!.validate()){
                    
                           }
                         }
                         ),
                      SizedBox(height: 20,),
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
                        condition: state is ! LoadingRegisterState,
                        builder: (context)=>defultButton(text: 'Register',
                         ontap: (){
                           if(registerKey.currentState!.validate())
                           {
                             cubit.Register(
                               name: namecontroller.text,
                               phone: phonecontroller.text,
                               email: emailcontroller.text,
                               Password: passwordcontroller.text);
                              //NavigatorAndFinish(context, home_screen()); 
                           }
                         }),
                         fallback:(context)=> Center(child: CircularProgressIndicator()),
                      
                      ),
                       SizedBox(height: 35,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",style: TextStyle(fontSize: 17),),
                        TextButton(child: Text("Log In",style: TextStyle(color: Colors.deepPurple,fontSize: 17),),onPressed: (){
                          NavigatorTo(context, loginScreen());
                        },),
                      ],
                    ), 
                      ],
                  ),
                ),
              ),
            ),
          ),
        ),
      
      );
      },
         listener: (context,state){
               var cubit=RegisterCubit.get(context);
              if(state is SuccessRegisterState)
              {
                if(cubit.Registermodel!.status==true)
                { 
                  Cach_helper.SaveData(
                    key: 'Token', 
                    value: cubit.Registermodel!.data!.token
                    ).then((value) {
                       token = cubit.Registermodel!.data!.token!;
                       print(cubit.Registermodel!.message);
                       print(token);
                       toast(
                    text: cubit.Registermodel!.message.toString(), 
                    state: toastStates.Success);
                       NavigatorAndFinish(context, 
                       layout_screen());
                    }).catchError(
                      (error){print(error.toString());});
                }
                else{
                  print(cubit.Registermodel!.message);
                  toast(
                    text: cubit.Registermodel!.message.toString(), 
                    state: toastStates.Error);
                }
              }
             },      
                
      ),
    );
  }
}