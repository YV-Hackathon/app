class Church {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double distance; // in miles, -1 for online
  final double rating; // percentage liked by attenders
  final List<String> attributes;
  final bool isOnline;

  const Church({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.distance,
    required this.rating,
    required this.attributes,
    this.isOnline = false,
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
    );
  }
}
