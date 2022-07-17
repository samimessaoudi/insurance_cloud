import 'package:insurance_cloud/models/product.dart';

import '../enums/product_platform.dart';
import '../firestore_serializable.dart';
import 'release_notes.dart';

@firestoreSerializable
class PlatformProduct {
  final ProductPlatform platform;
  final Product product;
  final List<ReleaseNotes> releasesNotes;

  PlatformProduct(this.platform, this.releasesNotes);
}
