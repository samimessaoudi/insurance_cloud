import '../firestore_serializable.dart';

part 'release_notes.g.dart';

@firestoreSerializable
class ReleaseNotes {
  final String version;
  final DateTime releaseDate;
  final String releaseNotes;
}
