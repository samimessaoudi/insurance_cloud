// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['isPurchased'] as bool,
      json['label'] as String,
      json['caption'] as String,
      (json['platformVariants'] as List<dynamic>)
          .map((e) => PlatformProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['logoUrl'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'logoUrl': instance.logoUrl,
      'isPurchased': instance.isPurchased,
      'label': instance.label,
      'caption': instance.caption,
      'platformVariants':
          instance.platformVariants.map((e) => e.toJson()).toList(),
    };
