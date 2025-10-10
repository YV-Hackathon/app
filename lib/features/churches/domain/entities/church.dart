import 'church_detail.dart';

class Church {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double distance; // in miles, -1 for online
  final double rating; // percentage liked by attenders
  final List<String> attributes;
  final bool isOnline;
  final double? compatibilityScore;
  final List<String> recommendationReasons;

  const Church({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.distance,
    required this.rating,
    required this.attributes,
    this.isOnline = false,
    this.compatibilityScore,
    this.recommendationReasons = const [],
  });

  String get distanceText {
    if (isOnline) return 'Online';
    return '${distance.toStringAsFixed(1)} miles';
  }

  String get ratingText {
    return 'Liked by ${rating.toInt()}% of attenders';
  }

  Church copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? distance,
    double? rating,
    List<String>? attributes,
    bool? isOnline,
    double? compatibilityScore,
    List<String>? recommendationReasons,
  }) {
    return Church(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      attributes: attributes ?? this.attributes,
      isOnline: isOnline ?? this.isOnline,
      compatibilityScore: compatibilityScore ?? this.compatibilityScore,
      recommendationReasons:
          recommendationReasons ?? this.recommendationReasons,
    );
  }

  /// Creates a Church entity from a ChurchDetail entity
  /// This is useful for converting detailed church data to the simplified church list format
  factory Church.fromChurchDetail(
    ChurchDetail churchDetail, {
    double distance = 0.0,
    double rating = 0.0,
    List<String> attributes = const [],
    bool isOnline = false,
    double? compatibilityScore,
    List<String> recommendationReasons = const [],
  }) {
    return Church(
      id: churchDetail.id.toString(),
      name: churchDetail.name,
      description: churchDetail.description ?? '',
      imageUrl: churchDetail.imageUrl ?? '',
      distance: distance,
      rating: rating,
      attributes: attributes,
      isOnline: isOnline,
      compatibilityScore: compatibilityScore,
      recommendationReasons: recommendationReasons,
    );
  }
}
