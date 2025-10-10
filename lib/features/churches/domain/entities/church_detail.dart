class ChurchDetail {
  final int id;
  final String name;
  final String denomination;
  final String? description;
  final Address? address;
  final String? phone;
  final String? email;
  final String? website;
  final int? foundedYear;
  final int? membershipCount;
  final ServiceTimes? serviceTimes;
  final SocialMedia? socialMedia;
  final String? imageUrl;
  final bool isActive;
  final int sortOrder;
  final List<Speaker> speakers;
  final String createdAt;
  final String? updatedAt;

  const ChurchDetail({
    required this.id,
    required this.name,
    required this.denomination,
    this.description,
    this.address,
    this.phone,
    this.email,
    this.website,
    this.foundedYear,
    this.membershipCount,
    this.serviceTimes,
    this.socialMedia,
    this.imageUrl,
    this.isActive = true,
    this.sortOrder = 0,
    this.speakers = const [],
    required this.createdAt,
    this.updatedAt,
  });

  ChurchDetail copyWith({
    int? id,
    String? name,
    String? denomination,
    String? description,
    Address? address,
    String? phone,
    String? email,
    String? website,
    int? foundedYear,
    int? membershipCount,
    ServiceTimes? serviceTimes,
    SocialMedia? socialMedia,
    String? imageUrl,
    bool? isActive,
    int? sortOrder,
    List<Speaker>? speakers,
    String? createdAt,
    String? updatedAt,
  }) {
    return ChurchDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      denomination: denomination ?? this.denomination,
      description: description ?? this.description,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      foundedYear: foundedYear ?? this.foundedYear,
      membershipCount: membershipCount ?? this.membershipCount,
      serviceTimes: serviceTimes ?? this.serviceTimes,
      socialMedia: socialMedia ?? this.socialMedia,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      speakers: speakers ?? this.speakers,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Address {
  final String? street;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;

  const Address({
    this.street,
    this.city,
    this.state,
    this.zipCode,
    this.country,
  });

  String get fullAddress {
    final parts = <String>[];
    if (street != null && street!.isNotEmpty) parts.add(street!);
    if (city != null && city!.isNotEmpty) parts.add(city!);
    if (state != null && state!.isNotEmpty) parts.add(state!);
    if (zipCode != null && zipCode!.isNotEmpty) parts.add(zipCode!);
    if (country != null && country!.isNotEmpty) parts.add(country!);
    return parts.join(', ');
  }

  Address copyWith({
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? country,
  }) {
    return Address(
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
    );
  }
}

class ServiceTimes {
  final List<String>? sunday;
  final List<String>? monday;
  final List<String>? tuesday;
  final List<String>? wednesday;
  final List<String>? thursday;
  final List<String>? friday;
  final List<String>? saturday;
  final List<String>? weekdays;

  const ServiceTimes({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.weekdays,
  });

  List<String> get allServiceTimes {
    final times = <String>[];
    if (sunday != null) times.addAll(sunday!);
    if (monday != null) times.addAll(monday!);
    if (tuesday != null) times.addAll(tuesday!);
    if (wednesday != null) times.addAll(wednesday!);
    if (thursday != null) times.addAll(thursday!);
    if (friday != null) times.addAll(friday!);
    if (saturday != null) times.addAll(saturday!);
    if (weekdays != null) times.addAll(weekdays!);
    return times;
  }

  ServiceTimes copyWith({
    List<String>? sunday,
    List<String>? monday,
    List<String>? tuesday,
    List<String>? wednesday,
    List<String>? thursday,
    List<String>? friday,
    List<String>? saturday,
    List<String>? weekdays,
  }) {
    return ServiceTimes(
      sunday: sunday ?? this.sunday,
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      weekdays: weekdays ?? this.weekdays,
    );
  }
}

class SocialMedia {
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? youtube;
  final String? linkedin;

  const SocialMedia({
    this.facebook,
    this.instagram,
    this.twitter,
    this.youtube,
    this.linkedin,
  });

  List<String> get activeSocialMedia {
    final socials = <String>[];
    if (facebook != null && facebook!.isNotEmpty) socials.add('Facebook');
    if (instagram != null && instagram!.isNotEmpty) socials.add('Instagram');
    if (twitter != null && twitter!.isNotEmpty) socials.add('Twitter');
    if (youtube != null && youtube!.isNotEmpty) socials.add('YouTube');
    if (linkedin != null && linkedin!.isNotEmpty) socials.add('LinkedIn');
    return socials;
  }

  SocialMedia copyWith({
    String? facebook,
    String? instagram,
    String? twitter,
    String? youtube,
    String? linkedin,
  }) {
    return SocialMedia(
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      twitter: twitter ?? this.twitter,
      youtube: youtube ?? this.youtube,
      linkedin: linkedin ?? this.linkedin,
    );
  }
}

class Speaker {
  final int id;
  final String name;
  final String? title;
  final String? bio;
  final String? email;
  final String? phone;
  final int? yearsOfService;
  final SpeakerSocialMedia? socialMedia;
  final List<SpeakingTopic> speakingTopics;
  final int sortOrder;
  final TeachingStyle teachingStyle;
  final BibleApproach bibleApproach;
  final EnvironmentStyle environmentStyle;
  final Gender? gender;
  final String? profilePictureUrl;
  final bool isRecommended;
  final int? churchId;
  final String createdAt;
  final String? updatedAt;

  const Speaker({
    required this.id,
    required this.name,
    this.title,
    this.bio,
    this.email,
    this.phone,
    this.yearsOfService,
    this.socialMedia,
    this.speakingTopics = const [],
    this.sortOrder = 0,
    this.teachingStyle = TeachingStyle.warmAndConversational,
    this.bibleApproach = BibleApproach.balanced,
    this.environmentStyle = EnvironmentStyle.blended,
    this.gender,
    this.profilePictureUrl,
    this.isRecommended = false,
    this.churchId,
    required this.createdAt,
    this.updatedAt,
  });

  Speaker copyWith({
    int? id,
    String? name,
    String? title,
    String? bio,
    String? email,
    String? phone,
    int? yearsOfService,
    SpeakerSocialMedia? socialMedia,
    List<SpeakingTopic>? speakingTopics,
    int? sortOrder,
    TeachingStyle? teachingStyle,
    BibleApproach? bibleApproach,
    EnvironmentStyle? environmentStyle,
    Gender? gender,
    String? profilePictureUrl,
    bool? isRecommended,
    int? churchId,
    String? createdAt,
    String? updatedAt,
  }) {
    return Speaker(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      yearsOfService: yearsOfService ?? this.yearsOfService,
      socialMedia: socialMedia ?? this.socialMedia,
      speakingTopics: speakingTopics ?? this.speakingTopics,
      sortOrder: sortOrder ?? this.sortOrder,
      teachingStyle: teachingStyle ?? this.teachingStyle,
      bibleApproach: bibleApproach ?? this.bibleApproach,
      environmentStyle: environmentStyle ?? this.environmentStyle,
      gender: gender ?? this.gender,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      isRecommended: isRecommended ?? this.isRecommended,
      churchId: churchId ?? this.churchId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SpeakerSocialMedia {
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? youtube;
  final String? linkedin;

  const SpeakerSocialMedia({
    this.facebook,
    this.instagram,
    this.twitter,
    this.youtube,
    this.linkedin,
  });

  List<String> get activeSocialMedia {
    final socials = <String>[];
    if (facebook != null && facebook!.isNotEmpty) socials.add('Facebook');
    if (instagram != null && instagram!.isNotEmpty) socials.add('Instagram');
    if (twitter != null && twitter!.isNotEmpty) socials.add('Twitter');
    if (youtube != null && youtube!.isNotEmpty) socials.add('YouTube');
    if (linkedin != null && linkedin!.isNotEmpty) socials.add('LinkedIn');
    return socials;
  }

  SpeakerSocialMedia copyWith({
    String? facebook,
    String? instagram,
    String? twitter,
    String? youtube,
    String? linkedin,
  }) {
    return SpeakerSocialMedia(
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      twitter: twitter ?? this.twitter,
      youtube: youtube ?? this.youtube,
      linkedin: linkedin ?? this.linkedin,
    );
  }
}

class SpeakingTopic {
  final String name;
  final String? description;
  final SpeakingTopicCategory category;

  const SpeakingTopic({
    required this.name,
    this.description,
    required this.category,
  });

  SpeakingTopic copyWith({
    String? name,
    String? description,
    SpeakingTopicCategory? category,
  }) {
    return SpeakingTopic(
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }
}

enum TeachingStyle {
  warmAndConversational,
  calmAndReflective,
  passionateAndHighEnergy,
}

enum BibleApproach { moreScripture, moreApplication, balanced }

enum EnvironmentStyle { traditional, contemporary, blended }

enum Gender { male, female }

enum SpeakingTopicCategory {
  preaching,
  teaching,
  counseling,
  leadership,
  evangelism,
  worship,
  youth,
  marriage,
  family,
  prayer,
  other,
}
