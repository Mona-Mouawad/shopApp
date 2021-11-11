import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/changeFavoritesM.dart';
import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/models/logoutModel.dart';
import 'package:shop_app/models/productsDetails.dart';
import 'package:shop_app/models/userModel.dart';
import 'package:shop_app/modules/Login.dart';
import 'package:shop_app/modules/categories.dart';
import 'package:shop_app/modules/favorites.dart';
import 'package:shop_app/modules/home.dart';
import 'package:shop_app/modules/settings.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/end_point.dart';
import 'package:shop_app/shared/helper/Dio_Helper.dart';
import 'package:shop_app/shared/helper/cach_Helper.dart';

class ShopCubit extends Cubit<shopStates>{

  ShopCubit() : super(ShopinitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex =0;
  List<Widget> screens=[
    home_screen(),
    Categories_screen(),
    Favorites_screen(),
    //Settings_screen()
  ];

  LogOutModel? LogOutmodel;
void SignOut(context)
{ 
  token='';
  Cach_helper.RemoveData(key: token).then((value) {
    if(value){
      NavigatorTo(context, loginScreen());
    }
  });
  emit(LoadingSignOutState());
  Dio_Helper.PostData(
    url: logout,
   data: {
        "token":token
   }).then((value) {
     LogOutmodel =LogOutModel.fromJson(value.data);
     print(value.data);
     print(LogOutmodel!.message);
   emit(SuccessSignOutState());

   }).catchError((error){
     print(error.toString());
     emit(ErrorSignOutState(error.toString()));});
}



  void changeBottomindex(index)
  {
     currentIndex =index;
     emit(ChangeBottomstate()); 
  }
 
 HomeModel? homeModel;
 Map<int,bool> favorites = {};
  void getHomeData() {
    emit(Loadinghomestate());
    print('MONA');
    Dio_Helper.getData(
        url: HOME,
      token: token
    ).then((value){
    homeModel = HomeModel.fromJson(value.data);
    homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites,
        });
    }) ;
    print('Home '+homeModel!.status.toString());
   print(homeModel!.data!.banners[0].image.toString());
   emit(Successhomestate());
   }).catchError((error){print(error.toString());});

}
  
ChangeFavoritesModel? ChangefavoritesModel; 
void changeFavorite(int id)
{
if(favorites[id]== true){
  favorites[id]=false;
}
else favorites[id]= true;
  print('ID');
  print(favorites[id]);
  emit(ChangeButtonFavoriteState());
  
  Dio_Helper.PostData(
    url: FAVORITES,
     data: {
       'product_id' : id
     },
     token: token).then(
       (value) { ChangefavoritesModel= ChangeFavoritesModel.fromJosn(value.data);
       print(value.data);
       if (!ChangefavoritesModel!.status) {
         if(favorites[id]== true){
            favorites[id]=false; 
          }
          else favorites[id]= true;
        } 
        getFavorite();
        });


}

FavoritesModel? favoritesModel; 
void getFavorite()
{

  emit(LoadingFavoritesState());
  
  Dio_Helper.getData(
    url: FAVORITES,
     token: token).then(
       (value) {favoritesModel= FavoritesModel.fromJson(value.data);
       print(value.data);
       emit(SuccessFavoritesState());
        } 
      ).catchError((Error){
        print(Error.toString());
        emit(ErrorFavoritesState(Error));
      });


}


  CategoriesModel ? Categoriesmodel;
   void getCategoriesData() {
    emit(LoadingCategriesState());
    Dio_Helper.getData(
        url: categories_GET,
      token: token
    ).then((value){
    Categoriesmodel = CategoriesModel.fromJson(value.data);
    print('Home '+Categoriesmodel!.status.toString());
   print(Categoriesmodel!.data!.data[0].image);

   emit(SuccessCategriesState());

   }).catchError((error){
     print(error.toString());
     emit(ErrorCategriesState(error));});

}
  
  ProductDetailsModel ? productDetmodel;

   void getproductDetData(String id) {
    emit(LoadingporductDetState());
    Dio_Helper.getData(
      url: ProductDetails+id,
      token: token,
      ).then((value){
    productDetmodel = ProductDetailsModel.fromJson(value.data);
    print(productDetmodel!.status.toString());
    print(value.data);
   emit(SuccessporductDetState());

   }).catchError((error){
     print(error.toString());
     emit(ErrorporductDetState(error));});

}
int value=0;
void ChangeIndicator(int val)
{
  value=val;
  emit(ChangeIndicatorState());
}  

 UserModel ? Usermodel;
   void getUserData() {
    emit(LoadingCategriesState());
    Dio_Helper.getData(
        url: profile,
      token: token
    ).then((value){
    Usermodel = UserModel.fromJson(value.data);
    print('Home '+Usermodel!.status.toString());

   emit(SuccessUserState());

   }).catchError((error){
     print(error.toString());
     emit(ErrorUserState(error));});

}
  


}

 
  



