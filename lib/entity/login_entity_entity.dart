import 'dart:convert';
import 'package:flutter_pet/generated/json/base/json_field.dart';
import 'package:flutter_pet/generated/json/login_entity_entity.g.dart';

@JsonSerializable()
class LoginEntityEntity {

	late String avatar;
	late int id;
	late String imSign;
	late int isFirst;
	late bool isHasPassword;
	late String nickName;
	late String phone;
	late int thirdBindId;
	late String token;
	late int type;
	late String userNo;
  
  LoginEntityEntity();

  factory LoginEntityEntity.fromJson(Map<String, dynamic> json) => $LoginEntityEntityFromJson(json);

  Map<String, dynamic> toJson() => $LoginEntityEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}