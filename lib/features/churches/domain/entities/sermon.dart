class Sermon {
  final String id;
  final String title;
  final String pastorName;
  final String thumbnailUrl;
  final String duration; // e.g., "36:24"
  final bool isLive;
  final String? serviceTime; // e.g., "Sunday • 9:30"

  const Sermon({
    required this.id,
    required this.title,
    required this.pastorName,
    required this.thumbnailUrl,
    required this.duration,
    this.isLive = false,
    this.serviceTime,
  });

  Sermon copyWith({
    String? id,
    String? title,
    String? pastorName,
    String? thumbnailUrl,
    String? duration,
    bool? isLive,
    String? serviceTime,
  }) {
    return Sermon(
      id: id ?? this.id,
      title: title ?? this.title,
      pastorName: pastorName ?? this.pastorName,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      isLive: isLive ?? this.isLive,
      serviceTime: serviceTime ?? this.serviceTime,
    );
  }
}
