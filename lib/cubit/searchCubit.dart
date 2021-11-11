import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/searchModel.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/end_point.dart';
import 'package:shop_app/shared/helper/Dio_Helper.dart';

class SearchCubit extends Cubit<shopStates>{
  SearchCubit() : super(ShopinitialState());

  static SearchCubit get(context) =>BlocProvider.of(context);

  SearchModel ? Searchmodel;

   void getSearchData(String text) {
    emit(LoadingSearchState());
    Dio_Helper.PostData( 
      data: {
        "text": text
      },
       url: products_search,
      token: token
    ).then((value){
    Searchmodel = SearchModel.fromJson(value.data);
    print(Searchmodel!.status.toString());
    print(value.data);
   emit(SuccessSearchState());

   }).catchError((error){
     print(error.toString());
     emit(ErrorSearchState(error));});

}




}