// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:nexora/models/service.dart';
import 'package:nexora/services/booking_service.dart';
import 'package:nexora/widgets/service_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Service> _services = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    try {
      final services = await BookingService().getServices();
      setState(() {
        _services = services;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load services')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Go to profile
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _services.isEmpty
              ? Center(child: Text('No services available'))
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: _services.length,
                  itemBuilder: (context, index) {
                    final service = _services[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: ServiceCard(
                        name: service.name,
                        price: service.price,
                        imageUrl: service.imageUrl,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/booking',
                            arguments: service,
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}