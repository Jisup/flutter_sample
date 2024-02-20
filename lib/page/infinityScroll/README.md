# InfinityScroll

무한 스크롤은 사용자 경험 디자인 패턴 중 하나로, 사용자가 스크롤을 활용하여 콘텐츠를 제공받을 때 일정량의 정보를 소비하고 나면 자연스럽게 다음 콘텐츠로 넘어갈 수 있도록 새로운 콘텐츠를 자동으로 추가하여 페이지를 넘기는 번거로움 없이 연속적인 내용을 볼 수 있게 해주는 방식

- ScrollController
  - ScrollController_InfinityScroll.dart
  - ScrollController의 position 속성 정보를 활용한 구현
  - <Image width="30%" src="https://github.com/Jisup/flutter_sample/assets/49368118/e3af2678-8449-462e-900f-b514a6f288c8">

- Listener Widget + ScrollController
  - Listener_InfinityScroll.dart
  - Listener Widget의 onPointerMove/onPointerUp 속성과 ScrollController의 position 속성 정보를 활용한 구현
  - AnimatedContainer와 함께 땡기는 제스처 구현
  - <Image width="30%" src="https://github.com/Jisup/flutter_sample/assets/49368118/acef46ad-3a52-4c01-8417-e2741eb8d8b7">

- InfinityScrollPagination Library
  - InfinityScrollPagination_InfinityScroll.dart
  - Pagination을 기반으로 Page 데이터를 활용한 구현
  - <Image width="30%" src="https://github.com/Jisup/flutter_sample/assets/49368118/e11a6024-0d60-46c7-98ee-454fe1df89c0">

- FlatList
