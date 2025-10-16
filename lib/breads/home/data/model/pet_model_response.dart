import 'package:json_annotation/json_annotation.dart';
part 'pet_model_response.g.dart';

@JsonSerializable()
class PetModelResponse {
  final String id;
  final String name;
  final String temperament;
  final String origin;
  final String description;
  @JsonKey(name: 'life_span')
  final String ageRange;
  final int intelligence;
  @JsonKey(name: 'energy_level')
  final int energyLevel;

  @JsonKey(name: 'health_issues')
  final int healthIssues;
  @JsonKey(name: 'social_needs')
  final int socialNeeds;
  @JsonKey(name: 'reference_image_id')
  final String referenceImageId;
  final Weight weight;

  const PetModelResponse(
      {required this.id,
      required this.name,
      required this.temperament,
      required this.origin,
      required this.description,
      required this.ageRange,
      required this.energyLevel,
      required this.intelligence,
      required this.healthIssues,
      required this.socialNeeds,
      required this.referenceImageId,
      required this.weight});

  factory PetModelResponse.fromJson(Map<String, dynamic> json) =>
      _$PetModelResponseFromJson(json);
}

@JsonSerializable()
class Weight {
  @JsonKey(name: 'imperial')
  final String weight;

  const Weight(this.weight);

  factory Weight.fromJson(Map<String, dynamic> json) => _$WeightFromJson(json);
}
