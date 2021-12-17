import 'dart:convert';

import 'package:Modda_shop/api/api_helper.dart';
import 'package:Modda_shop/api/api_setting.dart';
import 'package:Modda_shop/models/product.dart';
import 'package:Modda_shop/models/product_details.dart';
import 'package:http/http.dart' as http;
class ProductDetailsApiController with  ApiHelper{
  Future<List< Product>> getProduct({required int id}) async {
    var response = await http.get(Uri.parse(ApiSetting.products + '$id'),headers:headers);
    if (response.statusCode==200) {
      var data = jsonDecode(response.body)['list'] as List;
      List< Product> product = data.map((e) =>  Product.fromJson(e)).toList();
      return product;
    }
    return [];
  }
  Future <ProudctDetails?> getproductdetails({required int id}) async {
    var response = await http.get(Uri.parse(ApiSetting.productDetails + '$id'),headers:headers);
    if (response.statusCode==200) {
      var data = jsonDecode(response.body)['object'];
      var productDetails = ProudctDetails.fromJson(data);
      return productDetails;
    }
  }
}