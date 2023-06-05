// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class offerModel {
  String? image;
  offerModel({
    this.image,
  });

  offerModel copyWith({
    String? image,
  }) {
    return offerModel(
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
    };
  }

  factory offerModel.fromMap(Map<String, dynamic> map) {
    return offerModel(
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory offerModel.fromJson(String source) =>
      offerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'offer(image: $image)';

  @override
  bool operator ==(covariant offerModel other) {
    if (identical(this, other)) return true;

    return other.image == image;
  }

  @override
  int get hashCode => image.hashCode;
}
