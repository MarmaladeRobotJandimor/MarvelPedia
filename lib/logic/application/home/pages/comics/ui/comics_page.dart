import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelhero/infraestructure/injection_container.dart';
import 'package:marvelhero/logic/application/home/pages/comics/bloc/comics_bloc.dart';
import 'package:marvelhero/logic/application/home/pages/comics/bloc/comics_state.dart';
import 'package:marvelhero/logic/application/home/pages/comics/ui/wdigets/comics_loaded_content.dart';
import 'package:marvelhero/logic/application/shared/util/marvel_assets.dart';
import 'package:marvelhero/logic/application/shared/widgets/hero_loading.dart';

class ComicsPage extends StatefulWidget {
  @override
  _ComicsPageState createState() => _ComicsPageState();
}

class _ComicsPageState extends State<ComicsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
        create: (_) => sl.get<ComicsBloc>()..getComics(),
        child: BlocBuilder<ComicsBloc, ComicsState>(builder: (context, state) {
          if (state is ComicsUnitialized)
            return Container();
          else if (state is ComicsLoading)
            return HeroLoading(MarvelAssets.ironMan, 'Loading comics...');
          else if (state is ComicsLoaded)
            return ComicsLoadedContent(state.comics);
          else {
            var errorState = state as ComicsError;
            return Center(child: Text(errorState.errorMessage));
          }
        }));
  }

  @override
  bool get wantKeepAlive => true;
}
