import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/search.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/style/colors/colors.dart';

 class layout_screen extends StatelessWidget {

   @override
   Widget build(BuildContext context) {
     return BlocConsumer<ShopCubit,shopStates>(
       builder: (context,state){
         var Cubit =ShopCubit.get(context);
         return Scaffold(
         appBar: AppBar(
           title: Text('salla',
           style:TextStyle(fontSize: 30) ,),
           actions: [
             MaterialButton(
               onPressed: (){
                 NavigatorTo(context, search_screen());
               },
               child: Icon(Icons.search),),
               TextButton(
                 onPressed: (){
               Cubit.SignOut(context);},
                child: Text('Signout',
                style:TextStyle(fontSize: 12) ,))
            
           ],
         ),
         body: Cubit.screens[Cubit.currentIndex],
         bottomNavigationBar: BottomNavigationBar(
           currentIndex:Cubit.currentIndex ,
           onTap:(currenindex){
              Cubit.changeBottomindex(currenindex);
             } ,
             type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon:Icon( Icons.home),
              label: 'HOME'
              ),
              BottomNavigationBarItem(icon:Icon( Icons.category),
              label: 'categories'
              ),
              BottomNavigationBarItem(icon:Icon( Icons.favorite_sharp),
              label: 'Favorites'
              ),
            /*  BottomNavigationBarItem(icon:Icon( Icons.settings),
              label: 'Settings'
              ),*/
            ],
            unselectedItemColor: Colors.grey,
            selectedItemColor: defultcolor,
            ),
         
       );
       }, 
       listener: (context,state){});
   }
 }