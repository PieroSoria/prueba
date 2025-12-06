# Prueba - Flutter Application

Una aplicación Flutter estructurada con arquitectura limpia, gestión de estado con BLoC y inyección de dependencias.

## 📋 Descripción del Proyecto

Esta aplicación implementa una arquitectura profesional basada en principios SOLID y Clean Architecture, utilizando:
- **BLoC** para gestión de estado
- **GetIt** para inyección de dependencias
- **Go Router** para navegación
- **Dio** para solicitudes HTTP
- **SQLite** para base de datos local

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── injector_dependency.dart  # Configuración de inyección de dependencias
├── core/                     # Capa compartida
│   ├── api/                  # Cliente HTTP y repositorio
│   ├── database/             # Base de datos local
│   ├── dependency/           # Configuración de dependencias
│   ├── helpers/              # Constantes y temas
│   ├── components/           # Componentes reutilizables
│   ├── resources/            # Assets y recursos
│   └── routes/               # Configuración de rutas
├── features/
│   ├── app/                  # Feature de la aplicación
```

## 🔧 Configuración Técnica

### Dependencias Principales
- **flutter_bloc**: ^9.1.1 - Gestión de estado
- **get_it**: ^9.2.0 - Inyección de dependencias
- **dio**: ^5.9.0 - Cliente HTTP
- **go_router**: ^17.0.0 - Navegación
- **sqflite**: ^2.4.2 - Base de datos local
- **shared_preferences**: ^2.5.3 - Almacenamiento local
- **flutter_secure_storage**: ^9.2.4 - Almacenamiento seguro

### Versión SDK
- Dart SDK: ^3.10.1

## 🚀 Inicialización

1. **Inyección de Dependencias** (`injector_dependency.dart`):
   - Registra SharedPreferences
   - Configura almacenamiento seguro
   - Inicializa la base de datos SQLite
   - Registra ApiClient, DataSources, Repositories y UseCases
   - Configura BLoCs

2. **Main**:
   - Inicializa bindings
   - Ejecuta inyector de dependencias
   - Configura BlocProvider
   - Aplica tema y rutas

## 📱 Capas de la Aplicación

### Core (Capa Compartida)
- **API**: Cliente HTTP y repositorio para comunicación con servidor
- **Database**: Gestión de SQLite y repositorio local
- **Dependency**: Organización de inyecciones (datasources, repositories, usecases, blocs)
- **Helpers**: Constantes de aplicación y temas
- **Routes**: Configuración de navegación con Go Router

### Features
- **App**: Feature principal de la aplicación

## 🎨 Tema

La aplicación utiliza un tema claro (`Themes.lightTheme`) con soporte para Google Fonts.

## 📱 Diseño Responsive

La aplicación implementa un diseño **100% responsivo** que se adapta a cualquier tamaño de pantalla:

### Sistema de Dimensiones Responsivas (`responsive.dart`)
Se utiliza la clase `ResponsiveHelper` que proporciona:

#### Métodos Principales:
- **`paddingHorizontal(percent)`** - Padding horizontal relativo al ancho
- **`paddingVertical(percent)`** - Padding vertical relativo al alto
- **`fontSize(baseSize)`** - Tamaño de fuente escalado automáticamente
- **`width(percent)`** - Ancho responsivo en porcentaje
- **`height(percent)`** - Alto responsivo en porcentaje
- **`isTablet()` / `isMobile()`** - Detecta tipo de dispositivo
- **`isLandscape()`** - Detecta orientación de pantalla
- **`getGridColumns()`** - Retorna columnas según tamaño (1-4)

#### Uso en Componentes:
```dart
ResponsiveHelper.init(context);
final padding = ResponsiveHelper.paddingHorizontal(8);
final fontSize = ResponsiveHelper.fontSize(16);
final imageSize = ResponsiveHelper.width(18);
```

### Características de Responsividad:

✅ **Márgenes y Paddings Relativos**
- Todos los espaciados se calculan en porcentaje del tamaño de pantalla
- Se mantiene consistencia visual en cualquier dispositivo

✅ **Tamaños de Fuente Escalables**
- Tipografía se ajusta automáticamente según ancho de pantalla
- Base: iPhone 375px, escala proporcional

✅ **Componentes Flexibles**
- Imágenes redimensionan automáticamente
- Botones adaptan altura y ancho
- Elementos se distribuyen con spacing coherente

✅ **Detección de Dispositivo**
- Mobile: < 600px (phones)
- Tablet: >= 600px (tablets)
- Grid adaptable: 1-4 columnas

✅ **Soporte Orientación**
- Detecta cambio portrait/landscape
- Elementos se reorganizan dinámicamente

### Vistas Actualizado:
- **`app_page.dart`** - Navegación responsive
- **`api_list_page.dart`** - Lista con paddings adaptables
- **`prefs_page.dart`** - Panel de preferencias responsive
- **`prefs_new_page.dart`** - Formulario escalable
- **`prefs_id_page.dart`** - Detalle con imágenes responsivas
- **`item_product_widget.dart`** - Tarjetas producto adaptables
- **`bottom_navigator_custom.dart`** - Navegación responsive

## 🔐 Seguridad

- Cliente HTTP configurado con Dio

## 📱 Plataformas Soportadas

- Android
- iOS
- Web
- macOS
- Windows
- Linux

## 🛠️ Comandos Útiles

```bash
# Obtener dependencias
flutter pub get

# Generar código (si es necesario)
flutter pub run build_runner build

# Ejecutar en desarrollo
flutter run

# Build para producción
flutter build apk      # Android
flutter build ios      # iOS
```

## 📚 Documentación Adicional

- **[RESPONSIVE_GUIDE.md](RESPONSIVE_GUIDE.md)** - Guía completa del sistema responsive
- [Flutter Documentation](https://docs.flutter.dev/)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)
