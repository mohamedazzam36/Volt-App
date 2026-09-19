// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placement_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacementStatusModel _$PlacementStatusModelFromJson(
  Map<String, dynamic> json,
) => PlacementStatusModel(
  status: $enumDecode(
    _$PlacementStatusEnumMap,
    json['status'],
    unknownValue: PlacementStatus.unknown,
  ),
  placementQuizId: (json['placementQuizId'] as num?)?.toInt(),
  attemptId: (json['attemptId'] as num?)?.toInt(),
  result: json['result'],
);

Map<String, dynamic> _$PlacementStatusModelToJson(
  PlacementStatusModel instance,
) => <String, dynamic>{
  'status': _$PlacementStatusEnumMap[instance.status]!,
  'placementQuizId': instance.placementQuizId,
  'attemptId': instance.attemptId,
  'result': instance.result,
};

const _$PlacementStatusEnumMap = {
  PlacementStatus.required: 'Required',
  PlacementStatus.optional: 'Optional',
  PlacementStatus.inProgress: 'InProgress',
  PlacementStatus.completed: 'Completed',
  PlacementStatus.unavailable: 'Unavailable',
  PlacementStatus.unknown: 'unknown',
};
