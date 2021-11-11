import 'package:shop_app/models/loginM.dart';

abstract class shopStates{}

class ShopinitialState extends shopStates{}

class Loadingloginstate  extends shopStates{}

class Successloginstate extends shopStates{
  final loginModel loginmodel;
  Successloginstate(this.loginmodel){print("object_4");}
}

class Errorloginstate extends shopStates{
  final String error;
  Errorloginstate(this.error);
}
class ChangeVisibilityloginstate extends shopStates{}

class ChangeBottomstate extends shopStates{}


class Loadinghomestate  extends shopStates{}

class Successhomestate extends shopStates{}

class Errorhomestate extends shopStates{
  final String error;
  Errorhomestate(this.error);
}

class LoadingCategriesState  extends shopStates{}

class SuccessCategriesState extends shopStates{}

class ErrorCategriesState extends shopStates{
  final String error;
  ErrorCategriesState(this.error);
}

class ChangeButtonFavoriteState extends shopStates{}


class LoadingFavoritesState  extends shopStates{}

class SuccessFavoritesState extends shopStates{}

class ErrorFavoritesState extends shopStates{
  final String error;
  ErrorFavoritesState(this.error);
}


class LoadingSearchState  extends shopStates{}

class SuccessSearchState extends shopStates{}

class ErrorSearchState extends shopStates{
  final String error;
  ErrorSearchState(this.error);
}

class LoadingporductDetState  extends shopStates{}

class SuccessporductDetState extends shopStates{}

class ErrorporductDetState extends shopStates{
  final String error;
  ErrorporductDetState(this.error);
}

class ChangeIndicatorState extends shopStates{}

class LoadingRegisterState  extends shopStates{}

class SuccessRegisterState extends shopStates{}

class ErrorRegisterState extends shopStates{
  final String error;
  ErrorRegisterState(this.error);
}

class LoadingSignOutState  extends shopStates{}

class SuccessSignOutState extends shopStates{}

class ErrorSignOutState extends shopStates{
  final String error;
  ErrorSignOutState(this.error);
}

class LoadingUpdataState  extends shopStates{}

class SuccessUpdataState extends shopStates{}

class ErrorUpdataState extends shopStates{
  final String error;
  ErrorUpdataState(this.error);
}

class LoadingUserState  extends shopStates{}

class SuccessUserState extends shopStates{}

class ErrorUserState extends shopStates{
  final String error;
  ErrorUserState(this.error);
}