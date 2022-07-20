import '../enums/deployment_status.dart';
import '../enums/environment.dart';
import '../enums/platform.dart';
import '../firestore_serializable.dart';
import 'product.dart';
import 'user.dart';

part 'deployment.g.dart';

@firestoreSerializable
class Deployment {
  final User user;
  final Product product;
  final DeploymentStatus status;
  final int progress;
  final Platform platform;
  final Environment environment;
  final String name;
  final String logoUrl;
}
