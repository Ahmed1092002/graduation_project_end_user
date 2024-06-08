import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project_end_user/Views/Culture_content/CultuleCubit/content_cubit.dart';
import 'package:graduation_project_end_user/Views/Culture_content/content_details.dart';

import '../../generated/l10n.dart';
import '../../utils/navigator.dart';

class ContentView extends StatelessWidget {
  const ContentView({Key? key}) : super(key: key);


  Color generateRandomLightBlueColor() {
    final Random random = Random();
    final int minBlueValue = 128; // Minimum value to ensure light blue (128 out of 255)
    final int blueValue = minBlueValue + random.nextInt(128); // Random value between 128 and 255
    return Color.fromARGB(255, 0, 0, blueValue);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Cultures_And_Content,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Colors.white,

      ),
      body: SingleChildScrollView(
        child: BlocProvider(
  create: (context) => ContentCubit()..getAllContent(),
  child: BlocConsumer<ContentCubit, ContentState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    final cubit = ContentCubit.get(context);
    return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: State is ContentLoading? CircularProgressIndicator(): ListView.builder(
              itemCount: cubit.content.length,
              itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  navigateToScreen(context, ContentDetails(contentModel: cubit.content[index]));
                },
                child: Container(
                  height: 100.h,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: generateRandomLightBlueColor(),
                    border: Border.all(color: Colors.black),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    "${cubit.content[index].title}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }
          ),
        );
  },
),
)
      ),
    );
  }
}
