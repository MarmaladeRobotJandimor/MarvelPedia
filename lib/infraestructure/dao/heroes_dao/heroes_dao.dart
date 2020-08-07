import 'package:marvelhero/core/database/database.dart';
import 'package:marvelhero/data/models/character/marvel_character.dart';
import 'package:sembast/sembast.dart';

class HeroesDao {
  static const String HEROES_STORE_NAME = 'heroes';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Fruit objects converted to Map
  final _characterStore = intMapStoreFactory.store(HEROES_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(MarvelCharacter character) async {
    await _characterStore.add(await _db, character.toJson());
  }

  Future insertAll(List<MarvelCharacter> characters) async {
    characters.forEach((characterToStore) async {
      await _characterStore.add(await _db, characterToStore.toJson());
    });
  }

  Future update(MarvelCharacter character) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(character.id));
    await _characterStore.update(
      await _db,
      character.toJson(),
      finder: finder,
    );
  }

  Future delete(MarvelCharacter character) async {
    final finder = Finder(filter: Filter.byKey(character.id));
    await _characterStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<MarvelCharacter>> get(Finder finder) async {
    // Finder object can also sort data.

    // final finder = Finder(limit: take, offset: skip);

    final recordSnapshots = await _characterStore.find(
      await _db,
      finder: finder,
    );

    // Making a List<Fruit> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final character = MarvelCharacter.fromJson(snapshot.value);
      // An ID is a key of a record from the database.
      //character.snapShotKey = snapshot.key;
      return character;
    }).toList();
  }

  Future<List<MarvelCharacter>> getAllSortedByName() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('name'),
    ]);

    final recordSnapshots = await _characterStore.find(
      await _db,
      finder: finder,
    );

    // Making a List<Fruit> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final character = MarvelCharacter.fromJson(snapshot.value);
      // An ID is a key of a record from the database.
      //character.snapShotKey = snapshot.key;
      return character;
    }).toList();
  }

  Future<int> count() async => await _characterStore.count(await _db);
}
