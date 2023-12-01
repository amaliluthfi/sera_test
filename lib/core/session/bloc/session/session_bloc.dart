import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sera_test/common/models/profile_model.dart';
import 'package:sera_test/core/session/repo/session_repo.dart';

part 'session_state.dart';

class SessionBloc extends Cubit<SessionState> {
  final SessionRepo _sessionRepo = SessionRepo();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String? accessToken;
  String? refreshToken;
  Profile? profile;

  SessionBloc() : super(SessionInit());

  Future<void> login() async {
    try {
      emit(SessionLoading());
      var res = await _sessionRepo
          .loginRepo(data: {"email": email.text, "password": password.text});
      refreshToken = res["refresh_token"];
      accessToken = res["access_token"];
      saveToken(
          refreshToken: res["refresh_token"], accessToken: res["access_token"]);
      await getUserProfile(token: res["access_token"]);
      emit(SessionDone(successMessage: "Success login!"));
    } catch (e) {
      emit(SessionFailed(errorMessage: e.toString()));
      debugPrint(e.toString());
    }
  }

  saveToken({required String refreshToken, required String accessToken}) {
    _sessionRepo.saveAccessTokenRepo(accessToken);
    _sessionRepo.saveRefreshTokenRepo(refreshToken);
  }

  Future<void> getUserProfile({required String token}) async {
    try {
      profile = await _sessionRepo.getUserProfileRepo(token: token);
    } catch (e) {
      rethrow;
    }
  }
}
