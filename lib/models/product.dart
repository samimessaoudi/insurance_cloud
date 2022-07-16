import 'package:insurance_cloud/models/developer.dart';

import '../firestore_serializable.dart';
import 'platform_product.dart';

part 'product.g.dart';

@firestoreSerializable
class Product {
  // Demo Eligibility Thing
  final String logoUrl;
  final bool isPurchased;
  final String label;
  final String caption;
  final List<PlatformProduct> platformVariants;
  final Developer developer;
  Product(this.isPurchased, this.label, this.caption, this.platformVariants, this.logoUrl);
}
