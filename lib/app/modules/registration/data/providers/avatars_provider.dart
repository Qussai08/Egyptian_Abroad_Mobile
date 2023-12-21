import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/avatar_model.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/avatar_widget.dart';
import 'package:get/get.dart';

class AvatarsProvider extends GetxService {
  List<AvatarModel> avatars = List.generate(
      9, (index) => AvatarModel(index: index, isSelected: false.obs));
}
