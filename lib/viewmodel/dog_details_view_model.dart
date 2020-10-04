import 'package:doglover/data/repository/dogs_repository.dart';
import 'package:doglover/models/dog.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DogDetailsViewModel extends BaseViewModel {
  String _selectedDogImageUrl = '';
  Dog _dog;
  DogsRepository _dogsRepository;
  String get selectedBreedImageUrl => _selectedDogImageUrl;
  Dog get dog => _dog;
  final BuildContext context;
  ViewState _viewState = ViewState.content;

  ViewState get viewState => _viewState;

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

  Future<bool> deleteDogPic() async {
    _viewState = ViewState.loading;
    var result = await _dogsRepository.deleteDog(_dog.id);
    return result;
  }
}
