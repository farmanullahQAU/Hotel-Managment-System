
import 'package:baidarg/menue_controller.dart';
import 'package:baidarg/views/home/home_controller.dart';
import 'package:baidarg/views/home/order/order_view_controller.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class Binder extends Bindings {
  @override
  void dependencies() {
    Get.put(  MenuController());
    Get.put(  HomeController());
    Get.put(  OrderViewController());








  }
}
