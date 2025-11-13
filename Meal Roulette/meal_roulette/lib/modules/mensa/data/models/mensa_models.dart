

class MensaModel {
  final String id;
  final String name;
  final String tags;
  final String location;
  final String time;
  final int capacity;
  final String imageUrl;
  final List<String> pool;       // Array of user IDs or references
  final bool isJoined;

  MensaModel({
    required this.id,
    required this.name,
    required this.tags,
    required this.location,
    required this.time,
    required this.capacity,
    required this.imageUrl,
    required this.pool,
    required this.isJoined,
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
      isJoined: data['isJoined'] ?? false,
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
      'isJoined': isJoined,
    };
  }
}