class FavoritePet {
  final String id;
  final String name;
  final String? referenceImageId;
  final int? energyLevel;

  FavoritePet({
    required this.id,
    required this.name,
    this.referenceImageId,
    this.energyLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'reference_image_id': referenceImageId,
      'energy_level': energyLevel,
    };
  }

  factory FavoritePet.fromMap(Map<String, dynamic> map) {
    return FavoritePet(
      id: map['id'] as String,
      name: map['name'] as String,
      referenceImageId: map['reference_image_id'] as String?, 
      energyLevel: map['energy_level'] as int?,
    );
  }
}