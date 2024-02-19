import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project_end_user/Views/MainScrean/View/main_Screen.dart';
import 'package:hive/hive.dart';



class SecondClass extends StatefulWidget {
  @override
  _SecondClassState createState() => _SecondClassState();
}

class _SecondClassState extends State<SecondClass>
    with TickerProviderStateMixin {
  AnimationController? scaleController;
  Animation<double>? scaleAnimation;

  double _opacity = 0;
  bool _value = true;
  final storage = new FlutterSecureStorage();

  var Token;
  var userTypes;
  Widget? route;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..addStatusListener(
          (status) async {

        // Token = await storage.read(key: 'uid');
        // userTypes = await Hive.box(boxName).get('userType');
        // print ("user type $userTypes");
        // print (Token);
        //
        // if (Token != null  ) {
        //   if (userTypes == 'users') {
        //     route=  MainScrean();
        //   } else if (userTypes == 'company') {
        //     route= CompanyMainScrean();
        //   } else if (userTypes == null) {
        //     route=  LoginScrean();
        //   }
        //
        // }else{
        //   route=  LoginScrean();
        // }
route= MainScrean();
        if (status == AnimationStatus.completed) {

          Navigator.of(context).pushReplacement(

            ThisIsFadeRoute(
              route: route,
            ),
          );

          Timer(
            Duration(milliseconds: 300),
                () {
              scaleController!.reset();
            },
          );

        }
      },
    );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController!);

    Timer(Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(Duration(milliseconds: 2000), () {
      setState(() {
        scaleController!.forward();
      });
    });
  }

  @override
  void dispose() {
// TODO: implement dispose
    scaleController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: AnimatedOpacity(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(seconds: 6),
          opacity: _opacity,
          child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(seconds: 2),
            height: _value ? 50 : 200,
            width: _value ? 50 : 200,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(.2),
                  blurRadius: 100,
                  spreadRadius: 10,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/image/preview-HMeq0RCYE-transformed.png',
                      ),
                    ),
                    color: Colors.white, shape: BoxShape.rectangle),
                child: AnimatedBuilder(
                  animation: scaleAnimation!,
                  builder: (c, child) => Transform.scale(
                    scale: scaleAnimation!.value,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        color: Colors.blue,

                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget? page;
  final Widget? route;

  ThisIsFadeRoute({this.page, this.route})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page!,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: route,
        ),
  );
}
