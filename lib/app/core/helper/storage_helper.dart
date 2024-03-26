import 'package:encrypt/encrypt.dart';
import 'package:convert/convert.dart';

class StorageHelper{

  late final Key _key;
  final IV _iv = IV.fromLength(16);
  late final Encrypter _encrypter;
  static final StorageHelper _storageHelper = StorageHelper._internal();

  factory StorageHelper() {
    return _storageHelper;
  }

  StorageHelper._internal(){
    String hexString = hex.encode([67, 79, 80, 45, 103, 53, 48, 48, 56, 97, 52,
      101, 52, 49, 48, 51, 98, 98, 99, 101, 50, 101, 97, 50, 48, 49, 53, 97,
      49, 57, 48, 53]);
    List<String> splitted = [];
    for (int i = 0; i < hexString.length; i = i + 2) {
      splitted.add(hexString.substring(i, i + 2));
    }
    String ascii = List.generate(splitted.length,
            (i) => String.fromCharCode(int.parse(splitted[i], radix: 16))).join();
    _key = Key.fromUtf8(ascii);
    _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
  }

  String encrypt(String text) => _encrypter.encrypt(text, iv: _iv).base64;

  String decrypt(String text) => _encrypter.decrypt(Encrypted.fromBase64(text), iv: _iv);
}
