import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/config/static_list_config.dart';
import 'package:flutter_sample/util/main_router.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class MainOAuth extends ConsumerWidget {
  const MainOAuth({super.key});

  void OAuthClick(String type, String path) {
    switch (type) {
      case 'kakao':
        KakaoLogin();
        break;
    }
  }

  void KakaoLogin() async {
    // 이미 로그인하여 토큰 정보가 존재하는 경우
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
        } else {
          print('토큰 정보 조회 실패 $error');
          return;
        }

        try {
          // 카카오계정으로 로그인
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('로그인 성공 ${token.accessToken}');
        } catch (error) {
          print('로그인 실패 $error');
          return;
        }
      }
    } else {
      print('발급된 토큰 없음');
      // 카카오톡 실행 가능 여부 확인
      // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
      bool result = await isKakaoTalkInstalled();
      if (await isKakaoTalkInstalled()) {
        print("카카오톡 있음");
        try {
          await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공');
        } catch (error) {
          print('카카오톡으로 로그인 실패 $error');

          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (error is PlatformException && error.code == 'CANCELED') {
            return;
          }
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
          try {
            await UserApi.instance.loginWithKakaoAccount();
            print('카카오계정으로 로그인 성공');
          } catch (error) {
            print('카카오계정으로 로그인 실패 $error');
            return;
          }
        }
      } else {
        print("카카오톡 없음");
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return;
        }
      }
    }
    // 사용자 정보 불러오기
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n프로필: ${user.kakaoAccount?.profile?.profileImageUrl}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
      return;
    }
  }

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
              ));
        }),
      ),
    );
  }
}
