import 'dart:collection';

import 'package:doglover/api/dog_api_service.dart';
import 'package:doglover/constants.dart';
import 'package:doglover/data/source/breeds_repository.dart';
import 'package:doglover/data/source/remote/breeds_remote_data_source.dart';
import 'package:doglover/widgets/expanded_list/entry.dart';
import 'package:flutter/cupertino.dart';

import '../models/breed.dart';

class BreedsProvider with ChangeNotifier {
  BreedsProvider() {
    initialize();
  }

  List<Breed> _breedsList = [];
  List<Entry> _breedListViewEntries = [];
  String _selectedBreedImageUrl = '';
  Breed _selectedBreed;
  BreedsRepository _breedsRepository =
      BreedsRepository(BreedsRemoteDataSource(DogApiService()));

  bool _isFetching = false;
  bool _isError = false;
  bool get isFetching => _isFetching;
  String get selectedBreedImageUrl => _selectedBreedImageUrl;
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
    _breedsList = await _breedsRepository.loadBreeds();
    createListViewEntries();
    _isFetching = false;
    notifyListeners();
  }

  void breedSelected(int id) {
    _selectedBreedImageUrl = '';
    _selectedBreed = _breedsList.firstWhere((breed) => breed.id == id);
    notifyListeners();
    setSelectedImageUrl(id);
  }

  Future<void> setSelectedImageUrl(int id) async {
    try {
      _selectedBreedImageUrl = await getBreedImageUrl(id.toString());
    } catch (e) {
      _selectedBreedImageUrl = kError;
    } finally {
      notifyListeners();
    }
  }

  List<Breed> queryResults(String query) {
    return _breedsList.where((breed) {
      List<String> words = breed.name.split(' ');
      for (String word in words) {
        if (word.toLowerCase().startsWith(query.toLowerCase().trim())) {
          return true;
        }
      }
      return false;
    }).toList();
  }

  Future<String> getBreedImageUrl(String id) async =>
      await _breedsRepository.getBreedUrl(id);

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
