import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tdd_tutorial_flutter/core/services/injection_container.dart';
import 'package:tdd_tutorial_flutter/src/auth/data/models/user_model.dart';

class DashboardUtils{
  const DashboardUtils._();

  static Stream<LocalUserModel> get userDataStream => sl<FirebaseFirestore>()
    .collection('users')
    .doc(sl<FirebaseAuth>().currentUser!.uid)
    .snapshots()
    .map((event) => LocalUserModel.fromMap(event.data()!));
}