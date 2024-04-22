import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedSlideAnimation extends ConsumerStatefulWidget {
  const AnimatedSlideAnimation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedSlideAnimationState();
}

class _AnimatedSlideAnimationState
    extends ConsumerState<AnimatedSlideAnimation> {
  String imageLocation = 'left';
  bool isClicked = true;

  Offset offset = Offset.zero;

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
              const Text('슬라이더(Slider)를 움직이면 위치 변화'),
              FractionallySizedBox(
                widthFactor: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: AnimatedSlide(
                      offset: offset,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                      child: Center(
                        child: Image.asset(
                          'lib/page/animation/assets/flutter_logo.png',
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width / 8,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text('상↔하'),
                        Expanded(
                          child: Slider(
                            min: -0.5,
                            max: 0.5,
                            value: offset.dy,
                            onChanged: (double value) {
                              setState(() {
                                offset = Offset(offset.dx, value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('좌↔우'),
                        Expanded(
                          child: Slider(
                            min: -0.5,
                            max: 0.5,
                            value: offset.dx,
                            onChanged: (double value) {
                              setState(() {
                                offset = Offset(value, offset.dy);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
