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
    GoRoute(
      path: '/capturePage',
      name: 'capturePage',
      routes: [
        GoRoute(
          path: 'captureResult',
          name: 'captureResult',
          routes: [
            GoRoute(
              path: 'mealForm',
              name: 'mealForm',
              builder: (context, state) {
                final map = state.uri.queryParameters;
                String imgPath = map['imgPath']!;
                return MealForm(imgPath: imgPath);
              },
            ),
          ],
          builder: (context, state) {
            final map = state.uri.queryParameters;
            String imgPath = map['imgPath']!;
            return CaptureResult(imgPath: imgPath);
          },
        ),
      ],
      builder: (context, state) => const CapturePage(),
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
