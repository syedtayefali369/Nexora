// models/service.dart
class Service {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  Service({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  // Convert from Firestore document
  factory Service.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Service(
      id: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}