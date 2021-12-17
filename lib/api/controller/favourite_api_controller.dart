import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Modda_shop/api/api_helper.dart';
import 'package:Modda_shop/api/api_setting.dart';
import 'package:Modda_shop/models/product_details.dart';

class  FavoriteProductApiController  with  ApiHelper{

  Future<List<ProudctDetails>> getFavoriteProducts() async {
    var url = Uri.parse(ApiSetting.favoriteProducts);
    var response = await http.get(url,headers: headers);
    if (response.statusCode==200) {
      var data = jsonDecode(response.body)['list'] as List;
      List<ProudctDetails> favoriteProducts = data.map((e) => ProudctDetails.fromJson(e)).toList();
      return favoriteProducts;
    }
    return [];
  }


  Future<bool> addFavoriteProducts(BuildContext context, {required int id}) async {
    var url = Uri.parse(ApiSetting.favoriteProducts);
    var response = await http.post(
        url,
        body: {'product_id': id.toString()},
        headers: headers
    );
    if (response.statusCode==200) {
      showSnackBar(context,  message: 'Added successfully');
      return true;
    } else if (response.statusCode != 500) {
      showSnackBar(context, error: true, message: 'Failed to Added');
    }
    return false;
  }

}