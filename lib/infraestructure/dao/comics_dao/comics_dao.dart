import 'package:marvelhero/core/database/database.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:sembast/sembast.dart';

class ComicsDao {
  static const String COMICS_STORE_NAME = 'comics';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Fruit objects converted to Map
  final _comicStore = intMapStoreFactory.store(COMICS_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Comic comic) async {
    await _comicStore.add(await _db, comic.toJson());
  }

  Future insertAll(List<Comic> comics) async {
    comics.forEach((comicToStore) async {
      await _comicStore.add(await _db, comicToStore.toJson());
    });
  }

  Future update(Comic comic) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(comic.id));
    await _comicStore.update(
      await _db,
      comic.toJson(),
      finder: finder,
    );
  }

  Future delete(Comic comic) async {
    final finder = Finder(filter: Filter.byKey(comic.id));
    await _comicStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Comic>> get(Finder finder) async {

    final recordSnapshots = await _comicStore.find(
      await _db,
      finder: finder,
    );
    return recordSnapshots.map((snapshot) {
      final comic = Comic.fromJson(snapshot.value);
      return comic;
    }).toList();
  }

  Future<List<Comic>> getAllSortedByName() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('name'),
    ]);

    final recordSnapshots = await _comicStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final comic = Comic.fromJson(snapshot.value);
      return comic;
    }).toList();
  }
}
