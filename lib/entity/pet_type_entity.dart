import 'dart:convert';
import 'package:flutter_pet/generated/json/base/json_field.dart';
import 'package:flutter_pet/generated/json/pet_type_entity_entity.g.dart';

@JsonSerializable()
class PetTypeEntity {

	late String avatar;
	late String createTime;
	late String description;
	late int varietyId;
	late String index;
	late String name;
	late String type;
	late String updateTime;
  
  PetTypeEntity();

  factory PetTypeEntity.fromJson(Map<String, dynamic> json) => $PetTypeEntityFromJson(json);

  Map<String, dynamic> toJson() => $PetTypeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}