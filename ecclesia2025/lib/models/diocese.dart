class Diocese {
  final int? id;
  final String name;
  final String region;
  final String description;

  Diocese({
    this.id,
    required this.name,
    required this.region,
    required this.description,
  });

  Map<String, dynamic> toMap() => {
    'id' : id,
    'name' : name,
    'region' : region,
    'description' : description,
  };

  factory Diocese.fromMap(Map<String, dynamic> map) => Diocese (
    id: map['id'],
    name: map['name'],
    region: map['region'],
    description: map['description'],
  );
}