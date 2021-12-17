import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:Modda_shop/api/api_helper.dart';
import 'package:Modda_shop/api/api_setting.dart';
import 'package:Modda_shop/models/api_base_response.dart';
import 'package:Modda_shop/models/base_api_object_response.dart';
import 'package:Modda_shop/models/register_user.dart';
import 'package:Modda_shop/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:Modda_shop/prefs/shared_pref_controller.dart';


class AuthApiController with ApiHelper {
  Future<bool> register(BuildContext context,
      {required RegisterUser user}) async {
    var url = Uri.parse(ApiSetting.register);
    var response = await http.post(url, body: {
      'name': user.name,
      'mobile': user.mobile,
      'password': user.password,
      'gender': user.gender,
      'STORE_API_KEY': ApiSetting.storeApiKey,
      'city_id': user.cityId.toString()

    });
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['code']);
      var basApiResponse = ApiBaseResponse.fromJson(jsonDecode(response.body));
      showSnackBar(context, message: basApiResponse.message);

      return true;
    } else if (response.statusCode == 400) {
      var message = jsonDecode(response.body)['message'];
      showSnackBar(context, message: message, error: true);

    }else{
      showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    }
    return false;
  }
  Future<bool> login(BuildContext context,
      {required String mobile, required String password}) async {
    var url = Uri.parse(ApiSetting.login);
    var response = await http.post(url, body: {
      'mobile': mobile,
      'password': password,
    },headers: headers
    );
    if (response.statusCode == 200) {
      //TODO: SHARED PREFERENCES - SAVE LOGGED IN USER DATA!!
      var baseApiResponse = BaseApiObjectResponse<User>.fromJson(jsonDecode(response.body));
      print(jsonDecode(response.body)['code']);

      showSnackBar(
        context,
        message: baseApiResponse.message,
      );
      await SharedPrefController().save(user: baseApiResponse.data);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    }else{
      showSnackBar(context, message: 'Something went wrong, please try again!',error: true);
    }
    return false;
  }
// activate account
  Future<bool> activate(BuildContext context,
      {required String phone , required String code}) async {
    var url = Uri.parse(ApiSetting.activate);
    var response = await http.post(url, body: {
      'mobile': phone,
      'code':code
    });

    if (response.statusCode == 200) {

      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(

        context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context,
        message: 'Something went wrong, please try again!',
        error: true,
      );
    }
    return false;
  }



  Future<bool> forgetPassword(BuildContext context,
      {required String phone}) async {
    var url = Uri.parse(ApiSetting.forgetPassword);
    var response = await http.post(url, body: {
      'mobile': phone,
    });

    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['code']);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(

        context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else {
      showSnackBar(
        context,
        message: 'Something went wrong, please try again!',
        error: true,
      );
    }
    return false;
  }


//Reset password

  Future<bool> resetPassword(
      BuildContext context, {
        required String phone,
        required String code,
        required String password,
      }) async {
    var url = Uri.parse(ApiSetting.resetPassword);
    var response = await http.post(
      url,
      body: {
        'mobile':phone,
        'code': code,
        'password': password,
        'password_confirmation': password,
      },
      headers: {HttpHeaders.acceptHeader: 'application/json'},
    );

    if (response.statusCode == 200) {
      showSnackBar(
        context,
        message: jsonDecode(response.body)['message'],
      );
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
        context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    } else if (response.statusCode == 500) {
      showSnackBar(
        context,
        message: 'Something went wrong, try again',
        error: true,
      );
    }
    return false;
  }


  Future<bool> logout() async {
    var url = Uri.parse(ApiSetting.logout);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.acceptHeader: 'application/json'
    });
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 401) {
      SharedPrefController().clear();
      return true;
    }
    return false;
  }
  
  
  

}