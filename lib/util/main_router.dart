import 'package:flutter/material.dart';
import 'package:flutter_sample/page/OAuth/kakao/Kakao_OAuth.dart';
import 'package:flutter_sample/page/animation/AnimatedAlignAnimation.dart';
import 'package:flutter_sample/page/animation/AnimatedContainerAnimation.dart';
import 'package:flutter_sample/page/animation/AnimatedPaddingAnimation.dart';
import 'package:flutter_sample/page/animation/AnimatedPositionedAnimation.dart';
import 'package:flutter_sample/page/animation/AnimatedSlideAnimation.dart';
import 'package:flutter_sample/page/animation/SlideTransition/basicExample_SlideTransition.dart';
import 'package:flutter_sample/page/animation/SlideTransition/numberChangeExample_SlideTransition.dart';
import 'package:flutter_sample/page/animation/SlideTransitionAnimation.dart';
import 'package:flutter_sample/page/infinityCarousel/PageView_Carousel.dart';
import 'package:flutter_sample/page/infinityScroll/FlatList_InfinityScroll.dart';
import 'package:flutter_sample/page/infinityScroll/InfinityScrollPagination_infinityScroll.dart';
import 'package:flutter_sample/page/infinityScroll/Listener_InfinityScroll.dart';
import 'package:flutter_sample/page/mainAnimation.dart';
import 'package:flutter_sample/page/main_OAuth.dart';
import 'package:flutter_sample/page/main_infinityCarousel.dart';
import 'package:flutter_sample/page/main_infinityScroll.dart';
import 'package:flutter_sample/page/infinityScroll/ScrollController_InfinityScroll.dart';
import 'package:flutter_sample/main_home.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

GoRouter mainRouter = GoRouter(
  navigatorKey: navigatorkey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: MainHome()),
      routes: [
        GoRoute(
          path: 'InfinityScroll',
          name: 'InfinityScroll',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MainInfinityScroll()),
          routes: [
            GoRoute(
              path: 'ScrollController',
              name: 'ScrollController_InfinityScroll',
              pageBuilder: (context, state) => const NoTransitionPage(
                  child: ScrollControllerInfinifyScroll()),
            ),
            GoRoute(
              path: 'Listener',
              name: 'Listener_Widget_InfinityScroll',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ListenerInfinityScroll()),
            ),
            GoRoute(
              path: 'InfinityScrollPagination',
              name: 'InfinityScrollPagination_Library_InfinityScroll',
              pageBuilder: (context, state) => const NoTransitionPage(
                  child: InfinityScrollPaginationInfinityScroll()),
            ),
            GoRoute(
              path: 'FlatList',
              name: 'FlatList_Library_InfinityScroll',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: FlatListInfinityScroll()),
            ),
          ],
        ),
        GoRoute(
          path: 'InfinityCarousel',
          name: 'InfinityCarousel',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MainInfinityCarousel()),
          routes: [
            GoRoute(
              path: 'PageView',
              name: 'PageView_InfinityCarousel',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: PageViewInfinityCarousel()),
            )
          ],
        ),
        GoRoute(
          path: 'OAuth',
          name: 'OAuth',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MainOAuth()),
          routes: [
            GoRoute(
              path: 'Kakao',
              name: 'Kakao_OAuth',
              pageBuilder: (context, state) => NoTransitionPage(
                  child: KakaoOAuth(user: state.extra as User?)),
            )
          ],
        ),
        GoRoute(
          path: 'animation',
          name: 'animation',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MainAnimation()),
          routes: [
            GoRoute(
              path: 'AnimatedAlign',
              name: 'AnimatedAlign_animation',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AnimatedAlignAnimation()),
            ),
            GoRoute(
              path: 'AnimatedPadding',
              name: 'AnimatedPadding_animation',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AnimatedPaddingAnimation()),
            ),
            GoRoute(
              path: 'AnimatedContainer',
              name: 'AnimatedContainer_animation',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AnimatedContainerAnimation()),
            ),
            GoRoute(
              path: 'AnimatedPositioned',
              name: 'AnimatedPositioned_animation',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AnimatedPositionedAnimation()),
            ),
            GoRoute(
                path: 'SlideTransition',
                name: 'SlideTransition_animation',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SlideTransitionAnimation()),
                routes: [
                  GoRoute(
                    path: 'basicExample',
                    name: 'basicExample_SlideTransition',
                    pageBuilder: (context, state) => const NoTransitionPage(
                        child: BasicExampleSlideTransition()),
                  ),
                  GoRoute(
                    path: 'numberChangeExample',
                    name: 'numberChangeExample_SlideTransition',
                    pageBuilder: (context, state) => const NoTransitionPage(
                        child: NumberChangeExampleSlideTransition()),
                  ),
                ]),
            GoRoute(
              path: 'AnimatedSlide',
              name: 'AnimatedSlide_animation',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AnimatedSlideAnimation()),
            ),
          ],
        ),
      ],
    ),
  ],
);
