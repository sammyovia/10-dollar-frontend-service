
import 'package:dollar_app/features/main/home/model/stake_model.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StakeProvider extends Notifier<List<StakeModel>> {
  final faker = Faker.instance;

  List<StakeModel> getStakes() {
    return List.generate(3, (index) {
      return StakeModel(
          id: index++,
          video: faker.image.image(),
          name: faker.name.firstName(),
         );
    });
  }

  @override
  List<StakeModel> build() {
    return getStakes();
  }
}

final stakeProvider =
    NotifierProvider<StakeProvider, List<StakeModel>>(
        StakeProvider.new);
