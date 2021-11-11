import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/shared/style/colors/colors.dart';

String token='';

Widget defultTextField ({
  required context,
  TextEditingController? controller,
  TextInputType? type,
  String? labal,
  IconData? prefix , suffix, suffixpressed,
  String? initivalue,
  Function(String)? onsubmit ,onchange , ontap,
 required String? Function(String?) vaildate,
 bool ispassword =false,  enable =true,

})=>Container(
  decoration:BoxDecoration(borderRadius: BorderRadius.circular(20)) ,
  child:   TextFormField(
  
  controller: controller ,
  
  keyboardType:type ,
  
  obscureText: ispassword,
  
  textAlign: TextAlign.start,
  
  decoration: InputDecoration(border:OutlineInputBorder(),
  
   labelText: labal,
  
   suffixIcon: suffix !=null ?IconButton(
  
     onPressed: suffixpressed,
  
      icon:Icon(suffix) ) :null,
  
      prefixIcon: Icon(prefix),
  
      
  
  ),
  
    validator:vaildate ,  
  
    onChanged: onchange,
  
    onTap: ontap,
  
    onFieldSubmitted: onsubmit,
  
    initialValue: initivalue,
  
   style: Theme.of(context).textTheme.bodyText1,
  
  ),
);

Widget defultButton({
  required String text,
  required VoidCallback ontap
})=>Container(
height: 50,
width: double.infinity,
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: defultcolor,
),
child: MaterialButton(
  onPressed: ontap,
  child: Text(text,style: TextStyle(color: Colors.white,
  fontWeight: FontWeight.bold
),
),
),

);

Widget defultTextButton({
  required String text,
  required VoidCallback ontap})=>
  TextButton(
  onPressed: ontap,
  child: Text(text.toUpperCase(),style: TextStyle(color: defultcolor,fontWeight: FontWeight.w500),),
);


void toast({
  required String text,
  required toastStates state
  })=>Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: toastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );
    enum toastStates{Success,Error,Warning}

    Color toastColor(toastStates state){
      Color ?color;
      switch (state) {
        case toastStates.Success :
         color= Colors.green;
          break;
        case toastStates.Error :
         color= Colors.red;
          break;  
        default:
        color= Colors.yellow;
      }
       return color;
    }

void NavigatorTo(context,Widget)=> Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>Widget));

void NavigatorAndFinish(context,Widget){
  Navigator.pushAndRemoveUntil(context,
   MaterialPageRoute(builder:(context)=> Widget),
   (route){return false;});
}

Widget myDivited()=>Padding(
  padding: const EdgeInsets.all(10.0),
  child:   Container(width: double.infinity,height: 2,
  color: Colors.black,),
);

Widget buildPorduct( model,context,{bool isOldPrice=true})=>Padding(
   padding: const EdgeInsets.all(20.0),
   child: Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              Image(image: NetworkImage(model!.image!),
                              fit: BoxFit.cover,
                              height: 180,),
                              if(model.discount != 0 && isOldPrice)
                                  Container(
                                    color: Colors.red,
                                    child: Text('DISCOUNT'))
                                ,
                            ],
                          ),
                         SizedBox(height: 10,),
                          Text(model.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis ,
                          style: TextStyle(
                            height: 1,
                            fontSize: 18
                          ),),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(model.price!.toString(),
                                  style: TextStyle(
                                    color: defultcolor,
                                    fontWeight: FontWeight.bold
                                   ))
                                   ,
                                  if(model.discount != 0 && isOldPrice)
                                  Text(model.oldPrice!.toString(),
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    
                                  ),),
                                ],
                              ),
                              Spacer(),
                             BuildCondition(condition:ShopCubit.get(context).favorites[model.id!] ,
                             builder: (context)=> CircleAvatar(
                                 backgroundColor: defultcolor,
                                 child: IconButton(onPressed: (){
                                   ShopCubit.get(context).changeFavorite(model.id!);},
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
