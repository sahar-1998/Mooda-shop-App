import 'dart:convert';
import 'package:Modda_shop/api/api_helper.dart';
import 'package:Modda_shop/api/api_setting.dart';
import 'package:Modda_shop/models/product_details.dart';
import 'package:http/http.dart' as http;

class SubCategoriesApiController with  ApiHelper{
  Future<List< SubCategory>> getSubCategory({required int id}) async {
    var response = await http.get(Uri.parse(ApiSetting.subCategory + '/$id'),headers: headers);
    if (response.statusCode==200) {
      var data = jsonDecode(response.body)['list'] as List;
      List< SubCategory> subCategories = data.map((e) =>  SubCategory.fromJson(e)).toList();
      return subCategories;
    }
    return [];
  }
}