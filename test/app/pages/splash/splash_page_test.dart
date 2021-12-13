import 'package:flutter_test/flutter_test.dart';

//import '/app/pages/splash/splash_page.dart';

main() {
  testWidgets('SplashPage has title', (WidgetTester tester) async {
    //await tester.pumpWidget(buildTestableWidget(SplashPage(title: 'Splash')));
    final titleFinder = find.text('Splash');
    expect(titleFinder, findsOneWidget);
  });
}
