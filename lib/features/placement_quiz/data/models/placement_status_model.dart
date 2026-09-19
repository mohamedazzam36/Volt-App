import 'package:json_annotation/json_annotation.dart';
import 'package:volt/core/enums/app_enums.dart';

part 'placement_status_model.g.dart';

@JsonSerializable()
class PlacementStatusModel {
  @JsonKey(unknownEnumValue: PlacementStatus.unknown)
  final PlacementStatus status;
  final int? placementQuizId;
  final int? attemptId;
  final dynamic result;

  const PlacementStatusModel({
    required this.status,
    this.placementQuizId,
    this.attemptId,
    this.result,
  });

  factory PlacementStatusModel.fromJson(Map<String, dynamic> json) =>
      _$PlacementStatusModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlacementStatusModelToJson(this);
}
