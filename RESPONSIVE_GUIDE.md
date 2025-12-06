# Guía del sistema responsive

Esta guía describe el uso del helper responsivo presente en el proyecto (`lib/core/helpers/responsive.dart`) y recoge buenas prácticas, ejemplos y consejos para tests.

**Resumen rápido**
- Usa `ResponsiveHelper` para calcular paddings, tamaños de fuente y dimensiones en % de la pantalla.
- Llama a `ResponsiveHelper.init(context)` una vez en el árbol de widgets (ej. en `build()` de la página o en un `Builder` que envuelva la `Scaffold`).
- Evita hard-coded sizes; usa `paddingHorizontal`, `paddingVertical`, `fontSize`, `width`, `height`.

**API principal (métodos disponibles)**
- `ResponsiveHelper.init(BuildContext)` — Inicializa internamente dimensiones de pantalla.
- `ResponsiveHelper.paddingHorizontal(double percent)` — Retorna padding horizontal en píxeles relativo al ancho.
- `ResponsiveHelper.paddingVertical(double percent)` — Retorna padding vertical relativo al alto.
- `ResponsiveHelper.fontSize(double baseSize)` — Escala un tamaño base de fuente según la anchura de pantalla.
- `ResponsiveHelper.width(double percent)` — Retorna anchura relativa a la pantalla (porcentaje).
- `ResponsiveHelper.height(double percent)` — Retorna altura relativa a la pantalla (porcentaje).
- `ResponsiveHelper.isMobile()` / `isTablet()` — Detectores por breakpoint.
- `ResponsiveHelper.isLandscape()` — Detecta orientación.
- `ResponsiveHelper.getGridColumns()` — Retorna número de columnas según tamaño (1..4).

**Breakpoints / Comportamiento esperado**
- Mobile: ancho < 600px
- Tablet: ancho >= 600px
- Grid adaptativo: 1 columna en móvil, 2 en tablet pequeño, 3-4 en pantallas más grandes.

**Buenas prácticas de uso**
- Llama `ResponsiveHelper.init(context);` al comienzo del `build()` de la página o dentro de un `Builder` que envuelva la `Scaffold` para asegurar que `MediaQuery` ya esté presente.
- No llames `ResponsiveHelper` antes de que exista `MediaQuery` (por ejemplo, en `initState()` sin `addPostFrameCallback`).
- Prefiere `ResponsiveHelper.paddingHorizontal(6)` que `EdgeInsets.symmetric(horizontal: 24)` para mantener consistencia entre dispositivos.
- Para formularios y listas, usa `ResponsiveHelper.fontSize()` para mantener legibilidad.

**Ejemplo práctico (página)**
```dart
@override
Widget build(BuildContext context) {
  ResponsiveHelper.init(context);
  final horizontal = ResponsiveHelper.paddingHorizontal(8);
  final titleSize = ResponsiveHelper.fontSize(22);

  return Scaffold(
    appBar: AppBar(
      title: Text('Lista', style: TextStyle(fontSize: titleSize)),
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: ListView(...),
    ),
  );
}
```

**Ejemplo: componente (tarjeta de producto)**
```dart
final imageSize = ResponsiveHelper.width(18);
final cardPadding = ResponsiveHelper.paddingHorizontal(4);

return Container(
  padding: EdgeInsets.all(cardPadding),
  child: Row(
    children: [
      Image.network(product.thumbnail ?? '', width: imageSize, height: imageSize),
      SizedBox(width: ResponsiveHelper.paddingHorizontal(2)),
      Expanded(child: Text(product.title, style: TextStyle(fontSize: ResponsiveHelper.fontSize(14)))),
    ],
  ),
);
```

**Cómo integrarlo en tests widget**
- En tests widget, debes envolver tu widget con `MediaQuery` y `MaterialApp` para que `ResponsiveHelper.init(context)` acceda a `MediaQuery`:

```dart
await tester.pumpWidget(
  MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(size: Size(375, 812)),
      child: Builder(builder: (context) {
        ResponsiveHelper.init(context);
        return MyWidgetUnderTest();
      }),
    ),
  ),
);
```

- Para probar diferentes tamaños, cambia `MediaQueryData(size: Size(width, height))` en cada test.

**Errores comunes y soluciones**
- "No MediaQuery found": asegúrate de envolver con `MaterialApp` o `MediaQuery` antes de llamar `ResponsiveHelper.init`.
- Llamar `ResponsiveHelper.init` en `initState()` sin `addPostFrameCallback` puede fallar; si necesitas iniciar algo en `initState`, usa:
```dart
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) => ResponsiveHelper.init(context));
}
```

**Componentes actualizados**
Se aplicó `ResponsiveHelper` en las siguientes vistas/componentes del proyecto:
- `lib/features/app/presentation/pages/api_list_page.dart`
- `lib/features/app/presentation/pages/prefs_page.dart`
- `lib/features/app/presentation/pages/prefs_new_page.dart`
- `lib/features/app/presentation/pages/prefs_id_page.dart`
- `lib/features/app/presentation/widgets/item_product_widget.dart`
- `lib/core/components/input_custom_core.dart`
- `lib/features/app/presentation/widgets/error_widget.dart`
- `lib/core/api/api_client.dart` (solo logging relacionado)

**Notas adicionales**
- Reemplace `print`/`debugPrint` por `LoggerHelper` (ya aplicado en el repositorio).
- `DropdownButtonFormField` usa ahora `initialValue` en lugar de `value` para evitar advertencias.
