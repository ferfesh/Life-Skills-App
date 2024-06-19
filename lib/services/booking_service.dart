import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> bookCaseStudy(
      {required String name, required String phone}) async {
    try {
      await _firestore.collection('case_studies').add({
        'name': name,
        'phone': phone,
        'status': 'pending',
        'created_at': Timestamp.now(),
      });
    } catch (e) {
      throw e;
    }
  }
}
