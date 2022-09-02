import 'package:get/get.dart';

class IndexSelectedController extends GetxController {
  var indexSelected = 1111111111111110.obs;

  changeValue(int newIndex) {
    indexSelected.value = newIndex;
  }
}
