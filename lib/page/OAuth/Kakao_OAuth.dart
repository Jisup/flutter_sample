import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KakaoOAuth extends ConsumerStatefulWidget {
  const KakaoOAuth({super.key});

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
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.85),
    );
  }
}
