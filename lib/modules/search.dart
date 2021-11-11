import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/searchCubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/ProductDetails.dart';
import 'package:shop_app/shared/component.dart';


class search_screen extends StatelessWidget {

  @override
var searchController=TextEditingController();
var keySearch=GlobalKey<FormState>();
  
Widget build(BuildContext context) {
  return BlocProvider(
    create: (BuildContext context)=>SearchCubit(),
    child: BlocConsumer<SearchCubit,shopStates>(
       listener: (context,state){},
        builder: (context,state){
          var cubit = SearchCubit.get(context);
    return Scaffold(
        appBar: AppBar(),
        body:  Form(
          key: keySearch,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                defultTextField(
                  context: context, 
                  vaildate: (String? value) {
                    if(value!.isEmpty){
                       return 'please write what want to search';}
                    },
                  controller: searchController,
                  labal: 'Search',
                  type: TextInputType.text,
                  prefix: Icons.search,
                  onsubmit: (String? value){
                    cubit.getSearchData(value!);
                  },
                  onchange: (String? value){
                    cubit.getSearchData(value!);
                  },
                 
                    ),
                SizedBox(height: 10,),
                 if (state is LoadingSearchState) LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),

            if (state is SuccessSearchState)
              BuildCondition(
                condition: cubit.Searchmodel != null ,
                builder: (context)=> Expanded(
                    child: ListView.separated(
                      itemBuilder:(context,index)=> searchItemBuilder(cubit.Searchmodel!.data.data[index],context,),
                      separatorBuilder:(context,index)=> myDivited(),
                        itemCount:cubit.Searchmodel!.data.data.length ,
                         ) ,
                       ),
              
                fallback: (context)=> Center(child: CircularProgressIndicator()),
              
              )
              ],
                        ),
              
            ),
         
        ),
                
    ); 
                
                },
  
        ),
  );
    
  }
      
  
}

Widget searchItemBuilder(model,context)=>
     GestureDetector(
        onTap: (){
          NavigatorTo(context, ProductDetails(model!.id));
        },
       child: Container(
          height: 120,
          padding: EdgeInsets.all(10),
          child: Row(
            children:
            [
              Image(image: NetworkImage(model!.image),width: 120,height: 120,),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Text(model.name,
                      style: TextStyle(fontSize: 15,),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    Spacer(),
                    Text(model.price.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                  ],
                ),
              )
            ],
          ),
       
         ),
     );

    