import 'package:flutter_sample/page/infinityScroll/FlatList_InfinityScrll.dart';
import 'package:flutter_sample/page/infinityScroll/InfinityScrollPagination_infinityScroll.dart';
import 'package:flutter_sample/page/infinityScroll/Listener_InfinityScroll.dart';
import 'package:flutter_sample/page/main_infinityScroll.dart';
import 'package:flutter_sample/page/infinityScroll/ScrollController_InfinityScroll.dart';
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
          path: 'InfinityScroll',
          name: 'InfinityScroll',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: MainInfinityScroll()),
          routes: [
            GoRoute(
              path: 'ScrollController',
              name: 'ScrollController_InfinityScroll',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: ScrollControllerInfinifyScroll()),
            ),
            GoRoute(
              path: 'Listener',
              name: 'Listener_Widget_InfinityScroll',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: ListenerInfinityScroll()),
            ),
            GoRoute(
              path: 'InfinityScrollPagination',
              name: 'InfinityScrollPagination_Library_InfinityScroll',
              pageBuilder: (context, state) => NoTransitionPage(
                  child: InfinityScrollPaginationInfinityScroll()),
            ),
            GoRoute(
              path: 'FlatList',
              name: 'FlatList_Library_InfinityScroll',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: FlatListInfinityScrll()),
            ),
          ],
        )
      ],
    ),
  ],
);
