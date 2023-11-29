import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera_test/common/bloc/session/session_bloc.dart';
import 'package:sera_test/core/di/setup_di.dart';
import 'package:sera_test/core/route/route_const.dart';
import 'package:sera_test/module/login/widgets/custom_form_field.dart';

import '../../../common/widgets/spacer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SessionBloc sessionBloc = getIt<SessionBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            "Log in",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        body: BlocConsumer<SessionBloc, SessionState>(
            bloc: sessionBloc,
            listener: (contex, state) {
              if (state is SessionFailed) {}
              if (state is SessionDone) {
                Navigator.of(context).pushNamed(RouteConst.homeRoute);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SpaceH16(),
                        CustomFormField(
                          label: "email",
                          controller: sessionBloc.email,
                        ),
                        const SpaceH8(),
                        CustomFormField(
                          label: "password",
                          controller: sessionBloc.password,
                        ),
                        const SpaceH16(),
                        ElevatedButton(
                          onPressed: () {
                            sessionBloc.login();
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.sizeOf(context).width / 1, 30)),
                          child: const Text(
                            "Log in",
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}