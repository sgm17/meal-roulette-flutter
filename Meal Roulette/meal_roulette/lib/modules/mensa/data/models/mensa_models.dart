

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


// Example demo data (used by screen)
final demoCanteen = MensaModel(
  id: 'main-campus',
  name: 'Main Campus Dining',
  tags: '',
  location: 'Central Building, Floor 1',
  time: '11:00 AM - 3:00 PM',
  capacity: 200,
  imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
  pool: const [],
  rating: '4.5',
  description:
  'The largest and most diverse dining hall on campus, offering a wide variety of international cuisines. Perfect for students looking to explore different flavors and meet people from various backgrounds.',
  operatingHours: 'Peak Hours: 12:00 PM - 1:00 PM',
  pricing: '\$ CHF 8-15',

  popularDishes: const ['Pad Thai', 'Mediterranean Bowl', 'Vegetarian Curry', 'Sushi Rolls'],
foodVariety: const ['International', 'Asian', 'Vegetarian'],
  features: const ['Free WiFi', 'Outdoor Seating', 'Vegan Options', 'Microwave'],
);