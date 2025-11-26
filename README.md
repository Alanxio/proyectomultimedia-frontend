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

