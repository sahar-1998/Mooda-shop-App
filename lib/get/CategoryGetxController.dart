//
// import 'package:Modda_shop/api/controller/home_api_controller.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get/get.dart';
// class CategoryGetxController extends GetxController{
//   final  categoryApiController = HomeApiController();
//   final HomeApiController categoryController = HomeApiController();
//   RxList<Category> categories = <Category>[].obs;
//   RxBool loading = false.obs;
//
//   static CategoryGetxController get to => Get.find();
//
//   void onInit() {
//     getCategory();
//     super.onInit();
//   }
//
//   Future<void> getCategory() async {
//     loading.value = true;
//     categories.value = (await categoryController.getCategories()).cast<Category>();
//     loading.value = false;
//     update();
//   }
//
// }
