import 'package:flutter/material.dart';

//====this specify the page direction state
enum PageAnimateDirection {
  up,
  right,
  down,
  left,
}

//=====page route animation=========
class PageTransitionRoute extends PageRouteBuilder {
  final Widget child;
  final PageAnimateDirection direction;
  final int duration;

  PageTransitionRoute({
    required this.child,
    required this.duration,
    this.direction = PageAnimateDirection.right,
  }) : super(
          transitionDuration: Duration(milliseconds: duration),
          reverseTransitionDuration: Duration(milliseconds: duration),
          pageBuilder: (context, animation, secondaryAnimation) {
            return child;
          },
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: getBeginOffset(), //this determine where the animation starts
        end: Offset
            .zero, //this mean (0,0) at the normal page position which is the origin
      ).animate(animation),
      child: child,
    );
  }

//======switch statement to transition according to the set enum state===
  Offset getBeginOffset() {
    switch (direction) {
      case PageAnimateDirection.up:
        return const Offset(0, 1);
      case PageAnimateDirection.down:
        return const Offset(0, -1);
      case PageAnimateDirection.right:
        return const Offset(-1, 0);
      case PageAnimateDirection.left:
        return const Offset(1, 0);
    }
  }
}
