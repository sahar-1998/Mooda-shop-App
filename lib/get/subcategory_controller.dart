
import 'package:Modda_shop/api/controller/sub_categories_api_controller.dart';
import 'package:Modda_shop/models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SubCategoryController extends GetxController{
  final SubCategoriesApiController subcategoryApiController = SubCategoriesApiController();
  RxList<SubCategory> subcategories= <SubCategory>[].obs;
  static SubCategoryController get to => Get.find();
  void onInit() {

    super.onInit();
  }

  Future<void> getSubCategory({required int id}) async {
    subcategories.value = await SubCategoriesApiController().getSubCategory(id: id);
    update();
  }
}