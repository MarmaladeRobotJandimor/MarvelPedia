class MarvelUtil {
  static double inverserThreeRule(double a, double b) => b * 100 / a;

}

//  PaleteCollor
//   Future<HeroDetailVM> updatePaletteGenerator(String thumbnail) async {
//   PaletteGenerator paletteGenerator;
//   HeroDetailVM heroDetailVM;
//   try {
//     paletteGenerator = await PaletteGenerator.fromImageProvider(
//       CachedNetworkImageProvider(thumbnail),
//       size: Size(500.0, 500.0),
//       region: Offset.zero & Size(500.0, 500.0),
//       maximumColorCount: 70,
//     );
//   } catch (e) {
//     try {
//       paletteGenerator = await PaletteGenerator.fromImageProvider(
//         CachedNetworkImageProvider(thumbnail),
//         size: Size(100.0, 100.0),
//         region: Offset.zero & Size(100.0, 100.0),
//         maximumColorCount: 70,
//       );
//     } catch (e) {
//       return heroDetailVM;
//     }
//   }

//   if (paletteGenerator != null) {
//     if (paletteGenerator.dominantColor != null ||
//         paletteGenerator.vibrantColor != null) {
//       heroDetailVM.mainColor = paletteGenerator.dominantColor != null
//           ? paletteGenerator.dominantColor.color
//           : paletteGenerator.vibrantColor.color;
//     } else {
//       heroDetailVM.mainColor = Color.fromRGBO(17, 30, 38, 1);
//       heroDetailVM.textColor = Colors.white;
//       return heroDetailVM;
//     }

//     try {
//       var lightVibrantColorDiff = closeColor(
//           paletteGenerator.lightVibrantColor != null
//               ? paletteGenerator.lightVibrantColor.color
//               : paletteGenerator.vibrantColor.color,
//           paletteGenerator.dominantColor.color);
//       var darkMutedColorDiff = closeColor(
//           paletteGenerator.darkMutedColor != null
//               ? paletteGenerator.darkMutedColor.color
//               : paletteGenerator.mutedColor.color,
//           paletteGenerator.dominantColor.color);

//       heroDetailVM.textColor = lightVibrantColorDiff > darkMutedColorDiff
//           ? (paletteGenerator.lightVibrantColor != null
//               ? paletteGenerator.lightVibrantColor.color
//               : paletteGenerator.vibrantColor.color)
//           : (paletteGenerator.darkMutedColor != null
//               ? paletteGenerator.darkMutedColor.color
//               : paletteGenerator.mutedColor.color);
//     } catch (e) {
//       heroDetailVM.textColor =
//           paletteGenerator.dominantColor.color.computeLuminance() > 0.4
//               ? Colors.white
//               : Colors.black;
//     }
//   } else {
//     heroDetailVM.mainColor = Color.fromRGBO(17, 30, 38, 1);
//     heroDetailVM.textColor = Colors.white;
//     return heroDetailVM;
//   }

//   return heroDetailVM;
// }

// int closeColor(Color one, Color two) {
//   return (one.red - two.red).abs() +
//       (one.blue - two.blue).abs() +
//       (one.green - two.green).abs();
// }

// Wrap(
//   children: <Widget>[
//     Container(a
//         child: Text('vibrantColor'),
//         height: 60,
//         width: 100,
//         color: paletteGenerator?.vibrantColor != null
//             ? paletteGenerator.vibrantColor.color
//             : Colors.transparent),
//     Container(
//         child: Text('darkMutedColor'),
//         height: 60,
//         width: 100,
//         color: paletteGenerator?.darkMutedColor != null
//             ? paletteGenerator.darkMutedColor.color
//             : Colors.transparent),
//     Container(
//         child: Text('darkVibrantColor'),
//         height: 60,
//         width: 100,
//         color: paletteGenerator?.darkVibrantColor != null
//             ? paletteGenerator.darkVibrantColor.color
//             : Colors.transparent),
//     Container(
//         child: Text('dominantColor'),
//         height: 60,
//         width: 100,
//         color: paletteGenerator?.dominantColor != null
//             ? paletteGenerator.dominantColor.color
//             : Colors.transparent),
//     Container(
//         child: Text('lightMutedColor'),
//         height: 60,
//         width: 100,
//         color: paletteGenerator?.lightMutedColor != null
//             ? paletteGenerator.lightMutedColor.color
//             : Colors.transparent),
//     Container(
//         child: Text('lightVibrantColor'),
//         height: 60,
//         width: 100,
//         color: paletteGenerator?.lightVibrantColor != null
//             ? paletteGenerator.lightVibrantColor.color
//             : Colors.transparent),
//     Container(
//         child: Text('mutedColor'),
//         height: 60,
//         width: 100,
//         color: paletteGenerator?.mutedColor != null
//             ? paletteGenerator.mutedColor.color
//             : Colors.transparent),
//   ],
// ),



// class HeroDetailVM {
//   Size size;
//   double heightOfAppBar;
//   double imageSize;
//   Color mainColor;
//   Color textColor;

//   HeroDetailVM(
//       {size,
//       heightOfAppBar,
//       mainColor = const Color.fromRGBO(17, 30, 38, 1),
//       textColor = const Color.fromRGBO(0, 0, 0, 1),
//       imageSize});
// }
