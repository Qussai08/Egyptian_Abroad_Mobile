import 'package:egyptians_abroad/app/core/helper/storage_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  // init storage service
  Future<StorageService> init() async {
    await GetStorage.init();
    return this;
  }

  void setData<T>(String key, T value) {
    if(value is String){
      GetStorage().write(key, StorageHelper().encrypt(value));
    } else {
      GetStorage().write(key, value);
    }
  }

  T? getData<T>(String key) {
    T? value = GetStorage().read(key);
    if(value!=null && (value is String) && value.isNotEmpty){
      value = StorageHelper().decrypt(value) as T;
    }
    return value;
  }

  void removeData(String key) {
    GetStorage().remove(key);
  }

  void removeAll() {
    GetStorage().erase();
  }
}
