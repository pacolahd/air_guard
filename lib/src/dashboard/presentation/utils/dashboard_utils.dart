import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:air_guard/core/services/injection_container.dart';
import 'package:air_guard/src/auth/data/models/user_model.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<UserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => UserModel.fromMap(event.data()!));
}
