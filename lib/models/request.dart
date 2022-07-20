import '../firestore_serializable.dart';
import 'product.dart';
import 'user.dart';

part 'request.g.dart';

@firestoreSerializable
class Request {
  String? id; // Stored In Firestore // Same As Server's Issue id
  Product product;
  User user; // Stored In Firestore
  String? title;
  String body;
}
