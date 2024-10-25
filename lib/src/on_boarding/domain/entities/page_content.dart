import 'package:equatable/equatable.dart';
import 'package:air_guard/core/resources/media_resources.dart';

// lib/src/on_boarding/domain/entities/page_content.dart

// lib/src/on_boarding/domain/entities/page_content.dart

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
  });

  const PageContent.first()
      : this(
          image: MediaRes.onboarding1, // Replace with your custom image
          title: 'Track Air Pollution Levels',
        );

  const PageContent.second()
      : this(
          image: MediaRes.onboarding2, // Replace with your custom image
          title: 'Emergency Alerts & Notifications',
        );

  const PageContent.third()
      : this(
          image: MediaRes.onboarding3, // Replace with your custom image
          title: 'Connect Your Air Quality Monitor',
        );

  final String image;
  final String title;

  @override
  List<Object?> get props => [image, title];
}
