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
      if (json[Constant.data] is T) {
        data = json[Constant.data] as T;
      } else {
        data = _generateOBJ(json[Constant.data] as Object);
      }
    }
  }

  T? _generateOBJ(Object json) {
    print("解析数据 $json ${T.toString()}");
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<String, dynamic>') {
      print("==== Map");
      return json as T;
    } else {
      print("==== fromJsonAsT");
      return JsonConvert.fromJsonAsT<T>(json);
    }
  }
}
