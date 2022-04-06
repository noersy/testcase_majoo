import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/utils/sqlite.dart';
import 'package:majootestcase/ui/home_bloc/home_bloc_screen.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextController();
  final _userNameController = TextController();
  final _passwordController = TextController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hallo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // color: colorBlue,
                ),
              ),
              Text(
                'Silahkan register',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 9),
              _form(),
              SizedBox(height: 50),
              CustomButton(
                text: 'Register',
                onPressed: _handleRegister,
                height: 100,
              ),
              SizedBox(height: 9),
              CustomButton(
                text: 'Back',
                isSecondary: true,
                onPressed:(){},
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            context: context,
            label: 'Username',
            hint: 'Enter username',
            controller: _userNameController,
            textInputType: TextInputType.text,
          ),
          SizedBox(height: 12.0),
          CustomTextFormField(
            context: context,
            controller: _emailController,
            hint: 'Example@123.com',
            label: 'Email',
            validator: (val) {
              final pattern = RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');

              if (val != null) {
                return pattern.hasMatch(val) ? null : 'Masukkan e-mail yang valid';
              }

              return "";
            },
            textInputType: TextInputType.emailAddress,
          ),
          SizedBox(height: 12.0),
          CustomTextFormField(
            context: context,
            label: 'Password',
            hint: 'Enter password',
            controller: _passwordController,
            isObscureText: _isObscurePassword,
            textInputType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  void _handleRegister() async {
    final _email = _emailController.value;
    final _password = _passwordController.value;
    final _username = _userNameController.value;

    if (formKey.currentState?.validate() == true && _email != null && _password != null) {
      final user = await DBLite.i.insert(User(email: _email, password: _password, userName: _username));

      if (user != null) {
        _showSnackBar("Register berhasil");
        AuthBlocCubit authBlocCubit = AuthBlocCubit();
        authBlocCubit.loginUser(user);
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => HomeBlocCubit()..fetchingData(),
              child: HomeBlocScreen(),
            ),
          ),
        );
      }
    }
    _showSnackBar("Register gagal");
  }

  void _showSnackBar(String msg) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          msg ?? "",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
