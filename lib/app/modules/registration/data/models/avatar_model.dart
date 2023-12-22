import 'package:get/get.dart';

class AvatarModel {
  AvatarModel({required this.index, required this.isSelected});
  int index;
  RxBool isSelected = false.obs;
}
