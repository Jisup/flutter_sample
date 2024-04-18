import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberChangeExampleSlideTransition extends ConsumerStatefulWidget {
  const NumberChangeExampleSlideTransition({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NumberChangeExampleSlideTransitionState();
}

class _NumberChangeExampleSlideTransitionState
    extends ConsumerState<NumberChangeExampleSlideTransition>
    with SingleTickerProviderStateMixin {
  int value = 0;

  List<dynamic> containerInfo = [
    {'type': 1, 'text': '증가'},
  ];

  void buttonClick({required int type}) {
    switch (type) {
      case 1:
        setState(() => value += 1);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('버튼을 클릭하면 숫자 증가'),
              FractionallySizedBox(
                widthFactor: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: AnimatedDigit(value: value % 10),
                    ),
                  ),
                ),
              ),
              Wrap(
                children: containerInfo.map((info) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 3.25,
                    child: TextButton(
                        onPressed: () => buttonClick(type: info['type']),
                        child: Text(
                          info['text'],
                          textAlign: TextAlign.center,
                        )),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedDigit extends ConsumerStatefulWidget {
  const AnimatedDigit({super.key, required this.value});

  final int value;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimatedDigitState();
}

class _AnimatedDigitState extends ConsumerState<AnimatedDigit>
    with SingleTickerProviderStateMixin {
  static const Duration defaultDuration = Duration(milliseconds: 300);

  late final AnimationController controller;
  late int incomingValue;
  late int outgoingValue;
  List<int> pendingValues = <int>[];
  Duration duration = defaultDuration;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: duration,
      vsync: this,
    );
    controller.addStatusListener(handleAnimationCompleted);
    incomingValue = widget.value;
    outgoingValue = widget.value;
  }

  void handleAnimationCompleted(AnimationStatus status) {
    // AnimationStatus는 dismissed(중지), forward(재생), reverse(역재생), completed(완료)로 구분됩니다.
    if (status == AnimationStatus.completed) {
      if (pendingValues.isNotEmpty) {
        controller.duration = duration;
        animateValueUpdate(incomingValue, pendingValues.removeAt(0));
      } else {
        controller.duration = defaultDuration;
      }
    }
  }

  void animateValueUpdate(int outgoing, int incoming) {
    setState(() {
      outgoingValue = outgoing;
      incomingValue = incoming;
      // 애니메이션 재생
      controller.forward(from: 0);
    });
  }

  @override
  void didUpdateWidget(AnimatedDigit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      // 현재 애니메이션이 진행되고 있는지 확인
      if (controller.isAnimating) {
        // 애니메이션이 진행되고 있을 때, interrupt가 발생했을 때,
        // 추가 애니메이션을 진행하는 행위
        pendingValues.add(widget.value);
        final double percentRemaining = 1 - controller.value;
        duration =
            defaultDuration * (1 / (percentRemaining + pendingValues.length));
        // 현재 값에서 대상까지 애니메이션을 시작
        controller.animateTo(1.0, duration: duration * percentRemaining);
      } else {
        animateValueUpdate(incomingValue, widget.value);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.displayLarge!;
    return ClipRect(
      child: Stack(
        children: <Widget>[
          // 0~9까지의 숫자에 대한 채우기 텍스트(없어도 동작함)
          //        그럼에도 불구하고 존재하는 이유는?
          const _PlaceholderDigit(),
          SlideTransition(
            // AnimationContorller`s drive method : 애니메이션에 Tween/CurveTween을 연결하는 메소드
            //        AnimationController 객체를 생성할 때 할당하지 않고, 사용할 때 추가하는 법
            //        CurvedAnimation, ProxyAnimation, ReverseAnimation, TrainHoppingAnimation 등에서도 호출될 수 있음
            position: controller.drive(
              Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(0, -1),
              ),
            ),
            child: Text(
              // ValueKey<int> : Stateful Widget에서 ValueKey를 사용하면,
              //      위젯을 식별하고(Flutter는 Type으로 Widget을 식별하기 때문),
              //      해당 위젯이 올바르게 업데이트 된다는 것을 보장(없다고 동작이 안되지 않음)할 수 있습니다.
              //      보통 키 값이 객체의 값을 기반으로 할 때(ID 기반으로 할 땐 Key) 사용됩니다.
              key: ValueKey<int>(outgoingValue),
              '$outgoingValue',
              style: textStyle,
            ),
          ),
          SlideTransition(
            position: controller.drive(
              Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ),
            ),
            child: Text(
              key: ValueKey<int>(incomingValue),
              '$incomingValue',
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderDigit extends StatelessWidget {
  const _PlaceholderDigit();

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        Theme.of(context).textTheme.displayLarge!.copyWith(
              fontWeight: FontWeight.w500,
            );

    final Iterable<Widget> placeholderDigits =
        <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map<Widget>(
      (int n) {
        return Text('$n', style: textStyle);
      },
    );

    return Opacity(
      opacity: 0,
      child: Stack(children: placeholderDigits.toList()),
    );
  }
}
