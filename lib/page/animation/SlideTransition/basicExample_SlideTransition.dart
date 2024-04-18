import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasicExampleSlideTransition extends ConsumerStatefulWidget {
  const BasicExampleSlideTransition({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BasicExampleSlideTransitionState();
}

class _BasicExampleSlideTransitionState
    extends ConsumerState<BasicExampleSlideTransition>
    with SingleTickerProviderStateMixin {
  int positionType = 1;
  List<dynamic> containerInfo = [
    {'type': 1, 'text': 'start'},
    {'type': 2, 'text': 'stop'},
    {'type': 3, 'text': 'reset'},
  ];

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  // )..repeat(reverse: true);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(5, 0.0),
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.elasticIn,
  ));

  void buttonClick({required int type}) {
    switch (type) {
      case 1:
        _animationController.forward();
        break;
      case 2:
        _animationController.stop();
        break;
      case 3:
        _animationController.reset();
        break;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
              const Text('버튼을 클릭하여 위젯 애니메이션 설정'),
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
                      child: SlideTransition(
                        position: _offsetAnimation,
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
