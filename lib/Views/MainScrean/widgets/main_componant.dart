import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';

class MainComponent extends StatelessWidget {
  final Function()? onTap;
  final String? image;
  final String? title;
  final Color? color;

  const MainComponent({
    Key? key,
    this.onTap,
    this.image,
    this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 50.w,
          decoration: BoxDecoration(  // Removed 'const' keyword
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: 10.h,),

                  Image(
                    image: AssetImage(image! ),  // Used image parameter
                    width: 50.w,
                    height: 50.h,
                  ),
                  SizedBox(height: 10.h,),
                  Text(
                    title! ,  // Used title parameter
                    style:  TextStyle(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
