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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
            child: Column(
              children: <Widget>[
                Text(
                  'Hallo',
                  textAlign: TextAlign.start,
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
                CostumButton(
                  text: 'Register',
                  onPressed: _handleRegister,
                  height: 100,
                ),
                SizedBox(height: 9),
                CostumButton(
                  text: 'Back',
                  isSecondary: true,
                  onPressed: () => BlocProvider.of<AuthBlocCubit>(context).goToLogin(),
                  height: 100,
                ),
              ],
            ),
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
    final valid = formKey.currentState?.validate();
    BlocProvider.of<AuthBlocCubit>(context).register(_email, _password, _username, valid: valid);
  }
}
