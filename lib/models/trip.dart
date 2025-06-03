class Trip {
  final int id; // ID automático
  final String imagePath;
  final String description;
  final String location;

  Trip({
    required this.id,
    required this.imagePath,
    required this.description,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'imagePath': imagePath,
        'description': description,
        'location': location,
      };

  static Trip fromJson(Map<String, dynamic> json) => Trip(
        id: json['id'],
        imagePath: json['imagePath'],
        description: json['description'],
        location: json['location'],
      );

  // Pra facilitar comparação
  bool equals(Trip other) => id == other.id;
}