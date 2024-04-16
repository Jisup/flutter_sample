import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedAlignAnimation extends ConsumerStatefulWidget {
  const AnimatedAlignAnimation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedAlignAnimationState();
}

class _AnimatedAlignAnimationState
    extends ConsumerState<AnimatedAlignAnimation> {
  String imageLocation = 'left';
  bool isClicked = true;

  void buttonClick({required String type}) {
    if (imageLocation != type) {
      setState(() {
        imageLocation = type;
        isClicked = true;
      });
    } else {
      setState(() => isClicked = !isClicked);
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
              const Text('이미지 또는 버튼을 클릭하면 위치 변화'),
              FractionallySizedBox(
                widthFactor: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: AnimatedAlign(
                      alignment: switch (imageLocation) {
                        'left' => isClicked
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        'top' => isClicked
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        'topLeft' =>
                          isClicked ? Alignment.topLeft : Alignment.bottomRight,
                        'bottomLeft' =>
                          isClicked ? Alignment.bottomLeft : Alignment.topRight,
                        _ => Alignment.center,
                      },
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      child: GestureDetector(
                        onTap: () => setState(() => isClicked = !isClicked),
                        child: Image.asset(
                          'lib/page/animation/assets/flutter_logo.png',
                          // 'lib/page/animation/assets/sample.png',
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width / 8,
                          // width: MediaQuery.of(context).size.width / 4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  TextButton(
                      onPressed: () => buttonClick(type: 'left'),
                      child: const Text('좌↔우')),
                  TextButton(
                      onPressed: () => buttonClick(type: 'top'),
                      child: const Text('상↔하')),
                  TextButton(
                      onPressed: () => buttonClick(type: 'topLeft'),
                      child: const Text('좌상↔우하')),
                  TextButton(
                      onPressed: () => buttonClick(type: 'bottomLeft'),
                      child: const Text('좌하↔우상')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
