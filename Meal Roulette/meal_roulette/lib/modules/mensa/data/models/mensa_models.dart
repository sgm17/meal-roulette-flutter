

class MensaModel {
  final String id;
  final String name;
  final String tags;
  final String location;
  final String time;
  final int capacity;
  final String imageUrl;
  final List<String> pool;       // Array of user IDs or references

  final String rating;
  final String operatingHours;
  final String pricing;
  final String description;

  final List<String> foodVariety;
  final List<String> popularDishes;
  final List<String> features;


  MensaModel( {
    required this.id,
    required this.name,
    required this.tags,
    required this.location,
    required this.time,
    required this.capacity,
    required this.imageUrl,
    required this.pool,
    required this.rating, required this.operatingHours, required this.pricing, required this.description, required this.foodVariety, required this.popularDishes, required this.features,
  });

  factory MensaModel.fromMap(Map<String, dynamic> data, String documentId) {
    return MensaModel(
      id: documentId,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      tags: data['tags'] ?? '',
      time: data['time'] ?? '',
      capacity: data['capacity'] ?? 0,
      imageUrl: data['imageUrl'] ?? '',
      pool: data['pool'] != null
          ? List<String>.from(data['pool'])
          : <String>[],

      rating: data['rating'] ?? '',
      operatingHours: data['operatingHours'] ?? '',
      pricing: data['pricing'] ?? '',
      description: data['description'] ?? '',
      foodVariety: data['foodVariety'] != null
          ? List<String>.from(data['foodVariety'])
          : <String>[],
      popularDishes: data['popularDishes'] != null
          ? List<String>.from(data['popularDishes'])
          : <String>[],
      features: data['features'] != null
          ? List<String>.from(data['features'])
          : <String>[],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'tags': tags,
      'time': time,
      'capacity': capacity,
      'imageUrl': imageUrl,
      'pool': pool,

      'rating': pool,
      'operatingHours': pool,
      'pricing': pool,
      'description': pool,
      'foodVariety': pool,
      'popularDishes': pool,
      'features': pool,

    };
  }
}