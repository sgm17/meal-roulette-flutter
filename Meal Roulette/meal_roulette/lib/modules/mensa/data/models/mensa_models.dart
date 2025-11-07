


class MensaModel {
  final String id;
  final String name;
  final String tags;
  final String location;
  final String time;
  final int capacity;
  final String imageUrl;

  MensaModel({
    required this.id,
    required this.name,
    required this.tags,
    required this.location,
    required this.time,
    required this.capacity,
    required this.imageUrl,
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
    };
  }
}