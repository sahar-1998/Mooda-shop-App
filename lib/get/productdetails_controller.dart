
import 'package:Modda_shop/api/controller/productdetails_api_controller.dart';
import 'package:Modda_shop/models/product_details.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
class ProudctDetailsGetController extends GetxController{
  final ProductDetailsApiController productDetailsApiController = ProductDetailsApiController();
  Rx<ProudctDetails?> proudctdetails= ProudctDetails().obs;
  RxBool loading = false.obs;

  static ProudctDetailsGetController get to => Get.find();

  void onInit() {
    super.onInit();
  }

  Future<void> getproudctdetails({required int id}) async {
    loading.value = true;
    proudctdetails.value = await  productDetailsApiController.getproductdetails(id: id);
    loading.value = false;
    update();
  }
}
