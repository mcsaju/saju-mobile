import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saju_mobile_v1/storage/hive_init.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey:
        const String.fromEnvironment('KAKAO_NATIVE_APP_KEY').isNotEmpty
            ? const String.fromEnvironment('KAKAO_NATIVE_APP_KEY')
            : dotenv.env['KAKAO_NATIVE_APP_KEY']!,
    javaScriptAppKey:
        const String.fromEnvironment('KAKAO_JAVASCRIPT_APP_KEY').isNotEmpty
            ? const String.fromEnvironment('KAKAO_JAVASCRIPT_APP_KEY')
            : dotenv.env['KAKAO_JAVASCRIPT_APP_KEY']!,
  );

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here
  final directory = await getApplicationDocumentsDirectory();
  await HiveInit.init(directory.path);

  runApp(await builder());
}
