# Frontend (Flutter)

## Descripción
Frontend Flutter multiplataforma (Android/iOS/Web) para consumir servicios multimedia vía REST/WebSocket.

## Stack técnico
- Flutter SDK >= 3.0, Dart.
- Arquitectura: Presentation → Domain → Data.
- State management: Provider/Riverpod/BLoC.
- Serialización: json_serializable / freezed.
- HTTP: dio con interceptores.
- Cache: Hive/SQLite/SharedPreferences.
- Realtime: WebSocket.

## Flujo de datos
- **RemoteDataSource** → llamadas HTTP, DTOs.
- **LocalDataSource** → cache/persistencia (Hive/SQLite).
- **Repository** → orquesta, mapea DTO→Entity.
- **UseCase** → reglas de negocio, retorna Result/Either.
- **Presentation (Bloc/Provider)** → expone Streams/StateNotifiers.
- **UI** → consume estado, dispara eventos.

Patrones: read-through cache, write-through para offline, optimistic updates, WebSocket para realtime.

## Configuración
- Variables con `--dart-define=API_URL="https://..."`
- Flavors: dev/staging/prod.
- Evitar credenciales en repo.

## Comandos
```bash
flutter pub get              # Instalar dependencias
flutter run                  # Ejecutar en desarrollo
flutter test                 # Ejecutar tests
flutter build apk --release  # Build Android release
```

## Estructura
```
lib/
  main.dart
  features/<feature>/{presentation, domain, data}
  core/
assets/
test/
```

## Testing
- Unit: mocks de DataSources con mockito/mocktail.
- Widget: WidgetTester.
- CI: flutter analyze, flutter test en cada PR.

## Scrum
- **DoD**: compilable, tests pasan, lint, reviews, docs.
- **Branching**: feature/<id>, PR linkado a issue, checks verdes antes de merge.
- **Sprint**: 1-2 semanas, dailies, review, retro.
- **Velocidad**: medir para planificar.

## Deploy
- Play Store / App Store con signingConfig.
- Tag semántico: vX.Y.Z.
- CI automático desde release/main.

## Observabilidad
- Logs estructurados (network, auth, parsing).
- Sentry/Crashlytics para crashes.
- Telemetría: uploads, downloads, syncs.

## Notas
- Mantener mappers simples y testables.
- DTOs documentados.
- Non-nullable types, codegen.