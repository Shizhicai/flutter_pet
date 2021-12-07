import 'dart:convert';
import 'package:flutter_pet/generated/json/base/json_field.dart';
import 'package:flutter_pet/generated/json/login_entity.g.dart';

@JsonSerializable()
class LoginEntity {

	late String avatar;
	late int userId;
	late String imSign;
	late int isFirst;
	late bool isHasPassword;
	late String nickName;
	late String phone;
	late int thirdBindId;
	late String token;
	late int type;
	late String userNo;
  
  LoginEntity();

  factory LoginEntity.fromJson(Map<String, dynamic> json) => $LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => $LoginEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}