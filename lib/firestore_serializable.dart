import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

const firestoreSerializable = JsonSerializable(
  explicitToJson: true,
  converters: [
    FirestoreDateTimeConverter(),
    FirestoreTimestampConverter(),
    FirestoreGeoPointConverter(),
  ],
  // Use 'converters: firestoreJsonConverters,' Instead
);
