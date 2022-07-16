import 'package:insurance_cloud/models/product.dart';
import 'package:uuid/uuid.dart';

import '../firestore_serializable.dart';

part 'request.g.dart';

@firestoreSerializable
class Request {
  String id = const Uuid().v1();
  String? title;
  String? description;
  Product? product;

  Request();

  Request.fromFirestore({required this.id, this.title, this.description});
}
