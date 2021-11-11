import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/shared/component.dart';

class Categories_screen extends StatelessWidget {
  const Categories_screen({ Key? key }) : super(key: key);

  @override
  
Widget build(BuildContext context) {
        return BlocConsumer<ShopCubit,shopStates>(
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return BuildCondition(
          condition: cubit.Categoriesmodel !=null,
          builder: (context)=> ListView.separated(
                      itemBuilder:(context,index)=>itemCatagres(cubit.Categoriesmodel,index),
                       separatorBuilder:(context,index)=> myDivited(),
                       itemCount: cubit.Categoriesmodel!.data!.data.length),
         
            fallback: (context)=>Center(child: CircularProgressIndicator(),),
                
        );
      },
      listener: (context,state){}
      );
    }

  Widget itemCatagres(CategoriesModel? CateModel,index)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
        children: [
      Image(image:NetworkImage(CateModel!.data!.data[index].image!),
      height: 120,
      width: 100,
      fit: BoxFit.cover,),
      SizedBox(width: 10,),
      Text(CateModel.data!.data[index].name!,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black,
      fontSize: 16
      ),
      ),
      Spacer(),
      IconButton(onPressed: (){}, 
      icon:Icon(Icons.navigate_next_sharp)),
    ],
    ),
  );    

  }

