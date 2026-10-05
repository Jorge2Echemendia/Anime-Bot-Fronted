import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:anime_bot_fronted/app.dart';

void main() {
  testWidgets('La app muestra la pantalla de login cuando no hay sesión',
      (WidgetTester tester) async {
    // Arranca la app dentro de un ProviderScope
    await tester.pumpWidget(
      const ProviderScope(child: AnimeManagerApp()),
    );

    // Espera a que se resuelva la restauración de sesión (async)
    await tester.pumpAndSettle();

    // Debe redirigir a /login y mostrar el botón de inicio de sesión
    expect(find.text('Panel de Administración'), findsOneWidget);
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });
}