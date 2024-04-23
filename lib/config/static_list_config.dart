class StaticListConfig {
  static final List<dynamic> DemoList = [
    {
      'path': '/InfinityScroll',
      'text': 'InfinityScroll Demo',
    },
    {
      'path': '/InfinityCarousel',
      'text': 'InfinityCarousel Demo',
    },
    {
      'path': '/OAuth',
      'text': 'OAuth Demo',
    },
    {
      'path': '/animation',
      'text': 'Animation Demo',
    },
  ];
  static final List<dynamic> InfinityScrollDemoList = [
    {
      'path': '/InfinityScroll/ScrollController',
      'text': 'with ScrollController Class',
    },
    {
      'path': '/InfinityScroll/Listener',
      'text': 'with Listener Widget and ScrollController Class',
    },
    {
      'path': '/InfinityScroll/InfinityScrollPagination',
      'text': 'with InfinityScrollPagination Library',
    },
    {
      'path': '/InfinityScroll/FlatList',
      'text': 'with FlatList Library',
    },
  ];

  static final List<dynamic> CarouselDemoList = [
    {
      'path': '/InfinityCarousel/PageView',
      'text': 'with PageView Widget',
    },
  ];

  static final List<dynamic> OAuthDemoList = [
    {
      'type': 'kakao',
      'path': '/OAuth/Kakao',
      'asset': 'lib/page/OAuth/kakao/assets/kakao_login_medium_wide.png',
    }
  ];
  static final List<dynamic> animationDemoList = [
    // ### 스타일 및 속성
    {
      'path': null,
      'text': '----- 스타일 및 속성 -----',
    },
    {
      'path': '/animation/AnimatedAlign',
      'text': 'AnimatedAlign : 정렬 변화',
    },
    {
      'path': '/animation/AnimatedPadding',
      'text': 'AnimatedPadding : 여백 변화',
    },
    {
      'path': '/animation/AnimatedContainer',
      'text': 'AnimatedContainer : 위젯 변화',
    },
    // ### 위치 및 크기
    {
      'path': null,
      'text': '----- 위치 및 크기 -----',
    },
    {
      'path': '/animation/AnimatedPositioned',
      'text': 'AnimatedPositioned : 위젯(위치, 크기) 변화',
    },
    {
      'path': '/animation/SlideTransition',
      'text': 'SlideTransition : 위치 변화',
    },
    {
      'path': '/animation/AnimatedSlide',
      'text': 'AnimatedSlide : 위치 변화',
    },
    // ### 부모와 자식
    {
      'path': null,
      'text': '----- 부모와 자식 -----',
    },
    // ### 서로 다른 두 컴포넌트
    {
      'path': null,
      'text': '----- 서로 다른 두 컴포넌트 -----',
    },
    // ### 빌더
    {
      'path': null,
      'text': '----- 빌더 -----',
    },
    {
      'path': '/animation/AnimatedBuilder',
      'text': 'AnimatedBuilder : 모든 변화',
    },
  ];
  static final List<dynamic> slideTransitionAnimationDemoList = [
    {
      'path': '/animation/SlideTransition/basicExample',
      'text': '기본 애니메이션 예제 (위치 이동)',
    },
    {
      'path': '/animation/SlideTransition/numberChangeExample',
      'text': '숫자 애니메이션 예제 (자동차 계기판)',
    },
  ];
  static final List<dynamic> animatedBuilderAnimationDemoList = [
    {
      'path': '/animation/AnimatedBuilder/rotationExample',
      'text': '회전 애니메이션 예제',
    },
  ];
}
