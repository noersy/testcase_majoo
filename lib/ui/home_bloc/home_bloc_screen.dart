import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:majootestcase/ui/home_bloc/home_bloc_offilne_screen.dart';
import 'package:majootestcase/utils/connection.dart';

import '../../bloc/home_bloc/home_bloc_cubit.dart';
import '../extra/error_screen.dart';
import '../../utils/loading.dart';
import 'home_bloc_loaded_screen.dart';

class HomeBlocScreen extends StatefulWidget {
  const HomeBlocScreen({Key key}) : super(key: key);

  @override
  _HomeBlocScreenState createState() => _HomeBlocScreenState();
}

class _HomeBlocScreenState extends State<HomeBlocScreen> {

  StreamController connectionChangeController = StreamController.broadcast();

  @override
  void initState() {
    connectionChangeController.addStream(Connection.i.connectionChange);
    connectionChangeController.stream.listen(checkConnection);
    super.initState();
  }

  @override
  void dispose() {
    connectionChangeController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBlocCubit, HomeBlocState>(builder: (context, state) {
      return StreamBuilder(
          stream: Connection.i.connectionChange,
          builder: (context, snapshot) {

            if (state is HomeBlocLoadedState) {
              return HomeBlocLoadedScreen(data: state.data);
            } else if (state is HomeBlocLoadingState) {
              return LoadingIndicator();
            } else if (state is HomeBlocInitialState) {
              return Scaffold(
                body: Center(child: Lottie.asset('asserts/lottie/loading.json')),
              );
            } else if (state is HomeBlocErrorState) {
              return ErrorScreen(message: state.error);
            } else if (state is HomeBlocOfflineState) {
              return HomeBlocOfflineScreen();
            }
            return Center(child: Text(kDebugMode ? "state not implemented $state" : ""));
          });
    });
  }

  checkConnection(event){
    BlocProvider.of<HomeBlocCubit>(context).fetchingData();
  }
}
