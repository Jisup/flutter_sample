import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/page/OAuth/kakao/kakao_login.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoOAuth extends ConsumerStatefulWidget {
  const KakaoOAuth({super.key, required this.user});

  final User? user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KakaoOAuthState();
}

class _KakaoOAuthState extends ConsumerState<KakaoOAuth> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          alignment: Alignment.center,
          child: widget.user != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      child:
                          widget.user!.kakaoAccount?.profile?.profileImageUrl !=
                                  null
                              ? Image.network(widget.user!.kakaoAccount!
                                  .profile!.profileImageUrl!)
                              : const Text('error'),
                    ),
                    Text(
                        '닉네임 : ${widget.user!.kakaoAccount?.profile?.nickname ?? 'error'}'),
                    Text(
                        '이메일 : ${widget.user!.kakaoAccount?.email ?? 'error'}'),
                    TextButton(
                        onPressed: () {
                          KakaoLogout();
                          context.pop();
                        },
                        child: const Text('로그아웃')),
                    TextButton(
                        onPressed: () {
                          KakaoDisconnected();
                          context.pop();
                        },
                        child: const Text('연결 해제')),
                  ],
                )
              : const Text(
                  '사용자 정보 조회에\n실패했습니다.',
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
