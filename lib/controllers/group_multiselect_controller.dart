import 'package:get/get.dart';

class GroupselectController extends GetxController {
  List<String> options = ["All Groups", "G1", "G2"];
  Rx<List<String>> selectedOptionList = Rx<List<String>>([]);
  var selectedOption = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
