import 'dart:math';

import 'package:flutter/material.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollablePositionedListPageA extends StatefulWidget {
  const ScrollablePositionedListPageA({super.key});

  @override
  State<StatefulWidget> createState() => _ScrollablePositionedListPageAState();
}

class _ScrollablePositionedListPageAState
    extends State<ScrollablePositionedListPageA> {
  late List<double> itemHeights;
  late List<Color> itemColors;

  final itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();

  static const randomMax = 1 << 32;
  static const numberOfItems = 10001;
  static const minItemHeight = 20.0;
  static const maxItemHeight = 150.0;
  static const scrollDuration = Duration(seconds: 2);
  double alignment = 0;

  @override
  void initState() {
    super.initState();
    final heightGenerator = Random(328902348);
    final colorGenerator = Random(42490823);
    itemHeights = List.generate(
      numberOfItems,
      (int _) =>
          heightGenerator.nextDouble() * (maxItemHeight - minItemHeight) +
          minItemHeight,
    );
    itemColors = List.generate(
      numberOfItems,
      (int _) => Color(colorGenerator.nextInt(randomMax)).withOpacity(1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const Text(
                          'Scroll to',
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              scrollToItem(0),
                              scrollToItem(5),
                              scrollToItem(10),
                              scrollToItem(100),
                              scrollToItem(1000),
                              scrollToItem(5000),
                              scrollToItem(10000),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ScrollablePositionedList.builder(
                    itemCount: numberOfItems,
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    scrollDirection: orientation == Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal,
                    itemBuilder: (context, index) => SizedBox(
                      height: orientation == Orientation.portrait
                          ? itemHeights[index]
                          : null,
                      width: orientation == Orientation.landscape
                          ? itemHeights[index]
                          : null,
                      child: Container(
                        color: itemColors[index],
                        child: Center(
                          child: Text('Item $index'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget scrollToItem(int index) => TextButton(
        key: ValueKey<String>('scroll_to_$index'),
        onPressed: () => itemScrollController.scrollTo(
          index: index,
          alignment: alignment,
          duration: scrollDuration,
          curve: Curves.easeInOutCubic,
        ),
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: MaterialStateProperty.all(Size.zero),
          padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
        ),
        child: Text('$index'),
      );
}
