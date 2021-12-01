import 'package:flutter_pet/generated/json/base/json_convert_content.dart';
import 'package:flutter_pet/entity/user_info_entity_entity.dart';

UserInfoEntityEntity $UserInfoEntityEntityFromJson(Map<String, dynamic> json) {
	final UserInfoEntityEntity userInfoEntityEntity = UserInfoEntityEntity();
	final int? age = jsonConvert.convert<int>(json['age']);
	if (age != null) {
		userInfoEntityEntity.age = age;
	}
	final String? area = jsonConvert.convert<String>(json['area']);
	if (area != null) {
		userInfoEntityEntity.area = area;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		userInfoEntityEntity.avatar = avatar;
	}
	final String? background = jsonConvert.convert<String>(json['background']);
	if (background != null) {
		userInfoEntityEntity.background = background;
	}
	final String? birthday = jsonConvert.convert<String>(json['birthday']);
	if (birthday != null) {
		userInfoEntityEntity.birthday = birthday;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		userInfoEntityEntity.city = city;
	}
	final String? constellation = jsonConvert.convert<String>(json['constellation']);
	if (constellation != null) {
		userInfoEntityEntity.constellation = constellation;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		userInfoEntityEntity.id = id;
	}
	final String? nickName = jsonConvert.convert<String>(json['nickName']);
	if (nickName != null) {
		userInfoEntityEntity.nickName = nickName;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		userInfoEntityEntity.phone = phone;
	}
	final String? province = jsonConvert.convert<String>(json['province']);
	if (province != null) {
		userInfoEntityEntity.province = province;
	}
	final int? sex = jsonConvert.convert<int>(json['sex']);
	if (sex != null) {
		userInfoEntityEntity.sex = sex;
	}
	final String? signature = jsonConvert.convert<String>(json['signature']);
	if (signature != null) {
		userInfoEntityEntity.signature = signature;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		userInfoEntityEntity.type = type;
	}
	final String? userNo = jsonConvert.convert<String>(json['userNo']);
	if (userNo != null) {
		userInfoEntityEntity.userNo = userNo;
	}
	return userInfoEntityEntity;
}

Map<String, dynamic> $UserInfoEntityEntityToJson(UserInfoEntityEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['age'] = entity.age;
	data['area'] = entity.area;
	data['avatar'] = entity.avatar;
	data['background'] = entity.background;
	data['birthday'] = entity.birthday;
	data['city'] = entity.city;
	data['constellation'] = entity.constellation;
	data['id'] = entity.id;
	data['nickName'] = entity.nickName;
	data['phone'] = entity.phone;
	data['province'] = entity.province;
	data['sex'] = entity.sex;
	data['signature'] = entity.signature;
	data['type'] = entity.type;
	data['userNo'] = entity.userNo;
	return data;
}