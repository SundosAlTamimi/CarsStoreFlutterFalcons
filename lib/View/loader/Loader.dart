import 'package:flutter/material.dart';
import 'dart:math';
import 'dot_type.dart';

class ColorLoader extends StatefulWidget {

  final Color dotOneColor;
  final Color dotTwoColor;
  final Color dotThreeColor;
  final Duration duration;
  final DotType dotType;
  final Icon dotIcon;

  ColorLoader({
    this.dotOneColor = Colors.redAccent,
    this.dotTwoColor = Colors.green,
    this.dotThreeColor = Colors.blueAccent,
    this.duration = const Duration(milliseconds: 1000),
    this.dotType = DotType.circle,
    this.dotIcon = const Icon(Icons.blur_on)
  });

  @override
  _ColorLoaderState createState() => _ColorLoaderState();
}

class _ColorLoaderState extends State<ColorLoader>
    with SingleTickerProviderStateMixin {
  Animation<double> animation_1;
  Animation<double> animation_2;
  Animation<double> animation_3;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: widget.duration, vsync: this);

    animation_1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.70, curve: Curves.linear),
      ),
    );

    animation_2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.1, 0.80, curve: Curves.linear),
      ),
    );

    animation_3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.2, 0.90, curve: Curves.linear),
      ),
    );

    controller.addListener(() {
      setState(() {
        //print(animation_1.value);
      });
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    //print(animation_1.value <= 0.4 ? 2.5 * animation_1.value : (animation_1.value > 0.40 && animation_1.value <= 0.60) ? 1.0 : 2.5 - (2.5 * animation_1.value));
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Opacity(
            opacity: (animation_1.value <= 0.4 ? 2.5 * animation_1.value : (animation_1.value > 0.40 && animation_1.value <= 0.60) ? 1.0 : 2.5 - (2.5 * animation_1.value)),
            child: new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Dot(
                radius: 10.0,
                color: widget.dotOneColor,
                type: widget.dotType,
                icon: widget.dotIcon,
              ),
            ),
          ),
          Opacity(
            opacity: (animation_2.value <= 0.4 ? 2.5 * animation_2.value : (animation_2.value > 0.40 && animation_2.value <= 0.60)? 1.0 : 2.5 - (2.5 * animation_2.value)),
            child: new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Dot(
                radius: 10.0,
                color: widget.dotTwoColor,
                type: widget.dotType,
                icon: widget.dotIcon,
              ),
            ),
          ),
          Opacity(
            opacity: (animation_3.value <= 0.4 ? 2.5 * animation_3.value : (animation_3.value > 0.40 && animation_3.value <= 0.60) ? 1.0 : 2.5 - (2.5 * animation_3.value)),
            child: new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Dot(
                radius: 10.0,
                color: widget.dotThreeColor,
                type: widget.dotType,
                icon: widget.dotIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {

    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  final DotType type;
  final Icon icon;

  Dot({this.radius, this.color, this.type, this.icon});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: type == DotType.icon ?
      Icon(icon.icon, color: color, size: 1.3 * radius,)
          : new Transform.rotate(
        angle: type == DotType.diamond ? pi/4 : 0.0,
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(color: color, shape: type == DotType.circle? BoxShape.circle : BoxShape.rectangle),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'dart:math';
//
//class FlipLoader extends StatefulWidget {
//  final Color loaderBackground;
//  final Color iconColor;
//  final IconData icon;
//  final String animationType;
//  final String shape;
//  final bool rotateIcon;
//
//  FlipLoader({this.loaderBackground = Colors.redAccent, this.iconColor = Colors.white, this.icon = Icons.sync, this.animationType = "full_flip", this.shape = "square", this.rotateIcon = true});
//
//
//  @override
//  _FlipLoaderState createState() => _FlipLoaderState(this.loaderBackground, this.iconColor, this.icon, this.animationType, this.shape, this.rotateIcon);
//}
//
//class _FlipLoaderState extends State<FlipLoader>
//    with SingleTickerProviderStateMixin {
//
//  AnimationController controller;
//  Animation<double> rotationHorizontal;
//  Animation<double> rotationVertical;
//  Color loaderColor;
//  Color iconColor;
//  IconData icon;
//  Widget loaderIconChild;
//  String animationType;
//  String shape;
//  bool rotateIcon;
//
//  _FlipLoaderState(this.loaderColor, this.iconColor, this.icon, this.animationType, this.shape, this.rotateIcon);
//
//  @override
//  void initState() {
//    super.initState();
//
//    controller = createAnimationController(animationType);
//
//    controller.addStatusListener((status){
//      // Play animation backwards and forwards for full flip
//      if (animationType == "half_flip") {
//        if (status == AnimationStatus.completed) {
//          setState(() {
//            controller.repeat();
//          });
//        }
//      }
//      // play animation on repeat for half flip
//      else if (animationType == "full_flip") {
//        if (status == AnimationStatus.dismissed) {
//          setState(() {
//            controller.forward();
//          });
//        }
//        if (status == AnimationStatus.completed) {
//          setState(() {
//            controller.repeat();
//          });
//        }
//      }
//      // custom animation state
//      else {
//        print("TODO not sure yet");
//      }
//    });
//
//    controller.forward();
//  }
//
//  AnimationController createAnimationController([String type = 'full_flip']) {
//    AnimationController animCtrl;
//
//    switch(type) {
//      case "half_flip":
//        animCtrl = AnimationController(duration: const Duration(milliseconds: 4000), vsync: this);
//
//        // Horizontal animation
//        this.rotationHorizontal = Tween<double>(begin: 0.0, end: 1.0).animate(
//            CurvedAnimation(
//                parent: animCtrl,
//                curve: Interval(0.0, 0.50, curve: Curves.linear)));
//
//        // Vertical animation
//        this.rotationVertical = Tween<double>(begin: 0.0, end: 1.0).animate(
//            CurvedAnimation(
//                parent: animCtrl,
//                curve: Interval(0.50, 1.0, curve: Curves.linear)));
//        break;
//      case "full_flip":
//      default:
//        animCtrl = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
//
//        this.rotationHorizontal = Tween<double>(begin: 0.0, end: 1.0).animate(
//            CurvedAnimation(
//                parent: animCtrl,
//                curve: Interval(0.0, 0.50, curve: Curves.linear)));
//        this.rotationVertical = Tween<double>(begin: 0.0, end: 1.0).animate(
//            CurvedAnimation(
//                parent: animCtrl,
//                curve: Interval(0.50, 1.0, curve: Curves.linear)));
//        break;
//    }
//
//    return animCtrl;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    if (animationType == "half_flip") {
//      return buildHalfFlipper(context);
//    } else {
//      return buildFullFlipper(context);
//    }
//  }
//
//  Widget buildHalfFlipper(BuildContext context) {
//    return new AnimatedBuilder(
//      animation: controller,
//      builder: (BuildContext context, Widget child) {
//        return Container(
//          child: new Transform(
//            transform: Matrix4.identity()
//              ..setEntry(3, 2, 0.006)
//              ..rotateX(sin(2*pi * rotationVertical.value))
//              ..rotateY(sin(2*pi * rotationHorizontal.value)),
//            alignment: Alignment.center,
//            child: Container(
//                decoration: BoxDecoration(
//                  shape: shape == "circle" ? BoxShape.circle : BoxShape.rectangle,
//                  borderRadius: shape == "circle" ? null : new BorderRadius.all(const Radius.circular(8.0)),
//                  color: loaderColor,
//                ),
//                width: 40.0,
//                height: 40.0,
//                child: rotateIcon == true ? new RotationTransition(
//                  turns: rotationHorizontal.value == 1.0 ? rotationVertical : rotationHorizontal,
//                  child: new Center(
//                    child: Icon(
//                      icon,
//                      color: iconColor,
//                      size: 20.0,
//                    ),
//                  ),
//                ) : Center(
//                  child: Icon(
//                    icon,
//                    color: iconColor,
//                    size: 20.0,
//                  ),
//                )
//            ),
//          ),
//        );
//      },
//    );
//  }
//
//  Widget buildFullFlipper(BuildContext context) {
//    return new AnimatedBuilder(
//      animation: controller,
//      builder: (BuildContext context, Widget child) {
//        return Container(
//          child: new Transform(
//            transform: Matrix4.identity()
//              ..setEntry(3, 2, 0.006)
//              ..rotateX((2* pi * rotationVertical.value))
//              ..rotateY((2* pi * rotationHorizontal.value)),
//            alignment: Alignment.center,
//            child: Container(
//              decoration: BoxDecoration(
//                shape: shape == "circle" ? BoxShape.circle : BoxShape.rectangle,
//                borderRadius: shape == "circle" ? null : new BorderRadius.all(const Radius.circular(8.0)),
//                color: loaderColor,
//              ),
//              width: 40.0,
//              height: 40.0,
//              child: new Center(
//                child: Icon(
//                  icon, color: iconColor, size: 20.0,
//                ),
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }
//}
////import 'dart:math';
////
/////**
//// * Author: Damodar Lohani
//// * profile: https://github.com/lohanidamodar
//// */
////
////import 'package:flutter/material.dart';
////
////class LoaderTwo extends StatefulWidget {
////  final Color centralDotColor;
////  final Color dotOneColor;
////  final Color dotTwoColor;
////  final Color dotThreeColor;
////  final Color dotFourColor;
////  final Color dotFiveColor;
////  final Color dotSixColor;
////  final Color dotSevenColor;
////  final Color dotEightColor;
////  final double centralDotRadius;
////  final double outerDotRadius;
////  final double spanRadius;
////  final Duration duration;
////
////  LoaderTwo({Key key, this.centralDotColor = Colors.lightGreen, this.dotOneColor=Colors.lightGreen, this.dotTwoColor=Colors.lightGreen, this.dotThreeColor=Colors.lightGreen, this.dotFourColor=Colors.lightGreen, this.dotFiveColor=Colors.lightGreen, this.dotSixColor=Colors.lightGreen, this.dotSevenColor=Colors.lightGreen, this.dotEightColor=Colors.lightGreen, this.centralDotRadius=15.0, this.spanRadius=15.0, this.duration = const Duration(seconds: 2), this.outerDotRadius = 5.0 }) : super(key: key);
////
////  _LoaderTwoState createState() => _LoaderTwoState(centralDotRadius);
////}
////
////class _LoaderTwoState extends State<LoaderTwo> with SingleTickerProviderStateMixin {
////  AnimationController controller;
////  Animation<double> animationRotation;
////  Animation<double> animationRadiusIn;
////  Animation<double> animationRadiusOut;
////
////  final double initialRadius;
////  double radius = 0.0;
////
////  _LoaderTwoState(this.initialRadius);
////
////  @override
////  void initState() {
////    super.initState();
////    controller = AnimationController(
////        vsync: this,
////        duration: widget.duration);
////
////    animationRadiusIn = Tween<double>(begin: 1.0, end: 0.0).animate(
////        CurvedAnimation(parent: controller, curve: Interval(0.75, 1.0, curve: Curves.elasticIn),)
////    );
////    animationRadiusOut = Tween<double>(begin: 0.0, end: 1.0).animate(
////        CurvedAnimation(parent: controller, curve: Interval(0.0, 0.25, curve: Curves.elasticOut),)
////    );
////    animationRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
////        CurvedAnimation(parent: controller, curve: Interval(0.0, 1.0, curve: Curves.linear))
////    );
////
////    controller.addListener((){
////      if(controller.value >= 0.75 && controller.value <= 1.0) {
////        setState(() {
////          radius = animationRadiusIn.value * initialRadius;
////        });
////      }else if(controller.value >= 0.0 && controller.value <= 0.25) {
////        setState(() {
////          radius = animationRadiusOut.value * initialRadius;
////        });
////      }
////    });
////
////    controller.repeat();
////  }
////
////  @override
////  void dispose() {
////    super.dispose();
////    controller.dispose();
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    return Container(
////      height: 100.0,
////      width: 100.0,
////      child: Center(
////        child: RotationTransition(
////          turns: animationRotation,
////          child: Stack(
////            children: <Widget>[
////              Dot(radius: widget.centralDotRadius,color: widget.centralDotColor,),
////              Transform.translate(
////                  offset: Offset(cos(pi/4)*radius, sin(pi/4)*radius),
////                  child: Dot(radius: widget.outerDotRadius,color: widget.dotOneColor,)),
////              Transform.translate(
////                  offset: Offset(cos(2*pi/4)*radius, sin(2*pi/4)*radius),
////                  child: Dot(radius: widget.outerDotRadius,color: widget.dotTwoColor,)),
////              Transform.translate(
////                  offset: Offset(cos(3*pi/4)*radius, sin(3*pi/4)*radius),
////                  child: Dot(radius: widget.outerDotRadius,color: widget.dotThreeColor,)),
////              Transform.translate(
////                  offset: Offset(cos(pi)*radius, sin(pi)*radius),
////                  child: Dot(radius: widget.outerDotRadius,color: widget.dotFourColor,)),
////              Transform.translate(
////                  offset: Offset(cos(5*pi/4)*radius, sin(5*pi/4)*radius),
////                  child: Dot(radius: widget.outerDotRadius,color: widget.dotFiveColor,)),
////              Transform.translate(
////                  offset: Offset(cos(6*pi/4)*radius, sin(6*pi/4)*radius),
////                  child: Dot(radius: widget.outerDotRadius,color: widget.dotSixColor,)),
////              Transform.translate(
////                  offset: Offset(cos(7*pi/4)*radius, sin(7*pi/4)*radius),
////                  child: Dot(radius: widget.outerDotRadius,color: widget.dotSevenColor,)),
////              Transform.translate(
////                  offset: Offset(cos(8*pi/4)*radius, sin(8*pi/4)*radius),
////                  child: Dot(radius: widget.outerDotRadius,color: widget.dotEightColor,)),
////            ],
////          ),
////        ),
////      ),
////    );
////  }
////}
////
////class Dot extends StatelessWidget {
////  final double radius;
////  final Color color;
////
////  const Dot({Key key, this.radius, this.color}) : super(key: key);
////
////  @override
////  Widget build(BuildContext context) {
////    return Center(
////      child: Container(
////        width: radius,
////        height: radius,
////        decoration: BoxDecoration(
////            color: color,
////            shape: BoxShape.circle
////        ),
////      ),
////    );
////  }
////}