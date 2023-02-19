import 'package:flutter/material.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollablePositionedListPageB extends StatefulWidget {
  const ScrollablePositionedListPageB({super.key});

  @override
  State<StatefulWidget> createState() => _ScrollablePositionedListPageBState();
}

class _ScrollablePositionedListPageBState
    extends State<ScrollablePositionedListPageB> {
  late List<Widget> items;

  final itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();

  static const scrollDuration = Duration(seconds: 2);
  double alignment = 0;

  @override
  void initState() {
    super.initState();
    items = [
      const Page0(),
      const Page1(),
      const Page2(),
      const Page3(),
      const Page4(),
    ];
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
                              scrollToItem(1),
                              scrollToItem(2),
                              scrollToItem(3),
                              scrollToItem(4),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ScrollablePositionedList.builder(
                    itemCount: items.length,
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    itemBuilder: (context, index) => items[index],
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

class Page0 extends StatelessWidget {
  const Page0({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.grey,
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.red,
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.blue,
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.orange,
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.yellow,
    );
  }
}
