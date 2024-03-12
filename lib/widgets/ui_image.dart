import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../tools/image/image_tool.dart';

class UiImage extends StatelessWidget {
  final String path;
  final Function(Uint8List) builder;

  const UiImage(this.path, {super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: ImageTool.imageBytes(path),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return builder(snapshot.data!);
          default:
            return Container();
        }
      },
    );
  }
}
