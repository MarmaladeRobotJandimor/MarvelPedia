import 'package:flutter_test/flutter_test.dart';
import 'package:marvelhero/remote/characters/characters_api_service.dart';

void main() {
  CharactersMarvelApiService characterMavelApiServiceMock;

  setUp(() {
    characterMavelApiServiceMock = CharactersMarvelApiService();
  });

  group('Characters Api ', () {
    test('Get Characters', () async {
      //arrange
      int take = 10;

      // Act
      var characters =
          await characterMavelApiServiceMock.getCharacters(take, 0);

      //arrange
      expect(characters, isNotNull);
      expect(characters, isNotEmpty);
      expect(characters.length, equals(take));
    });

    test('Get Comcis for a Character', () async {
      //arrange
      int characterId = 10;

      // Act
      var comics =
          await characterMavelApiServiceMock.getCharacterComics(characterId,20,0);

      //arrange
      expect(comics, isNotNull);
      expect(comics.results, isNotNull);
    });
  });
}
