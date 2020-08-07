import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'infraestructure/injection_container.dart' as di;
import 'logic/application/home/ui/home_page.dart';
import 'logic/application/shared/styles/mainTheme.dart';
//import 'package:flutter/scheduler.dart' show timeDilation;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  //timeDilation = 5.0;
  runApp(HeroesApp());
}

class HeroesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MARVELPEDIA',
      theme: MainTheme.marvelAppTheme,
      home: HomePage(),
    );
  }
}
