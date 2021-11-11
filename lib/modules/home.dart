import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/modules/ProductDetails.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/style/colors/colors.dart';

class home_screen extends StatelessWidget {
  HomeModel? homemodel;
  @override
 Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,shopStates>(
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return BuildCondition(
          condition:  cubit.homeModel !=null && cubit.Categoriesmodel !=null,
          builder: (context)=> buildproductHome(context,cubit.homeModel,cubit.Categoriesmodel), 
         
            fallback: (context)=>Center(child: CircularProgressIndicator(),),
                
        );
      },
      listener: (context,state){}
      );
    } 
  }

  Widget buildproductHome(context,HomeModel? model,CategoriesModel? CateModel)=>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
                      items:model!.data!.banners.map((e) =>
                       Image(
                        image: NetworkImage('${e.image}'),fit: BoxFit.cover,width: double.infinity,)).toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayInterval: Duration(seconds: 4),
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        enableInfiniteScroll: true,
                        height: 190,
                        initialPage: 0,
                        reverse: false,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1,
                      ),
                    ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories',
                  style:Theme.of(context).textTheme.headline5,),
                 SizedBox(height: 10,),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index)=>itemCatagres(CateModel,index),
                       separatorBuilder:(context,index)=> SizedBox(width: 10,), 
                       itemCount: CateModel!.data!.data.length),
              
                  ),
                  SizedBox(height: 10,),
                  Text('Products',
                  style:Theme.of(context).textTheme.headline5,),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1/1.9,
                  crossAxisSpacing: 10,
                  children: List.generate(
                    model.data!.products.length, (index) =>buildPorduct(model.data!.products[index],context)
                    ),
                  )
                ],
              ),
            ),
            
          ],
        ),
      );
 
  Widget itemCatagres(CategoriesModel? CateModel,index)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(image:NetworkImage(CateModel!.data!.data[index].image!),
    height: 100,
    width: 100,
    fit: BoxFit.cover,),
    Container(
      color: Colors.black.withOpacity(.65),
      width: 100,
      child: Text(CateModel.data!.data[index].name!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),),
    )
  ],
  );    

 Widget buildPorduct(HomeProductModel model,context)=>GestureDetector(
   onTap: (){
     NavigatorTo(context, ProductDetails(model.id));
   },
   child: Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              Image(image: NetworkImage(model.image!),
                              fit: BoxFit.cover,
                              height: 180,),
                              if(model.discount != 0)
                                  Container(
                                    color: Colors.red,
                                    child: Text('DISCOUNT'))
                                ,
                            ],
                          ),
                          SizedBox(height: 3,),
                          Text(model.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis ,
                          style: TextStyle(
                            height: 1,
                          ),),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(model.price!.toString(),
                                  style: TextStyle(
                                    color: defultcolor,
                                    fontWeight: FontWeight.bold
                                   )),
                                  if(model.discount != 0)
                                  Text(model.oldPrice!.toString(),
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough
                                  ),),
                                ],
                              ),
                              Spacer(),
                             BuildCondition(condition:ShopCubit.get(context).favorites[model.id!] ,
                             builder: (context)=> CircleAvatar(
                                 backgroundColor: defultcolor,
                                 child: IconButton(onPressed: (){
                                   ShopCubit.get(context).changeFavorite(model.id!);
                                 },
                                 icon: Icon(Icons.favorite_outline),
                                 color: Colors.white,),
                                ),
                              fallback: (context)=> CircleAvatar(
                                 backgroundColor: Colors.grey,
                                 child: IconButton(onPressed: (){
                                  ShopCubit.get(context).changeFavorite(model.id!);
                                 },
                                 icon: Icon(Icons.favorite_outline),
                                 color: Colors.white,),
                                ), 
                             ),
                            
                            ],
                          ),
                        ],
                      ),
 );

         
               