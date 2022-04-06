import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/themes/spacing.dart';

class HomeBlocOfflineScreen extends StatelessWidget {
  const HomeBlocOfflineScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("You is offline"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpDims.sp22, vertical: SpDims.sp12),
            child: CustomButton(
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
