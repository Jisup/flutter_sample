import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainInfinityScroll extends ConsumerWidget {
  const MainInfinityScroll({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder:
            (BuildContext childContext, BoxConstraints viewportConstraint) {
          return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: viewportConstraint.maxWidth,
                minHeight: viewportConstraint.maxHeight,
              ),
              child: Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 25,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            context.push('/infinityScroll/scrollController'),
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'with scrollController',
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push('/infinityScroll/listener'),
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'with listener and scrollController',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }),
      ),
    );
  }
}
