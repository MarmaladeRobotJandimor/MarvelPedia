// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:marvelhero/data/models/character/marvel_character.dart';
// import 'package:marvelhero/logic/application/home/bloc/home_bloc.dart';
// import 'package:marvelhero/logic/application/home/bloc/home_event.dart';
// import 'package:marvelhero/logic/application/home/bloc/home_state.dart';
// import 'package:marvelhero/logic/application/home/page/home_page.dart';
// import 'package:marvelhero/logic/application/home/page/widgets/heroes_loaded.dart';
// import 'package:mockito/mockito.dart';
// import '../../../../../lib/infraestructure/injection_container.dart' as di;

// class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

// void main() {
//   HomePage homePage;
//   //ignore: close_sinks
//   HomeBloc homeBloc;

//   bool init = false;
//   group('Home Page', () {
//     setUp(() async {
//       homePage = HomePage();
//       homeBloc = MockHomeBloc();
//       if (!init) {
//         await di.init();
//       }
//       init = true;
//     });

//     tearDown(() {
//       homePage = HeroesPage();
//       homeBloc = MockHomeBloc();
//     });

//     testWidgets('Home Page initialized with Text "No hay nada" ',
//         (WidgetTester tester) async {
//       when(homeBloc.state).thenAnswer((_) => HeroesLoading());
//       await tester.pumpWidget(MaterialApp(home: homePage));
//       expect(find.text('No hay nada'), findsOneWidget);
//     });

//     // testWidgets('Home Page heroes loaded ', (WidgetTester tester) async {
//     //   when(homeBloc.state).thenAnswer((_) => HeroesLoaded(
//     //       heroes: List<MarvelCharacter>()
//     //         ..add(MarvelCharacter(1, "David", null, null))));
//     //   await tester.pumpWidget(MaterialApp(home: homePage));
//     //   expect(find.text('David'), findsOneWidget);
//     // });
//   });
// }
