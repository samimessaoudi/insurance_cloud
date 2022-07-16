import '../firestore_serializable.dart';

@firestoreSerializable
class ReleaseNotes {
  // Per Platform
  final String version;
  final DateTime date;
  final String notes;
  ReleaseNotes(this.version, this.date, this.notes);
}
