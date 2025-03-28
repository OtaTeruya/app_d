import 'package:app_d/capturePage/view/meal_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'HomePage/view/home_page.dart';
import 'capturePage/view/capture_page.dart';
import 'capturePage/view/capture_result.dart';
import 'characterPage/view/character_page.dart';
import 'historyPage/view/history_page.dart';

final goRouter = GoRouter(
  initialLocation: '/homePage',
  routes: [
    GoRoute(
      path: '/homePage',
      name: 'homePage',
      builder: (context, state) => const HomePage(),
    ),
    //撮影画面
    GoRoute(
      path: '/capturePage',
      name: 'capturePage',
      builder: (context, state) => const CapturePage(),
    ),
    // 撮影結果画面
    GoRoute(
      path: '/captureResult',
      name: 'captureResult',
      builder: (context, state) {
        final map = state.uri.queryParameters;
        String imgPath = map['imgPath']!;
        return CaptureResult(imgPath: imgPath);
      },
    ),
    // データベース書き込み画面
    GoRoute(
      path: '/mealForm',
      name: 'mealForm',
      builder: (context, state) {
        final map = state.uri.queryParameters;
        String imgPath = map['imgPath']!;
        String foodName = map['foodName']!;
        return MealForm(imgPath: imgPath, cuisineName: foodName);
      },
    ),

    GoRoute(
      path: '/historyPage',
      name: 'historyPage',
      builder: (context, state) => const HistoryPage(),
    ),
    GoRoute(
      path: '/characterPage',
      name: 'characterPage',
      builder: (context, state) => const CharacterPage(),
    ),
  ],
  // 遷移ページがないなどのエラーが発生した時に、このページに行く
  errorPageBuilder:
      (context, state) => MaterialPage(
        key: state.pageKey,
        child: Scaffold(body: Center(child: Text(state.error.toString()))),
      ),
);
