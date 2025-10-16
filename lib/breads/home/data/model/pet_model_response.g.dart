// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetModelResponse _$PetModelResponseFromJson(Map<String, dynamic> json) =>
    PetModelResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      temperament: json['temperament'] as String,
      origin: json['origin'] as String,
      description: json['description'] as String,
      ageRange: json['life_span'] as String,
      energyLevel: (json['energy_level'] as num).toInt(),
      intelligence: (json['intelligence'] as num).toInt(),
      healthIssues: (json['health_issues'] as num).toInt(),
      socialNeeds: (json['social_needs'] as num).toInt(),
      referenceImageId: json['reference_image_id'] as String,
      weight: Weight.fromJson(json['weight'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PetModelResponseToJson(PetModelResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'temperament': instance.temperament,
      'origin': instance.origin,
      'description': instance.description,
      'life_span': instance.ageRange,
      'intelligence': instance.intelligence,
      'energy_level': instance.energyLevel,
      'health_issues': instance.healthIssues,
      'social_needs': instance.socialNeeds,
      'reference_image_id': instance.referenceImageId,
      'weight': instance.weight,
    };

Weight _$WeightFromJson(Map<String, dynamic> json) => Weight(
      json['imperial'] as String,
    );

Map<String, dynamic> _$WeightToJson(Weight instance) => <String, dynamic>{
      'imperial': instance.weight,
    };
