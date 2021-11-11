import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/productsDetails.dart';
import 'package:shop_app/shared/style/colors/colors.dart';

class ProductDetails extends StatelessWidget {
  final id;
  ProductDetails(this.id);
  List<Widget> images=[];
  @override
  Widget build(BuildContext context) {
   return BlocProvider.value(
     value: BlocProvider.of<ShopCubit>(context)..getproductDetData(id.toString()),
       child: BlocConsumer<ShopCubit,shopStates>(
       listener:(context,state){} ,
        builder: (context,state){
          var cubit = ShopCubit.get(context);
     return Scaffold(
        appBar: AppBar(),
        body: BuildCondition(
          condition: cubit.productDetmodel!=null,
          fallback:(context)=> Center(child: CircularProgressIndicator(),),
          builder:(context)=>buliditem(cubit.productDetmodel, context)
        )
        
      );
     
   }
     ),
   );
  }
Widget buliditem(ProductDetailsModel ? model,context){
  model!.data.images.forEach((element) {
            images.add(Container(width: double.infinity,
              child: Image.network(element,fit: BoxFit.cover,),));
           });
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
                children: [
                  Text(model.data.name,
                  style: Theme.of(context).textTheme.headline5,),
                  CarouselSlider(
                    items: images,
                     options: CarouselOptions(
                      autoPlay: true,
                      height: 250,
                      onPageChanged: (x,reason){
                        ShopCubit.get(context).ChangeIndicator(x);
                      },
                      initialPage: 0,
                      autoPlayAnimationDuration: Duration(milliseconds: 300),
                      autoPlayCurve:  Curves.fastLinearToSlowEaseIn,
                     )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(model.data.price!.toString(),
                                      style:Theme.of(context).textTheme.headline5!.copyWith(
                                        color: defultcolor,
                                        fontWeight: FontWeight.bold
                                      )),
                                      if(model.data.discount != 0)
                                      Text(model.data.oldPrice!.toString(),
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                 BuildCondition(condition:ShopCubit.get(context).favorites[model.data.id] ,
                                 builder: (context)=> CircleAvatar(
                                     backgroundColor: defultcolor,
                                     child: IconButton(onPressed: (){
                                       ShopCubit.get(context).changeFavorite(model.data.id);
                                     },
                                     icon: Icon(Icons.favorite_outline),
                                     color: Colors.white,),
                                    ),
                                  fallback: (context)=> CircleAvatar(
                                     backgroundColor: Colors.grey,
                                     child: IconButton(onPressed: (){
                                      ShopCubit.get(context).changeFavorite(model.data.id);
                                     },
                                     icon: Icon(Icons.favorite_outline),
                                     color: Colors.white,),
                                    ), 
                                 ),
                                
                                ],
                              ),
                    ),
                  Text(model.data.description,
                  style: Theme.of(context).textTheme.headline6,)   , 
                  SizedBox(height: 50,)    
                   
                ],
              ),
      ),
    );
              
}

}