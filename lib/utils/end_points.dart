class EndPoints {
  ///---------------------------------------------- Api Key ----------------------------------------------
  // static const apiKey = 'c6d805c8b0751dab4dfda08908b90ee0';

  ///---------------------------------------------- Base url ----------------------------------------------
  //static const baseUrl = 'https://rainbow-api-staging.herokuapp.com/api';
  static const baseUrl = 'http://54.164.58.8:2929/api';
  static const user = "$baseUrl/user";
  static const admin = "$baseUrl/admin";


  ///--------------------  USER   ----------------------------------------------
  static const login = "$user/login";
  static const register = "$user/register";
  static const intrest = "$user/add/intereste";
  static const businessList = "$user/business/list";
  static const addFavourite = "$user/business/favourite/add";
  static const removeFavourite = "$user/business/favourite/remove";
  static const favouriteList = "$user/business/favourite/list";
  static const intrestList = "$user/category/list";

  ////////////////////////// ADMIN  ///////////////////////////////
  static const viewBusiness = "$admin/business/view";

}
