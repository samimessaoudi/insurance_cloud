import 'package:cloud_firestore_odm/annotation.dart';
import 'package:insurance_cloud/models/deployment.dart';

import '../firestore_serializable.dart';

part 'user.g.dart';

@firestoreSerializable
class User {
  final String uid;
}

@Collection<User>('users')
final usersRef = UserCollectionReference();
