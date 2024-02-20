import 'package:flutter_sample/demo/infinityScroll/listener_infinityScroll.dart';
import 'package:flutter_sample/demo/main_infinityScroll.dart';
import 'package:flutter_sample/demo/infinityScroll/scrollController_infinityScroll.dart';
import 'package:flutter_sample/main_home.dart';
import 'package:go_router/go_router.dart';

GoRouter mainRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => NoTransitionPage(child: MainHome()),
      routes: [
        GoRoute(
          path: 'infinityScroll',
          name: 'infinityScroll',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: MainInfinityScroll()),
          routes: [
            GoRoute(
              path: 'scrollController',
              name: 'scrollControllerInfinityScroll',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: ScrollControllerInfinifyScroll()),
            ),
            GoRoute(
              path: 'listener',
              name: 'listenerInfinityScroll',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: ListenerInfinityScroll()),
            ),
          ],
        )
      ],
    ),
  ],
);
