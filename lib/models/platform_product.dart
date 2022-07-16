import 'package:insurance_cloud/models/product.dart';

import '../enums/platform.dart';
import '../firestore_serializable.dart';
import 'release_notes.dart';

@firestoreSerializable
class PlatformProduct {
  final Platform platform;
  final Product product;
  final List<ReleaseNotes> releasesNotes;

  PlatformProduct(this.platform, this.releasesNotes);
}
