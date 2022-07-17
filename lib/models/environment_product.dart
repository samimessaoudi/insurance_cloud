import 'package:insurance_cloud/enums/environment.dart';

import '../firestore_serializable.dart';
import 'product.dart';

@firestoreSerializable
class EnvironmentProduct {
  final Environment environment;
  final Product product;
}
