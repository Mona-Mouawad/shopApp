import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/Login.dart';
import 'package:shop_app/modules/layout.dart';
import 'package:shop_app/modules/onboarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/helper/Dio_Helper.dart';
import 'package:shop_app/shared/helper/cach_Helper.dart';
import 'cubit/states.dart';
import 'shared/style/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  Dio_Helper.init();
  await Cach_helper.init();
  bool? onBoarding =Cach_helper.GetData(key: 'onBparding');
  token=Cach_helper.GetData(key: 'Token')??'';
  print('token  '+token);
  Widget ?widget;
  if(onBoarding != null)
  {
    widget= loginScreen();
  }
  if (token !='')
  {
    widget= layout_screen();
  }
  else widget=OnbroadingScreen();
  runApp(MyApp(startwidget: widget,));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget? startwidget;
  MyApp({this.startwidget});
  @override
  Widget build(BuildContext context) {
    return
    BlocProvider(create:(BuildContext context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavorite()..getUserData(),
    child: BlocConsumer<ShopCubit,shopStates>(
      builder: (context,state){
        return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme, 
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
       home:startwidget,
      // home:layout_screen(),
    );
      },
      listener: (context,state){}
      ),
      ); 
  }
}


