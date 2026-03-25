class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String originName;
  final String locationName;
  final String image;
  Character({
required this.id,
required this.name,
required this.status,
required this.species,
required this.type,
required this.gender, 
required this.originName, 
required this.locationName, 
required this.image,

  });
    factory Character.fromMap(Map<String, dynamic> m) => Character(
    id: m['id'],
    name: m['name'] ?? '',
    status: m['status'] ?? '',
    species: m['species'] ?? '',
    type: m['type'] ?? '',
    gender: m['gender'] ?? '',
    originName: (m['origin'] is Map) ? (m['origin']['name'] ?? '') : '',
    locationName: (m['location'] is Map) ? (m['location']['name'] ?? '') : '',
    image: m['image'] ?? '',
  );
   Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'type': type,
    'gender': gender,
    'originName': originName,
    'locationName': locationName,
    'image': image,
  };
   Character copyWithOverrides(Map<String, dynamic>? overrides) {
    if (overrides == null) return this;
    return Character(
      id: id,
      name: overrides['name'] ?? name,
      status: overrides['status'] ?? status,
      species: overrides['species'] ?? species,
      type: overrides['type'] ?? type,
      gender: overrides['gender'] ?? gender,
      originName: overrides['originName'] ?? originName,
      locationName: overrides['locationName'] ?? locationName,
      image: overrides['image'] ?? image,
    );
  }

}