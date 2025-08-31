// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDo _$ToDoFromJson(Map<String, dynamic> json) => ToDo(
      id: (json['id'] as num).toInt(),
      naziv: json['naziv'] as String? ?? "",
      opis: json['opis'] as String? ?? "",
      rok: json['rok'] as String? ?? "",
      status: $enumDecodeNullable(_$StatusAktivnostiEnumMap, json['status']) ??
          StatusAktivnosti.UToku,
      userId: (json['userId'] as num?)?.toInt(),
    )..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$ToDoToJson(ToDo instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'rok': instance.rok,
      'status': _$StatusAktivnostiEnumMap[instance.status]!,
      'userId': instance.userId,
      'user': instance.user,
    };

const _$StatusAktivnostiEnumMap = {
  StatusAktivnosti.UToku: 0,
  StatusAktivnosti.Realizovana: 1,
  StatusAktivnosti.Istekla: 2,
};
