import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/Login.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/helper/cach_Helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbroadingScreen extends StatefulWidget {
  const OnbroadingScreen({ Key? key }) : super(key: key);

  @override
  _OnbroadingScreenState createState() => _OnbroadingScreenState();
}

class _OnbroadingScreenState extends State<OnbroadingScreen> {
  var boardcontroller=PageController();
  List<items> board=[
    items(body: 'Onboarding Body 1', image: 'images/onlineshop1.jpg', text: 'Onboarding 1', ),
    items(body: 'Onboarding Body 2', image: 'images/why-shop-online.jpg', text: 'Onboarding 2', ),
    items(body: 'Onboarding Body 3', image: 'images/Covershop3.jpg', text: 'Onboarding 3', )
  ];
  bool islast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
        TextButton(onPressed: (){
          Cach_helper.SaveData(key: 'onBparding', value: true).then(
            (value) =>  NavigatorAndFinish(context, loginScreen()));
          
        },
        child: 
        Text('SKIP'),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
           Expanded(
             child: PageView.builder(
               physics: BouncingScrollPhysics(),
               itemBuilder:(context,index)=> onboardingItem(board[index]),
               itemCount: board.length,
               controller: boardcontroller,
               onPageChanged: (int index){
                 if(index<board.length-1)
                 {print('notlast');}
                  else
                 {islast=true;
                 print('last');}
                 
               },
               ),
           ),
             SizedBox(height: 30,),
             Row(
               children: [
                 SmoothPageIndicator(
                   controller: boardcontroller,
                   effect: ExpandingDotsEffect(
                     activeDotColor: Colors.blue,
                     dotColor: Colors.grey,
                     //radius: 3,
                     spacing: 5,
                   ),
                    count: board.length),
                    Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(islast)
                    { Cach_helper.SaveData(key: 'onBparding', value: true).then(
                         (value) =>  NavigatorAndFinish(context, loginScreen()));
                    }
                    else{
                      boardcontroller.nextPage(duration: Duration(milliseconds: 700), curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.navigate_next),)    
               ],
             ),
          ],),
      ),
      
    );
 
  }


Widget onboardingItem(model)=>Column(
  children: [
         Expanded(
          child: Image(image: AssetImage('${model.image}'),
          ),
        ),
        Text('${model.text}',
         style: TextStyle(
          fontSize: 30
        )),
        SizedBox(height: 20,),
        Text('${model.body}',
        style: TextStyle(
          fontSize: 15
        )),
        SizedBox(height: 20,),
      ],);

}

 class items {
        final String image ,text,body;
        items({required this.image ,required this.text,required this.body});
        
        
      }