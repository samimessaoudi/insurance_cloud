import 'package:insurance_cloud/firestore_serializable.dart';
import 'package:insurance_cloud/models/bill.dart';

import '../enums/payment_status.dart';

part 'payment.g.dart';

@firestoreSerializable
class Payment {
  final Bill bill;
  final DateTime date;
  final PaymentStatus status;
}
