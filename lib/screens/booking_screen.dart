import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/booking_service.dart';

class BookingScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bookingService = Provider.of<BookingService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Case Study'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await bookingService.bookCaseStudy(
                    name: _nameController.text,
                    phone: _phoneController.text,
                  );
                  // Show success message
                } catch (e) {
                  // Handle error
                }
              },
              child: Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
