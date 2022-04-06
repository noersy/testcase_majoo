import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/utils/sqlite.dart';
import 'package:majootestcase/ui/home_bloc/home_bloc_screen.dart';
import 'package:majootestcase/ui/register/register_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextController();
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
      body: Padding(
        padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    // color: colorBlue,
                  ),
                ),
                Text(
                  'Silahkan login terlebih dahulu',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                _form(),
                SizedBox(
                  height: 50,
                ),
                CostumButton(
                  text: 'Login',
                  onPressed: _handleLogin,
                  height: 100,
                ),
                SizedBox(
                  height: 12.0,
                ),
                _register(),
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
        mainAxisSize: MainAxisSize.min,
        children: [
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
            hint: 'password',
            controller: _passwordController,
            isObscureText: _isObscurePassword,
            textInputType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget _register() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => BlocProvider.of<AuthBlocCubit>(context).goToRegister(),
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyText2,
            text: 'Belum punya akun?',
            children: [
              TextSpan(
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Theme.of(context).primaryColor),
                text: ' Daftar',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    formKey.currentState?.validate();
    BlocProvider.of<AuthBlocCubit>(context).loginUser(_emailController.value, _passwordController.value);
  }
}
