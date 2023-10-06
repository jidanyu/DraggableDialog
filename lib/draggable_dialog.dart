import 'package:flutter/material.dart';

enum DragPosition { top, bottom, left, right }

class DraggableDialog extends StatefulWidget {
  DraggableDialog({Key? key, required this.onClose, required this.context});
  final BuildContext context;
  final VoidCallback onClose;

  @override
  State<DraggableDialog> createState() => _DraggableDialogState();
}

class _DraggableDialogState extends State<DraggableDialog> {
  double minWidth = 100;
  double minHeight = 80;
  double width = 300;
  double height = 300;
  double top = 0.0; //距顶部的偏移
  double left = 0.0; //距左边的偏移

  double dragSize = 5;

  @override
  void initState() {
    super.initState();
    double screenWidth = MediaQuery.of(widget.context).size.width;
    double screenHeight = MediaQuery.of(widget.context).size.height;
    top = (screenHeight - height) / 2;
    left = (screenWidth - width) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Center(
          child: Stack(
            // alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              //主体
              Positioned(
                top: top,
                left: left,
                width: width,
                height: height,
                child: Container(
                    color: Colors.white,
                    child: Column(children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        //手指滑动时会触发此回调
                        onPanUpdate: (DragUpdateDetails e) {
                          //用户手指滑动时，更新偏移，重新构建
                          setState(() {
                            left += e.delta.dx;
                            top += e.delta.dy;
                          });
                        },
                        child: Container(
                          height: 44,
                          color: Colors.grey[200],
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(flex: 1, child: Container()),
                                const Expanded(
                                  flex: 8,
                                  child: Text(
                                    '标题',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      iconSize: 20,
                                      onPressed: widget.onClose,
                                      icon: const Icon(Icons.close),
                                    ))
                              ]),
                        ),
                      ),
                    ])),
              ),
              //上边框
              Positioned(
                  top: top - dragSize + 5,
                  left: left,
                  width: width,
                  height: dragSize,
                  child: SizedBox(
                    // height: dragSize,
                    // color: Colors.red,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.resizeRow,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onVerticalDragUpdate: (e) =>
                            handleWith(DragPosition.top, e),
                      ),
                    ),
                  )),
              //下边框
              Positioned(
                  top: top + height - 5,
                  left: left,
                  width: width,
                  height: dragSize,
                  child: SizedBox(
                    // height: dragSize,
                    // color: Colors.red,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.resizeRow,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onVerticalDragUpdate: (e) =>
                            handleWith(DragPosition.bottom, e),
                      ),
                    ),
                  )),
              //左边框
              Positioned(
                  top: top,
                  left: left + 5 - dragSize,
                  width: dragSize,
                  height: height,
                  child: SizedBox(
                    // height: 10,
                    // color: Colors.black,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.resizeColumn,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragUpdate: (e) =>
                            handleWith(DragPosition.left, e),
                      ),
                    ),
                  )),
              //右边框
              Positioned(
                  top: top,
                  left: left + width,
                  width: dragSize,
                  height: height,
                  child: SizedBox(
                    // height: dragSize,
                    // color: Colors.black,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.resizeColumn,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragUpdate: (e) =>
                            handleWith(DragPosition.right, e),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  handleWith(DragPosition postion, DragUpdateDetails e) {
    setState(() {
      switch (postion) {
        case DragPosition.top:
          top += e.delta.dy;
          height += -e.delta.dy;
        case DragPosition.bottom:
          // top += e.delta.dy;
          height += e.delta.dy;
        case DragPosition.left:
          left += e.delta.dx;
          width += -e.delta.dx;
        case DragPosition.right:
          // left += e.delta.dx;
          width += e.delta.dx;
        default:
      }

      if (height <= minHeight) {
        height = minHeight;
        if (postion == DragPosition.top) {
          top -= e.delta.dy;
        }
      }
      if (width <= minWidth) {
        if (postion == DragPosition.left) {
          left -= e.delta.dx;
        }
        width = minWidth;
      }

      // print(height);
      print(minHeight);
    });
  }
}
