import 'dart:async';

import 'package:doglover/data/dao/favourite_dao.dart';
import 'package:doglover/models/breed.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Breed])
abstract class AppDatabase extends FloorDatabase {
  FavBreedDao get favBreedDao;
}
