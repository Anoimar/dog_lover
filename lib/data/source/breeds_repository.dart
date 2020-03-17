import 'package:doglover/data/source/breeds_data_source.dart';
import 'package:doglover/models/breed.dart';

class BreedsRepository implements BreedsDataSource {
  final BreedsDataSource _breedsRemoteDataSource;
  List<Breed> _breeds = List();
  Map<String, String> _imageUrls = Map();

  BreedsRepository(this._breedsRemoteDataSource);

  @override
  Future<List<Breed>> loadBreeds() async {
    if (_breeds.isEmpty) {
      _breeds = await _breedsRemoteDataSource.loadBreeds();
    }
    return Future.value(_breeds);
  }

  @override
  Future<String> getBreedUrl(String id) async {
    String imageUrl = _imageUrls[id];
    if (imageUrl == null) {
      imageUrl = await _breedsRemoteDataSource.getBreedUrl(id);
      _imageUrls[id] = imageUrl;
    }
    return Future.value(imageUrl);
  }
}
