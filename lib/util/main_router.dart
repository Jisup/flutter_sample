import 'package:flutter_sample/demo/infinityScroll/ListView_infinityScroll.dart';
import 'package:flutter_sample/main_home.dart';
import 'package:go_router/go_router.dart';

GoRouter mainRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => NoTransitionPage(child: MainHome()),
      routes: [
        GoRoute(
          path: 'ListViewInfinityScroll',
          name: 'ListViewInfinityScroll',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: ListViewInfinityScroll()),
        )
      ]),
]);
