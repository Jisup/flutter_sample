import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/config/static_list_config.dart';
import 'package:flutter_sample/page/OAuth/kakao/kakao_login.dart';
import 'package:flutter_sample/page/OAuth/naver/naver_login.dart';
import 'package:flutter_sample/util/main_router.dart';
import 'package:go_router/go_router.dart';

class MainOAuth extends ConsumerWidget {
  const MainOAuth({super.key});

  void OAuthClick(String type, String path) {
    var context = navigatorkey.currentContext;
    switch (type) {
      case 'kakao':
        KakaoLogin();
        context?.go('/OAuth/Kakao');
        break;
      case 'naver':
        NaverLogin();
        context?.go('OAuth/Naver');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder:
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
                    children: StaticListConfig.OAuthDemoList.map(
                      (demo) => GestureDetector(
                        onTap: () => OAuthClick(demo['type'], demo['path']),
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Image.asset(demo['asset']),
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
