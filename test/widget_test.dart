// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:tcc_copsoma/main.dart';
import 'package:camera/camera.dart';
import 'package:tcc_copsoma/screen/page_home.dart';

void main() {
  testWidgets('SplashScreen navigation test', (WidgetTester tester) async {
    // Simula uma lista de câmeras vazia para o teste
    final List<CameraDescription> cameras = [];

    // Constrói o aplicativo com a SplashScreen
    await tester.pumpWidget(MyApp(cameras: cameras));

    // Verifica se a SplashScreen é exibida
    expect(find.byType(SplashScreen), findsOneWidget);

    // Avança o tempo no teste em 2 segundos para simular o Timer
    await tester.pump(const Duration(seconds: 2));

    // Verifica se a tela inicial (HomePage) foi carregada
    expect(find.byType(HomePage), findsOneWidget);
  });
}
