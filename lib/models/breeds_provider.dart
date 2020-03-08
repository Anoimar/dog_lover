import 'dart:collection';

import 'package:doglover/api/api_service.dart';
import 'package:doglover/widgets/expanded_list/entry.dart';
import 'package:flutter/cupertino.dart';

import 'breed.dart';

class BreedsProvider with ChangeNotifier {
  BreedsProvider() {
    initialize();
  }

  List<Breed> _breedsList = [];
  List<Entry> _breedListViewEntries = [];
  String _imageUrl = '';
  Breed _selectedBreed;

  bool _isFetching = false;
  bool _isError = false;
  bool get isFetching => _isFetching;
  String get imageUrl => _imageUrl;
  Breed get selectedBreed => _selectedBreed;

  UnmodifiableListView<Breed> get breedsList {
    return UnmodifiableListView(_breedsList);
  }

  UnmodifiableListView<Entry> get breedListViewEntries {
    return UnmodifiableListView(_breedListViewEntries);
  }

  Future<void> initialize() async {
    _isFetching = true;
    notifyListeners();
    _breedsList = await ApiService().getBreeds();
    createListViewEntries();
    _isFetching = false;
    notifyListeners();
  }

  void breedSelected(int id) {
    _imageUrl = '';
    _selectedBreed = _breedsList.firstWhere((breed) => breed.id == id);
    notifyListeners();
    getBreedImageUrl(id.toString());
  }

  Future<void> getBreedImageUrl(String id) async {
    _imageUrl = await ApiService().getBreedImageUrl(id);
    notifyListeners();
  }

  void createListViewEntries() {
    List<String> groups =
        _breedsList.map((breed) => breed.group).toSet().toList();
    groups.sort((first, second) => first.compareTo(second));
    for (String group in groups) {
      List<Entry> breedEntriesInGroup = _breedsList
          .where((breed) => breed.group == group)
          .toList()
          .map((breedInGroup) => Entry(breedInGroup.name, breedInGroup.id))
          .toList();
      _breedListViewEntries.add(Entry(group, 0, breedEntriesInGroup));
    }
  }
}
