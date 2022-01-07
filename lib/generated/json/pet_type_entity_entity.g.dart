import 'package:flutter_pet/generated/json/base/json_convert_content.dart';
import 'package:flutter_pet/entity/pet_type_entity.dart';

PetTypeEntity $PetTypeEntityFromJson(Map<String, dynamic> json) {
	final PetTypeEntity petTypeEntity = PetTypeEntity();
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		petTypeEntity.avatar = avatar;
	}
	final String? createTime = jsonConvert.convert<String>(json['createTime']);
	if (createTime != null) {
		petTypeEntity.createTime = createTime;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		petTypeEntity.description = description;
	}
	final int? id = jsonConvert.convert<int>(json['varietyId']);
	if (id != null) {
		petTypeEntity.varietyId = id;
	}
	final String? index = jsonConvert.convert<String>(json['index']);
	if (index != null) {
		petTypeEntity.index = index;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		petTypeEntity.name = name;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		petTypeEntity.type = type;
	}
	final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
	if (updateTime != null) {
		petTypeEntity.updateTime = updateTime;
	}
	return petTypeEntity;
}

Map<String, dynamic> $PetTypeEntityToJson(PetTypeEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['avatar'] = entity.avatar;
	data['createTime'] = entity.createTime;
	data['description'] = entity.description;
	data['varietyId'] = entity.varietyId;
	data['index'] = entity.index;
	data['name'] = entity.name;
	data['type'] = entity.type;
	data['updateTime'] = entity.updateTime;
	return data;
}