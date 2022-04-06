import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/utils/constant.dart';

class HomeBlocOfflineScreen extends StatelessWidget {
  const HomeBlocOfflineScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("asserts/lottie/lost_connection.json"),
          SizedBox(height: SpDims.sp12),
          Text("Your phone is offline"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpDims.sp22, vertical: SpDims.sp12),
            child: CostumButton(
              text: "Refresh",
              onPressed: (){
                BlocProvider.of<HomeBlocCubit>(context).fetchingData();
              },
            ),
          )
        ],
      ),
    );
  }
}
