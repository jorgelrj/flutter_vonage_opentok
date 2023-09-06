import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:flutter/widgets.dart';

class PlatformDivElement extends StatefulWidget {
  final String elementKey;
  final VoidCallback? afterCreate;
  final VoidCallback? onDispose;

  const PlatformDivElement({
    Key? key,
    this.afterCreate,
    this.onDispose,
    this.elementKey = 'div_element',
  }) : super(key: key);

  @override
  _PlatformDivElementState createState() => _PlatformDivElementState();
}

class _PlatformDivElementState extends State<PlatformDivElement> {
  String get _key => widget.elementKey;

  late Widget _divWidget;

  @override
  void initState() {
    super.initState();

    ui.platformViewRegistry.registerViewFactory(
      _key,
      (int viewId) {
        final element = html.DivElement()
          ..id = _key
          ..style.width = '100%'
          ..style.height = '100%';

        return element;
      },
    );
    _divWidget = HtmlElementView(key: Key(_key), viewType: _key);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.afterCreate?.call();
    });
  }

  @override
  void dispose() {
    widget.onDispose?.call();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _divWidget;
  }
}
