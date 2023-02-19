import 'package:flutter/material.dart';

import 'example_b.dart';

void main() {
  runApp(
    const ScrollablePositionedListExample(),
  );
}

class ScrollablePositionedListExample extends StatelessWidget {
  const ScrollablePositionedListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ScrollablePositionedList Example',
      home: ScrollablePositionedListPageB(),
      // home: ScrollablePositionedListPageB(),
    );
  }
}
