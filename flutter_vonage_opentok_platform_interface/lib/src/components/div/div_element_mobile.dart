import 'package:flutter/material.dart';

class PlatformDivElement extends StatelessWidget {
  const PlatformDivElement({
    Key? key,
    this.afterCreate,
    this.onDispose,
    this.elementKey = 'div_element',
  }) : super(key: key);

  final String? elementKey;
  final VoidCallback? afterCreate;
  final VoidCallback? onDispose;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
