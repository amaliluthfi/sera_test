import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sera_test/common/models/profile_model.dart';
import 'package:sera_test/common/repo/session_repo.dart';

part 'session_state.dart';

class SessionBloc extends Cubit<SessionState> {
  SessionBloc() : super(SessionInit()) {
    debugPrint("session login init");
  }

  final SessionRepo _sessionRepo = SessionRepo();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Map<String, dynamic>? token;
  Profile? profile;

  Future<void> login() async {
    try {
      emit(SessionLoading());
      var res = await _sessionRepo
          .loginRepo(data: {"email": email.text, "password": password.text});
      token = res;
      emit(SessionDone(successMessage: "Success login!"));
      debugPrint("success login: $token");
    } catch (e) {
      emit(SessionFailed(errorMessage: e.toString()));
      debugPrint(e.toString());
    }
  }
}
