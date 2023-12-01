import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/core/di/setup_di.dart';
import 'package:sera_test/core/route/app_route.dart';
import 'package:sera_test/core/route/route_const.dart';
import 'package:sera_test/core/session/bloc/session/session_bloc.dart';
import 'package:sera_test/module/detail/page/detail_page.dart';
import 'package:sera_test/module/home/bloc/home_bloc.dart';
import 'package:sera_test/module/search/bloc/search_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DISetup.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SessionBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (create) => SearchBloc())
      ],
      child: MaterialApp(
        title: 'Shop IT',
        routes: AppRoute(context).routes,
        onGenerateRoute: (settings) {
          if (settings.name == RouteConst.detailRoute) {
            final args = settings.arguments;

            print("ini arg $args");

            return MaterialPageRoute(
              builder: (context) {
                return DetailPage(data: args as Product);
              },
            );
          }
          // assert(false, 'Need to implement ${settings.name}');
          return null;
        },
        initialRoute: RouteConst.loginRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
