import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/util/main_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
      nativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'),
      javaScriptAppKey: dotenv.get('KAKAO_JAVASCRIPT_APP_KEY'));

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'flutter samples',
      routerConfig: mainRouter,
    );
  }
}
