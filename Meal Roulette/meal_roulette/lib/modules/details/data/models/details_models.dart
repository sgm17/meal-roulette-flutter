

class DetailsModel {
 

  final String id;
  final String title;
  final String subtitle;
  final String locationLine;
  final double rating;
  final String heroImageUrl;
  final String description;
  final String hours;
  final String peakHours;
  final String capacity;
  final String priceRange;
  final List<String> popularDishes;
  final List<String> cuisineTypes;
  final List<String> amenities;

  const DetailsModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.locationLine,
    required this.rating,
    required this.heroImageUrl,
    required this.description,
    required this.hours,
    required this.peakHours,
    required this.capacity,
    required this.priceRange,
    required this.popularDishes,
    required this.cuisineTypes,
    required this.amenities,
  });
}

// Example demo data (used by screen)
const demoCanteen = DetailsModel(
  id: 'main-campus',
  title: 'Main Campus Dining',
  subtitle: '',
  locationLine: 'Central Building, Floor 1',
  rating: 4.5,
  heroImageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
  description:
  'The largest and most diverse dining hall on campus, offering a wide variety of international cuisines. Perfect for students looking to explore different flavors and meet people from various backgrounds.',
  hours: '11:00 AM - 3:00 PM',
  peakHours: 'Peak Hours: 12:00 PM - 1:00 PM',
  capacity: 'Up to 200 students',
  priceRange: '\$ CHF 8-15',
  popularDishes: ['Pad Thai', 'Mediterranean Bowl', 'Vegetarian Curry', 'Sushi Rolls'],
  cuisineTypes: ['International', 'Asian', 'Vegetarian'],
  amenities: ['Free WiFi', 'Outdoor Seating', 'Vegan Options', 'Microwave'],
);