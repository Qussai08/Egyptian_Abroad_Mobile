import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  void setData<T>(String key, T value) {
    GetStorage().write(key, value);
  }

  T? getData<T>(String key) {
    T? value = GetStorage().read(key);
    return value;
  }

  void removeData(String key) {
    GetStorage().remove(key);
  }

  void removeAll() {
    GetStorage().erase();
  }
}
