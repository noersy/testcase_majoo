
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  SharedPreferences sharedPreferences;
  User _user;

  getPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _user = User.fromJson(jsonDecode(sharedPreferences.getString('user_value')));
    print(_user.toJson());
    setState(() {});
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        semanticLabel: "Menu",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: SpDims.sp20),
                  Padding(
                    padding: const EdgeInsets.all(SpDims.sp8),
                    child: CircleAvatar(
                      radius: 60,
                      child: Icon(Icons.person,size: 70),
                    ),
                  ),
                  Text(_user?.userName ?? 'none', style: Theme.of(context).textTheme.title),
                  Text(_user?.email ?? 'none', style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(SpDims.sp8),
              child: CostumButton(
                text: 'Logout',
                onPressed: () {
                  BlocProvider.of<AuthBlocCubit>(context).logout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
