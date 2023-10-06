import 'package:flutter/material.dart';

class Box extends StatefulWidget {
  final Color color;

  const Box(this.color, {Key? key}) : super(key: key);

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        color: widget.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$count', style: TextStyle(color: Colors.white)),
            IconButton(
              onPressed: () {
                setState(() {
                  count++;
                });
              },
              icon: Icon(Icons.add),
            )
          ],
        ));
  }
}
