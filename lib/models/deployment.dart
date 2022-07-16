import 'package:insurance_cloud/enums/deployment_status.dart';
import 'package:insurance_cloud/enums/environment.dart';
import 'package:insurance_cloud/models/platform_product.dart';
import 'package:insurance_cloud/models/product.dart';

import '../firestore_serializable.dart';
import 'user.dart';

@firestoreSerializable
class Deployment {
  final User user;
  final Environment environment;
  final PlatformProduct platformProduct;
  final DeploymentStatus deploymentStatus;
}
