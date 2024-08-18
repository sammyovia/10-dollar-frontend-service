import 'package:dollar_app/features/main/home/model/top_artist_model.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopArtistProvider extends Notifier<List<TopArtistModel>> {
  final faker = Faker.instance;

  List<TopArtistModel> getArtist() {
    return List.generate(10, (index) {
      return TopArtistModel(
          id: index++,
          image: faker.image.image(),
          fullname: faker.name.fullName());
    });
  }

  @override
  List<TopArtistModel> build() {
    return getArtist();
  }
}

final topArtistProvider =
    NotifierProvider<TopArtistProvider, List<TopArtistModel>>(
        TopArtistProvider.new);
