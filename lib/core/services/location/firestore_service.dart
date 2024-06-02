import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FireStoreService {
  static final fireStore = FirebaseFirestore.instance;

  static Future<void> updateUserLocation(String ambulanceId, LatLng location) async {
    try {
     await fireStore.collection('Ambulances').doc(ambulanceId).set({
        'location': {'lat': location.latitude, 'lng': location.longitude},
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      debugPrint('An error due to Firebase occurred: $e');
    } catch (err) {
      debugPrint('An Firebase occurred: $err');
    }
  }

  // static Stream<List<User>> userCollectionStream() {
  //   return _firestore.collection('users').snapshots().map((snapshot) =>
  //       snapshot.docs.map((doc) => User.fromMap(doc.data())).toList());
  // }
}