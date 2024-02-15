import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial_flutter/core/res/media_res.dart';

class PageContent extends Equatable{
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContent.first() : this(
    image: MediaRes.casual_reading,
    title: 'Brand new curriculum',
    description: "This is the first online education platform desgined by the world's top professor",
  );

   const PageContent.second() : this(
    image: MediaRes.casual_life,
    title: 'A fun atmosphere',
    description: "This is the first online education platform desgined by the world's top professor",
  );

   const PageContent.third() : this(
    image: MediaRes.casual_meditation_science,
    title: 'Easy to join the lesson ',
    description: "This is the first online education platform desgined by the world's top professor",
  );

  final String image;
  final String title;
  final String description;
  
  @override
  List<Object?> get props => [image, title, description];
}