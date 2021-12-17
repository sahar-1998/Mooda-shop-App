import 'package:get/get.dart';
import 'package:Modda_shop/api/controller/home_api_controller.dart';
import 'package:Modda_shop/models/home_response.dart';

class HomeGetxController extends GetxController{
  HomeResponse? homeResponse;
  bool loading = false;
  final HomeApiController _apiController = HomeApiController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHome();
  }

  Future<void> getHome() async {
    loading = true;
    homeResponse = await _apiController.showHome();
    loading = false;
    update();
  }

}