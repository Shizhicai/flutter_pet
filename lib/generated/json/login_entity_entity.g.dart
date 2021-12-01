import 'package:flutter_pet/generated/json/base/json_convert_content.dart';
import 'package:flutter_pet/entity/login_entity_entity.dart';

LoginEntityEntity $LoginEntityEntityFromJson(Map<String, dynamic> json) {
	final LoginEntityEntity loginEntityEntity = LoginEntityEntity();
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		loginEntityEntity.avatar = avatar;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		loginEntityEntity.id = id;
	}
	final String? imSign = jsonConvert.convert<String>(json['imSign']);
	if (imSign != null) {
		loginEntityEntity.imSign = imSign;
	}
	final int? isFirst = jsonConvert.convert<int>(json['isFirst']);
	if (isFirst != null) {
		loginEntityEntity.isFirst = isFirst;
	}
	final bool? isHasPassword = jsonConvert.convert<bool>(json['isHasPassword']);
	if (isHasPassword != null) {
		loginEntityEntity.isHasPassword = isHasPassword;
	}
	final String? nickName = jsonConvert.convert<String>(json['nickName']);
	if (nickName != null) {
		loginEntityEntity.nickName = nickName;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		loginEntityEntity.phone = phone;
	}
	final int? thirdBindId = jsonConvert.convert<int>(json['thirdBindId']);
	if (thirdBindId != null) {
		loginEntityEntity.thirdBindId = thirdBindId;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		loginEntityEntity.token = token;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		loginEntityEntity.type = type;
	}
	final String? userNo = jsonConvert.convert<String>(json['userNo']);
	if (userNo != null) {
		loginEntityEntity.userNo = userNo;
	}
	return loginEntityEntity;
}

Map<String, dynamic> $LoginEntityEntityToJson(LoginEntityEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['avatar'] = entity.avatar;
	data['id'] = entity.id;
	data['imSign'] = entity.imSign;
	data['isFirst'] = entity.isFirst;
	data['isHasPassword'] = entity.isHasPassword;
	data['nickName'] = entity.nickName;
	data['phone'] = entity.phone;
	data['thirdBindId'] = entity.thirdBindId;
	data['token'] = entity.token;
	data['type'] = entity.type;
	data['userNo'] = entity.userNo;
	return data;
}