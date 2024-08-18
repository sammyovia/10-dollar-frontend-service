import 'dart:math';

import 'package:dollar_app/features/main/home/model/home_artist_model.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeArtistProvider extends Notifier<List<HomeArtistModel>> {
  final faker = Faker.instance;

  List<HomeArtistModel> getArtist() {
    return List.generate(10, (index) {
      return HomeArtistModel(
          id: index++,
          image: faker.image.image(),
          fullName: faker.name.fullName(),
           position: faker.lorem.word(), 
           profilePic: faker.image.image(), 
           description: faker.lorem.paragraph(sentenceCount: Random().nextInt(10)), 
           stake: Random().nextInt(1000), likes: Random().nextInt(1000));
    });
  }

  @override
  List<HomeArtistModel> build() {
    return getArtist();
  }
}

final homeArtistProvider =
    NotifierProvider<HomeArtistProvider, List<HomeArtistModel>>(
        HomeArtistProvider.new);
