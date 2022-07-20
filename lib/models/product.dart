import 'package:cloud_firestore_odm/annotation.dart';

import '../enums/platform.dart';
import '../firestore_serializable.dart';
import 'release_notes.dart';

part 'product.g.dart';

@firestoreSerializable
class Product {
  // Demo Eligibility Thing According To Previous Product Deployments, Nothing To Add Here
  // No Developer Entity Cuz One Dev Per Platform
  final String id;
  final String name;
  final String logoUrl;
  final List<Platform> platforms;
  final List<ReleaseNotes> releasesNotes;
}

@Collection<Product>('products')
final productsRef = ProductCollectionReference();
