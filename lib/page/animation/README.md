# Animation

Flutter에서 활용 중인 Animation Widget에 대한 간단한 설명과 구현을 목적으로 작성되었습니다. 위치/스타일/속성 값을 다루는 애니메이션 위젯과, 부모/자식 또는 서로 다른 두 컴포넌트를 위한 애니메이션 위젯으로 구분됩니다.

각 Widge은 자신이 수행할 수 있는 행위를 간단하게 매핑하여 소개합니다.

### 위치 및 크기

- AnimatedAlign : 정렬(위치) 변화 [reference](https://api.flutter.dev/flutter/widgets/AnimatedAlign-class.html)

  - AnimatedAlignAnimation.dart
  - alignment 속성을 활용하여, 자식 요소의 위치를 변경하는 애니메이션을 적용한다.
  - <Image width="30%" src="https://github.com/Jisup/flutter_sample/assets/49368118/2881912a-0b8b-4563-a2a2-c1b78153136a">

- AnimatedPadding : 여백(크기) 변화 [reference](https://api.flutter.dev/flutter/widgets/AnimatedPadding-class.html)

  - AnimatedPaddingAnimation.dart
  - padding 속성을 활용하여, 자식 요소의 여백 크기를 변경하는 애니메이션을 적용한다.
  - <Image width="30%" src="https://github.com/Jisup/flutter_sample/assets/49368118/41430641-1d3d-4cae-8042-ef228f455b69">

- AnimatedContainer : 위젯 변화 [reference](https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html)

  - AnimatedContainerAnimation.dart
  - Container의 너비(width), 높이(height), 여백(margin/padding), 색상(color), 정렬(alignment) 속성이 변경되는 애니메이션을 적용한다.
  - AnimatedAlign 및 AnimatedPadding을 하위 집합으로 포함하고 있다.
  - 단, 부모 요소에 위치를 지정하는 위젯(Center Widget ...)이 포함해야 크기에 대한 변화를 확인할 수 있다.
  - <Image width="30%" src="https://github.com/Jisup/flutter_sample/assets/49368118/3587f312-c3cb-4138-9866-59d7994e7aff">

- AnimatedPositioned : 위젯(크기, 위치) 변화 [reference](https://api.flutter.dev/flutter/widgets/AnimatedPositioned-class.html)

  - AnimatedPositionedAnimation.dart
  - 현재 요소에 대하여 너비(width), 높이(height) 속성으로 크기 변화에 대한 애니메이션을 적용하고 상(top), 하(bottom), 좌(left), 우(right) 속성으로 위치 변화에 대한 애니메이션을 적용한다.
  - 단, 부모 요소에 Positioned를 사용할 수 있는 Stack Widget이 포함되어야 활용할 수 있다.
  - 만약, 요소의 위치를 변경할 때 속성 값에 null이 들어가는 경우, 위치 변화에 대한 애니메이션이 적용되지 않는다.
  - 만약, 크기가 변경되지 않는 요소의 경우, SlideTransition Widget을 사용하는 것을 권장하고 있다.
  - <Image width="30%" src="https://github.com/Jisup/flutter_sample/assets/49368118/f0eea9f4-e179-43c2-b6d8-8e3799ab0907">

- SlideTransition : 위치 변화 [reference](https://api.flutter.dev/flutter/widgets/SlideTransition-class.html)

  - SlideTransitionAnimation.dart
  - 크기가 변경되지 않는 요소에, 위치를 변경하는 애니메이션을 적용하기 적합한 위젯이다.
  - AnimationController를 활용하여 요소의 위치를 변경하는 애니메이션을 적용한다.
  - 내부에서 활용되는 Offset의 기준은 1이며, 하위 자식 요소의 크기를 기준으로 잡는다. 만약 dx에 0.25의 Offset을 가지고 있다면, 전체 너비의 25% 만큼 수평 변환이 일어나게 된다.

    - basicExample_SlideTransition.dart

      - SlideTransition을 활용한 가장 기본적인 움직임 예제
      - <Image width="30%" src="https://github.com/Jisup/flutter_sample/assets/49368118/61ddf4f8-31fd-497d-84ed-da81d6578ec4">

    - numberChangeExample_SlideTransition.dart
      - SlideTransition을 활용한 계기판의 숫자 변화 애니메이션 예제
      - <Image width="30%" src="https://github.com/Jisup/flutter_sample/assets/49368118/c9eb9636-72e5-4028-aa09-79e36e97fe89">

### 스타일

### 속성

### 부모/자식

### 서로 다른 두 컴포넌트

### 성능 비교

- SlideTransition vs AnimatedPositioned

  - 시간이 지남에 따라 위치만 변경하는 경우 SlideTransition이 적합합니다.
  - SlideTransition은 애니메이션의 각 Frame만 다시 그리는 것을 트리거하지만, AnimatedPositioned은 릴레이아웃도 트리거를 진행합니다.
  - ※ 릴레이아웃(Re-layout) : 물리적 공간, 문서, 웹사이트 등의 배치를 재배치하거나 재설계하는 행위를 말합니다. 기능, 미학, 사용자 경험을 개선하기 위해 요소의 위치, 정렬, 구성 또는 전반적인 디자인을 변경하는 것이 포함됩니다. 재배치의 목표는 구성 요소 배열을 최적화하여 종종 효율성, 유용성, 흐름 또는 시각적 매력을 향상시키는 것입니다.
