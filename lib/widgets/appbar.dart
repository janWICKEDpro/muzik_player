import 'package:flutter/material.dart';

class AppTabBar extends StatefulWidget {
  const AppTabBar({super.key, required this.child});
  final Widget child;
  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(),
      ),
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        bottom: TabBar(tabs: [Text('Songs')]),
      ),
      body: widget.child,
    );
  }
}
