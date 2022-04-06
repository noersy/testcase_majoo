import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/trandings.dart';
import 'package:majootestcase/services/api_service.dart';
import 'package:majootestcase/utils/connection.dart';

part 'home_bloc_state.dart';

class HomeBlocCubit extends Cubit<HomeBlocState> {
  HomeBlocCubit() : super(HomeBlocInitialState());

  void fetchingData() async {
    emit(HomeBlocInitialState());
    ApiServices apiServices = ApiServices();
    if (!(await Connection.i.checkConnection())) {
      emit(HomeBlocOfflineState());
      return;
    }

    Trending trending = await apiServices.getMovieList();
    if (trending == null) {
      emit(HomeBlocErrorState("Error Unknown"));
    } else {
      emit(HomeBlocLoadedState(trending));
    }
  }
}
