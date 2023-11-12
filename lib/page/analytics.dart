import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> testEventlog(String buttonName) async {
    await analytics.logEvent(
        name: '${buttonName}_click', parameters: {'Value': buttonName});
    print('Tombol $buttonName berhasil ditekan');
  }
}
