import 'package:cloud_firestore_odm/annotation.dart';

import '../firestore_serializable.dart';

part 'user.g.dart';

@firestoreSerializable
class User {
  final String id; // Same As User uid In Firebase Authentication
}

@Collection<User>('users')
final usersRef = UserCollectionReference();
