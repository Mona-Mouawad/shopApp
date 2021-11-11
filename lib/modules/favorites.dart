import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/style/colors/colors.dart';

class Favorites_screen extends StatelessWidget {

  @override
  
Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,shopStates>(
      builder: (context,state){
        var cubit= ShopCubit.get(context);
        return SingleChildScrollView(
          child: BuildCondition(
            condition: cubit.favoritesModel != null,
            builder:(context)=>ListView.separated(
             shrinkWrap: true, 
             physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index)=>buildPorduct(cubit.favoritesModel!.data!.data[index].product! ,context), 
            separatorBuilder: (context,index)=> myDivited(),
            itemCount:cubit.favoritesModel!.data!.data.length),
            fallback:(context)=> Center(child: Text('No Product has been added yet',
            style:Theme.of(context).textTheme.headline4 ,)),
          ),
        );
        }  , listener: (context,state)=>{}
      
      
    );
  }

 

}