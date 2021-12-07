import 'package:flutter_pet/generated/json/base/json_convert_content.dart';
import 'package:flutter_pet/entity/login_entity.dart';

LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
	final LoginEntity loginEntity = LoginEntity();
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		loginEntity.avatar = avatar;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		loginEntity.userId = userId;
	}
	final String? imSign = jsonConvert.convert<String>(json['imSign']);
	if (imSign != null) {
		loginEntity.imSign = imSign;
	}
	final int? isFirst = jsonConvert.convert<int>(json['isFirst']);
	if (isFirst != null) {
		loginEntity.isFirst = isFirst;
	}
	final bool? isHasPassword = jsonConvert.convert<bool>(json['isHasPassword']);
	if (isHasPassword != null) {
		loginEntity.isHasPassword = isHasPassword;
	}
	final String? nickName = jsonConvert.convert<String>(json['nickName']);
	if (nickName != null) {
		loginEntity.nickName = nickName;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		loginEntity.phone = phone;
	}
	final int? thirdBindId = jsonConvert.convert<int>(json['thirdBindId']);
	if (thirdBindId != null) {
		loginEntity.thirdBindId = thirdBindId;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		loginEntity.token = token;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		loginEntity.type = type;
	}
	final String? userNo = jsonConvert.convert<String>(json['userNo']);
	if (userNo != null) {
		loginEntity.userNo = userNo;
	}
	return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['avatar'] = entity.avatar;
	data['userId'] = entity.userId;
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