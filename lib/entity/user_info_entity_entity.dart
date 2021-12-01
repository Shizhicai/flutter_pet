import 'dart:convert';
import 'package:flutter_pet/generated/json/base/json_field.dart';
import 'package:flutter_pet/generated/json/user_info_entity_entity.g.dart';

@JsonSerializable()
class UserInfoEntityEntity {

	late int age;
	late String area;
	late String avatar;
	late String background;
	late String birthday;
	late String city;
	late String constellation;
	late int id;
	late String nickName;
	late String phone;
	late String province;
	late int sex;
	late String signature;
	late int type;
	late String userNo;
  
  UserInfoEntityEntity();

  factory UserInfoEntityEntity.fromJson(Map<String, dynamic> json) => $UserInfoEntityEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoEntityEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}