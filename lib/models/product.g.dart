// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// CollectionGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class ProductCollectionReference
    implements
        ProductQuery,
        FirestoreCollectionReference<ProductQuerySnapshot> {
  factory ProductCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$ProductCollectionReference;

  static Product fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return _$ProductFromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Product value,
    SetOptions? options,
  ) {
    return _$ProductToJson(value);
  }

  @override
  CollectionReference<Product> get reference;

  @override
  ProductDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<ProductDocumentReference> add(Product value);
}

class _$ProductCollectionReference extends _$ProductQuery
    implements ProductCollectionReference {
  factory _$ProductCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$ProductCollectionReference._(
      firestore.collection('products').withConverter(
            fromFirestore: ProductCollectionReference.fromFirestore,
            toFirestore: ProductCollectionReference.toFirestore,
          ),
    );
  }

  _$ProductCollectionReference._(
    CollectionReference<Product> reference,
  ) : super(reference, reference);

  String get path => reference.path;

  @override
  CollectionReference<Product> get reference =>
      super.reference as CollectionReference<Product>;

  @override
  ProductDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return ProductDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<ProductDocumentReference> add(Product value) {
    return reference.add(value).then((ref) => ProductDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$ProductCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class ProductDocumentReference
    extends FirestoreDocumentReference<ProductDocumentSnapshot> {
  factory ProductDocumentReference(DocumentReference<Product> reference) =
      _$ProductDocumentReference;

  DocumentReference<Product> get reference;

  /// A reference to the [ProductCollectionReference] containing this document.
  ProductCollectionReference get parent {
    return _$ProductCollectionReference(reference.firestore);
  }

  @override
  Stream<ProductDocumentSnapshot> snapshots();

  @override
  Future<ProductDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  Future<void> update({
    String id,
    String name,
    String logoUrl,
  });

  Future<void> set(Product value);
}

class _$ProductDocumentReference
    extends FirestoreDocumentReference<ProductDocumentSnapshot>
    implements ProductDocumentReference {
  _$ProductDocumentReference(this.reference);

  @override
  final DocumentReference<Product> reference;

  /// A reference to the [ProductCollectionReference] containing this document.
  ProductCollectionReference get parent {
    return _$ProductCollectionReference(reference.firestore);
  }

  @override
  Stream<ProductDocumentSnapshot> snapshots() {
    return reference.snapshots().map((snapshot) {
      return ProductDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<ProductDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then((snapshot) {
      return ProductDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<void> delete() {
    return reference.delete();
  }

  Future<void> update({
    Object? id = _sentinel,
    Object? name = _sentinel,
    Object? logoUrl = _sentinel,
  }) async {
    final json = {
      if (id != _sentinel) "id": id as String,
      if (name != _sentinel) "name": name as String,
      if (logoUrl != _sentinel) "logoUrl": logoUrl as String,
    };

    return reference.update(json);
  }

  Future<void> set(Product value) {
    return reference.set(value);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

class ProductDocumentSnapshot extends FirestoreDocumentSnapshot {
  ProductDocumentSnapshot._(
    this.snapshot,
    this.data,
  );

  @override
  final DocumentSnapshot<Product> snapshot;

  @override
  ProductDocumentReference get reference {
    return ProductDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Product? data;
}

abstract class ProductQuery implements QueryReference<ProductQuerySnapshot> {
  @override
  ProductQuery limit(int limit);

  @override
  ProductQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  ProductQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    ProductDocumentSnapshot? startAtDocument,
    ProductDocumentSnapshot? endAtDocument,
    ProductDocumentSnapshot? endBeforeDocument,
    ProductDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  ProductQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  ProductQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  ProductQuery whereId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  ProductQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  ProductQuery whereLogoUrl({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });

  ProductQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    ProductDocumentSnapshot? startAtDocument,
    ProductDocumentSnapshot? endAtDocument,
    ProductDocumentSnapshot? endBeforeDocument,
    ProductDocumentSnapshot? startAfterDocument,
  });

  ProductQuery orderById({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    ProductDocumentSnapshot? startAtDocument,
    ProductDocumentSnapshot? endAtDocument,
    ProductDocumentSnapshot? endBeforeDocument,
    ProductDocumentSnapshot? startAfterDocument,
  });

  ProductQuery orderByName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    ProductDocumentSnapshot? startAtDocument,
    ProductDocumentSnapshot? endAtDocument,
    ProductDocumentSnapshot? endBeforeDocument,
    ProductDocumentSnapshot? startAfterDocument,
  });

  ProductQuery orderByLogoUrl({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    ProductDocumentSnapshot? startAtDocument,
    ProductDocumentSnapshot? endAtDocument,
    ProductDocumentSnapshot? endBeforeDocument,
    ProductDocumentSnapshot? startAfterDocument,
  });
}

class _$ProductQuery extends QueryReference<ProductQuerySnapshot>
    implements ProductQuery {
  _$ProductQuery(
    this.reference,
    this._collection,
  );

  final CollectionReference<Object?> _collection;

  @override
  final Query<Product> reference;

  ProductQuerySnapshot _decodeSnapshot(
    QuerySnapshot<Product> snapshot,
  ) {
    final docs = snapshot.docs.map((e) {
      return ProductQueryDocumentSnapshot._(e, e.data());
    }).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return FirestoreDocumentChange<ProductDocumentSnapshot>(
        type: change.type,
        oldIndex: change.oldIndex,
        newIndex: change.newIndex,
        doc: ProductDocumentSnapshot._(change.doc, change.doc.data()),
      );
    }).toList();

    return ProductQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  @override
  Stream<ProductQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(_decodeSnapshot);
  }

  @override
  Future<ProductQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(_decodeSnapshot);
  }

  @override
  ProductQuery limit(int limit) {
    return _$ProductQuery(
      reference.limit(limit),
      _collection,
    );
  }

  @override
  ProductQuery limitToLast(int limit) {
    return _$ProductQuery(
      reference.limitToLast(limit),
      _collection,
    );
  }

  ProductQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ProductDocumentSnapshot? startAtDocument,
    ProductDocumentSnapshot? endAtDocument,
    ProductDocumentSnapshot? endBeforeDocument,
    ProductDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(fieldPath, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ProductQuery(query, _collection);
  }

  ProductQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$ProductQuery(
      reference.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      _collection,
    );
  }

  ProductQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$ProductQuery(
      reference.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ProductQuery whereId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$ProductQuery(
      reference.where(
        _$ProductFieldMap["id"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ProductQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$ProductQuery(
      reference.where(
        _$ProductFieldMap["name"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ProductQuery whereLogoUrl({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$ProductQuery(
      reference.where(
        _$ProductFieldMap["logoUrl"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  ProductQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ProductDocumentSnapshot? startAtDocument,
    ProductDocumentSnapshot? endAtDocument,
    ProductDocumentSnapshot? endBeforeDocument,
    ProductDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(FieldPath.documentId, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ProductQuery(query, _collection);
  }

  ProductQuery orderById({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ProductDocumentSnapshot? startAtDocument,
    ProductDocumentSnapshot? endAtDocument,
    ProductDocumentSnapshot? endBeforeDocument,
    ProductDocumentSnapshot? startAfterDocument,
  }) {
    var query =
        reference.orderBy(_$ProductFieldMap["id"]!, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ProductQuery(query, _collection);
  }

  ProductQuery orderByName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ProductDocumentSnapshot? startAtDocument,
    ProductDocumentSnapshot? endAtDocument,
    ProductDocumentSnapshot? endBeforeDocument,
    ProductDocumentSnapshot? startAfterDocument,
  }) {
    var query =
        reference.orderBy(_$ProductFieldMap["name"]!, descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ProductQuery(query, _collection);
  }

  ProductQuery orderByLogoUrl({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    ProductDocumentSnapshot? startAtDocument,
    ProductDocumentSnapshot? endAtDocument,
    ProductDocumentSnapshot? endBeforeDocument,
    ProductDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy(_$ProductFieldMap["logoUrl"]!,
        descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$ProductQuery(query, _collection);
  }

  @override
  bool operator ==(Object other) {
    return other is _$ProductQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class ProductQuerySnapshot
    extends FirestoreQuerySnapshot<ProductQueryDocumentSnapshot> {
  ProductQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  final QuerySnapshot<Product> snapshot;

  @override
  final List<ProductQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<ProductDocumentSnapshot>> docChanges;
}

class ProductQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot
    implements ProductDocumentSnapshot {
  ProductQueryDocumentSnapshot._(this.snapshot, this.data);

  @override
  final QueryDocumentSnapshot<Product> snapshot;

  @override
  ProductDocumentReference get reference {
    return ProductDocumentReference(snapshot.reference);
  }

  @override
  final Product data;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product();

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{};
