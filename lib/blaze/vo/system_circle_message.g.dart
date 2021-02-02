// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_circle_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemCircleMessage _$SystemCircleMessageFromJson(Map<String, dynamic> json) {
  return SystemCircleMessage(
    _$enumDecode(_$SystemCircleActionEnumMap, json['action']),
    json['circle_id'] as String,
    json['user_id'] as String,
    json['conversation_id'] as String,
  );
}

Map<String, dynamic> _$SystemCircleMessageToJson(
        SystemCircleMessage instance) =>
    <String, dynamic>{
      'action': _$SystemCircleActionEnumMap[instance.action],
      'circle_id': instance.circleId,
      'conversation_id': instance.conversationId,
      'user_id': instance.userId,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$SystemCircleActionEnumMap = {
  SystemCircleAction.create: 'CREATE',
  SystemCircleAction.delete: 'DELETE',
  SystemCircleAction.update: 'UPDATE',
  SystemCircleAction.add: 'ADD',
  SystemCircleAction.remove: 'REMOVE',
};