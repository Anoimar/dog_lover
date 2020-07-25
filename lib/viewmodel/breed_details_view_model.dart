import 'package:doglover/data/repository/breeds_repository.dart';
import 'package:doglover/data/repository/favourite_repository.dart';
import 'package:doglover/models/breed.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class BreedDetailsViewModel extends BaseViewModel {
  String _selectedBreedImageUrl = '';
  Breed _selectedBreed;
  BreedsRepository _breedsRepository;
  FavouriteRepository _favouriteRepository;
  String get selectedBreedImageUrl => _selectedBreedImageUrl;
  Breed get selectedBreed => _selectedBreed;
  bool _isFav;
  bool get isFav => _isFav;
  final BuildContext context;

  BreedDetailsViewModel({@required this.context}) {
    _breedsRepository = Provider.of<BreedsRepository>(context);
    _favouriteRepository = Provider.of<FavouriteRepository>(context);
  }

  Future<void> breedSelected(int id) async {
    if (_selectedBreed != null && id == _selectedBreed.id) {
      return;
    }
    _selectedBreedImageUrl = '';
    List<Breed> breeds = await _breedsRepository.loadBreeds();
    _selectedBreed = breeds.firstWhere((breed) => breed.id == id);
    _isFav = await _favouriteRepository.isFavourite(id);
    notifyListeners();
    setSelectedImageUrl(id);
  }

  Future<void> setSelectedImageUrl(int id) async {
    try {
      _selectedBreedImageUrl =
          await _breedsRepository.getBreedUrl(id.toString());
    } catch (e) {
      _selectedBreedImageUrl = kError;
    } finally {
      notifyListeners();
    }
  }

  Future<void> favClicked() async {
    _isFav = !_isFav;
    _favouriteRepository.setFavourite(isFav, _selectedBreed);
    notifyListeners();
  }
}
