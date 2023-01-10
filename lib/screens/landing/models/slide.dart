import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/icons/why1.png',
    title: 'Personalized Learning',
    description:
        'Student Practise at their own pace, first filling in gaps in their understanding and then accelerating their learning',
  ),
  Slide(
      imageUrl: 'assets/icons/why2.png',
      title: 'Verified Lecturers',
      description:
          'Student practice at their own pace, first filling in gap in their understanding and then accelerating their learning'),
  Slide(
      imageUrl: 'assets/icons/why3.png',
      title: 'Authentic Certification',
      description:
          'Student practice at their own pace, first filling in gap in their understanding and then accelerating their learning'),
];
