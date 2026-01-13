// services/booking_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexora/models/service.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all services
  Future<List<Service>> getServices() async {
    try {
      final snapshot = await _firestore.collection('services').get();
      return snapshot.docs
          .map((doc) => Service.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch services');
    }
  }

  // Create a booking
  Future<void> createBooking({
    required String serviceId,
    required String serviceName,
    required DateTime date,
    required String address,
    required double totalPrice,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      await _firestore.collection('bookings').add({
        'userId': user.uid,
        'serviceId': serviceId,
        'serviceName': serviceName,
        'date': date,
        'address': address,
        'totalPrice': totalPrice,
        'status': 'pending',
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      throw Exception('Failed to create booking');
    }
  }
}