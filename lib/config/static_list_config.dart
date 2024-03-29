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
    }
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
}
