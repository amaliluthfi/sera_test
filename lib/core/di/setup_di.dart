import 'package:get_it/get_it.dart';
import 'package:sera_test/common/bloc/session/session_bloc.dart';

final GetIt getIt = GetIt.instance;

class DISetup {
  static void init() {
    getIt.registerLazySingleton<SessionBloc>(() => SessionBloc());
  }
}
