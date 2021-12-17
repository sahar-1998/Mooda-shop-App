import 'dart:convert';
import 'dart:io';
import 'package:Modda_shop/api/api_helper.dart';
import 'package:Modda_shop/api/api_setting.dart';
import 'package:Modda_shop/models/product_details.dart';
import 'package:Modda_shop/prefs/shared_pref_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class ProductApiController with  ApiHelper{

  Future<List< ProudctDetails>> getProduct({required int id}) async {
    var response = await http.get(Uri.parse(ApiSetting.products + '$id'),headers:headers);
    print("gggggggggggggggg ${response.body} $id");
    if (response.statusCode==200) {

      var data = jsonDecode(response.body)['list'] as List;
      List<ProudctDetails> product = data.map((e) =>  ProudctDetails.fromJson(e)).toList();
      return product;
    }
    return [];
  }

  Future <ProudctDetails?> getproductdetails({required int id}) async {
    var response = await http.get(Uri.parse(ApiSetting.productDetails + '$id'),headers:headers);
    print("ffffffffffffff ${response.body}$id");
    if (response.statusCode==200) {
      var data = jsonDecode(response.body)['object'];
      var productDetails = ProudctDetails.fromJson(data);
      return productDetails;
    }
  }


  Future<List<ProudctDetails>> getFavoriteProducts() async {
    var response = await http.get(Uri.parse(ApiSetting.favoriteProducts),headers: {
      'Accept':'application/json',
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      'X-Requested-With': 'XMLHttpRequest',
    });
    if (response.statusCode==200) {
      var data = jsonDecode(response.body)['list'] as List;
      List<ProudctDetails> favoriteProducts = data.map((e) => ProudctDetails.fromJson(e)).toList();
      return favoriteProducts;
    }
    return [];
  }
  Future<bool> addFavoriteProducts(BuildContext context, {required int id}) async {
    var response = await http.post(
        Uri.parse(ApiSetting.favoriteProducts),
        body: {'product_id': id.toString()},
        headers: headers
    );
    if (response.statusCode==200) {
      showSnackBar(context,  message: '');
      return true;
    } else if (response.statusCode != 500) {
      showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    return false;
  }

}