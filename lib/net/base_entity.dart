import 'package:flutter_pet/common/constant.dart';
import 'package:flutter_pet/generated/json/base/json_convert_content.dart';

class BaseEntity<T> {
  int? code;
  late String message;
  T? data;

  BaseEntity(this.code, this.message, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code];
    message = json[Constant.message];
    if (json.containsKey(Constant.data)) {
      data = _generateOBJ(json[Constant.data] as Object);
    }
  }

  T? _generateOBJ(Object json) {
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<String, dynamic>') {
      return json as T;
    } else {
      return JsonConvert.fromJsonAsT<T>(json);
    }
  }
}
