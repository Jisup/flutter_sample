import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedPositionedAnimation extends ConsumerStatefulWidget {
  const AnimatedPositionedAnimation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedPositionedAnimationState();
}

class _AnimatedPositionedAnimationState
    extends ConsumerState<AnimatedPositionedAnimation> {
  int positionType = 1;

  void buttonClick({required int type}) {
    if (positionType != type) {
      setState(() {
        positionType = type;
      });
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
              const Text('버튼을 클릭하면 위젯 위치 변화'),
              FractionallySizedBox(
                widthFactor: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedPositioned(
                          width: switch (positionType) {
                            1 || 3 => 100,
                            2 || 4 => 50,
                            _ => 0,
                          },
                          height: switch (positionType) {
                            1 || 3 => 100,
                            2 || 4 => 50,
                            _ => 0,
                          },
                          top: positionType == 1 || positionType == 2
                              ? 1 / 2 * (positionType * positionType) * 100
                              : null,
                          left: positionType == 3 || positionType == 4
                              ? 1 /
                                  2 *
                                  ((positionType - 2) * (positionType - 2)) *
                                  100
                              : null,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                          child: Image.asset(
                            'lib/page/animation/assets/flutter_logo.png',
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width / 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.25,
                    child: TextButton(
                        onPressed: () => buttonClick(type: 1),
                        child: const Text('100, 100, top~50')),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.25,
                    child: TextButton(
                        onPressed: () => buttonClick(type: 2),
                        child: const Text('50, 50, top~200')),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.25,
                    child: TextButton(
                        onPressed: () => buttonClick(type: 3),
                        child: const Text('100, 100, left~50')),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.25,
                    child: TextButton(
                        onPressed: () => buttonClick(type: 4),
                        child: const Text('50, 50, left~200')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
