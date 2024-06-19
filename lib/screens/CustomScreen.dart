// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomScreen extends StatelessWidget {
  final String payload;
  const CustomScreen({
    super.key,
    required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Screen'),
      ),
      body: const Center(
        child: Text(
          'هذه شاشة مخصصة!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
