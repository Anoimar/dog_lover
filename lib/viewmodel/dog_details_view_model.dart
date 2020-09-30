import 'package:doglover/data/repository/dogs_repository.dart';
import 'package:doglover/models/dog.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DogDetailsViewModel extends BaseViewModel {
  String _selectedDogImageUrl = '';
  Dog _dog;
  DogsRepository _dogsRepository;
  String get selectedBreedImageUrl => _selectedDogImageUrl;
  Dog get dog => _dog;
  final BuildContext context;

  DogDetailsViewModel({@required this.context}) {
    _dogsRepository = Provider.of<DogsRepository>(context);
  }

  Future<void> dogSelected(int id) async {
    if (_dog != null) {
      return;
    }
    _dog = await _dogsRepository.getDog(id);
    _selectedDogImageUrl = _dog.picUrl;
    notifyListeners();
  }
}
