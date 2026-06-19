import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showAppBar;

  const BaseScaffold({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.floatingActionButton,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(title: Text(title), actions: actions) : null,
      body: SafeArea(child: child),
      floatingActionButton: floatingActionButton,
    );
  }
}
