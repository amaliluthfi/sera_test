import 'package:flutter/material.dart';
import 'package:sera_test/core/route/route_const.dart';
import 'package:sera_test/module/detail/page/detail_page.dart';
import 'package:sera_test/module/home/page/homepage.dart';
import 'package:sera_test/module/login/page/login_page.dart';
import 'package:sera_test/module/search/pages/search_page.dart';

class AppRoute {
  AppRoute(this.context);
  final BuildContext context;

  final routes = {
    RouteConst.loginRoute: (context) => const LoginPage(),
    RouteConst.homeRoute: (context) => const MyHomePage(title: "Shop IT"),
    RouteConst.searchRoute: (context) => const SearchPage(),
    RouteConst.detailRoute: (context) => const DetailPage()
  };
}
