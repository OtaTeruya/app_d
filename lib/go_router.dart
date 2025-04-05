import 'package:app_d/capturePage/view/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'characterPage/view/character_page.dart';
import 'historyPage/view/history_page.dart';
import 'home/view/home.dart';

final goRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const Home(),
    ),
  ],
  // 遷移ページがないなどのエラーが発生した時に、このページに行く
  errorPageBuilder:
      (context, state) => MaterialPage(
        key: state.pageKey,
        child: Scaffold(body: Center(child: Text(state.error.toString()))),
      ),
);
