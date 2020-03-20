import 'package:doglover/data/repository/breeds_repository.dart';
import 'package:doglover/models/breed.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class BreedDetailsViewModel extends BaseViewModel {
  String _selectedBreedImageUrl = '';
  Breed _selectedBreed;
  BreedsRepository _breedsRepository;
  String get selectedBreedImageUrl => _selectedBreedImageUrl;
  Breed get selectedBreed => _selectedBreed;
  final BuildContext context;

  BreedDetailsViewModel({@required this.context}) {
    _breedsRepository = Provider.of<BreedsRepository>(context);
  }

  Future<void> breedSelected(int id) async {
    if (_selectedBreed != null && id == _selectedBreed.id) {
      return;
    }
    _selectedBreedImageUrl = '';
    List<Breed> breeds = await _breedsRepository.loadBreeds();
    _selectedBreed = breeds.firstWhere((breed) => breed.id == id);
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
}
