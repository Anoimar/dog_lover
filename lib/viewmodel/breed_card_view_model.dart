import 'package:doglover/data/repository/breeds_repository.dart';
import 'package:doglover/models/breed.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class BreedCardViewModel extends BaseViewModel {
  String _breedImageUrl = '';
  final Breed _breed;
  BreedsRepository _breedsRepository;
  String get breedImageUrl => _breedImageUrl;
  Breed get breed => _breed;
  final BuildContext context;

  BreedCardViewModel(this._breed, {@required this.context}) {
    _breedsRepository = Provider.of<BreedsRepository>(context);
    setSelectedImageUrl(breed.id);
  }

  void setSelectedImageUrl(int id) async {
    try {
      _breedImageUrl = await _breedsRepository.getBreedUrl(id.toString());
    } catch (e) {
      _breedImageUrl = kError;
    } finally {
      notifyListeners();
    }
  }
}
