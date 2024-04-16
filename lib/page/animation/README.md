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
  - <Image width="30%" src="https://github.com/Jisup/flutter_sample/assets/49368118/72ec3d30-50b5-48b9-9c96-48206c82ad47">

### 스타일

### 속성

### 부모/자식

### 서로 다른 두 컴포넌트
