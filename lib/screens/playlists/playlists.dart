import 'package:flutter/material.dart';

class PlayLists extends StatefulWidget {
  const PlayLists({super.key});

  @override
  State<PlayLists> createState() => _PlayListsState();
}

class _PlayListsState extends State<PlayLists> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Playlists"),
    );
  }
}
