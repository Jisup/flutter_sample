import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedPaddingAnimation extends ConsumerStatefulWidget {
  const AnimatedPaddingAnimation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedPaddingAnimationState();
}

class _AnimatedPaddingAnimationState
    extends ConsumerState<AnimatedPaddingAnimation> {
  String paddingType = '0';

  void buttonClick({required String type}) {
    if (paddingType != type) {
      setState(() {
        paddingType = type;
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
              const Text('버튼을 클릭하면 여백 크기 변화'),
              FractionallySizedBox(
                widthFactor: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: AnimatedPadding(
                      padding: switch (paddingType) {
                        '0' => const EdgeInsets.all(0),
                        '50' => const EdgeInsets.all(50),
                        '150' => const EdgeInsets.all(150),
                        '300' => const EdgeInsets.all(300),
                        _ => const EdgeInsets.all(0),
                      },
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      child: Image.asset(
                        'lib/page/animation/assets/flutter_logo.png',
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width / 8,
                      ),
                    ),
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  TextButton(
                      onPressed: () => buttonClick(type: '0'),
                      child: const Text('0')),
                  TextButton(
                      onPressed: () => buttonClick(type: '50'),
                      child: const Text('50')),
                  TextButton(
                      onPressed: () => buttonClick(type: '150'),
                      child: const Text('150')),
                  TextButton(
                      onPressed: () => buttonClick(type: '300'),
                      child: const Text('300')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
