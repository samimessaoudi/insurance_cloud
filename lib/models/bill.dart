import 'package:insurance_cloud/firestore_serializable.dart';
import 'package:insurance_cloud/models/product.dart';
import 'package:insurance_cloud/models/user.dart';

part 'bill.g.dart';

@firestoreSerializable
class Bill {
  final User user;
  final Product product;
  final double amount;
  final DateTime dueDate;
}
