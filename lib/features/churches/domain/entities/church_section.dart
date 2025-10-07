import 'church.dart';

class ChurchSection {
  final String title;
  final List<Church> churches;
  final bool showSeeAll;

  const ChurchSection({
    required this.title,
    required this.churches,
    this.showSeeAll = true,
  });

  ChurchSection copyWith({
    String? title,
    List<Church>? churches,
    bool? showSeeAll,
  }) {
    return ChurchSection(
      title: title ?? this.title,
      churches: churches ?? this.churches,
      showSeeAll: showSeeAll ?? this.showSeeAll,
    );
  }
}
