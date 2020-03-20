import 'dart:collection';

import 'package:doglover/data/repository/breeds_repository.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:doglover/widgets/expanded_list/entry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/breed.dart';

class BreedsViewModel extends BaseViewModel {
  List<Breed> _breedsList = [];
  List<Entry> _breedListViewEntries = [];
  BreedsRepository _breedsRepository;
  final BuildContext context;

  bool _isFetching = false;
  bool _isError = false;
  bool get isFetching => _isFetching;

  UnmodifiableListView<Breed> get breedsList {
    return UnmodifiableListView(_breedsList);
  }

  UnmodifiableListView<Entry> get breedListViewEntries {
    return UnmodifiableListView(_breedListViewEntries);
  }

  BreedsViewModel({@required this.context}) {
    _breedsRepository = Provider.of<BreedsRepository>(context);
    initialize();
  }

  Future<void> initialize() async {
    _isFetching = true;
    notifyListeners();
    _breedsList = await _breedsRepository.loadBreeds();
    createListViewEntries();
    _isFetching = false;
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
