import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project_end_user/Blocs/localizationCubit/localization_cubit.dart';
import 'package:graduation_project_end_user/Views/MainScrean/widgets/chat_bot_card.dart';
import 'package:graduation_project_end_user/Views/MainScrean/widgets/chat_groub_card.dart';

import '../../../generated/l10n.dart';


class MainScrean extends StatefulWidget {
   MainScrean({Key? key}) : super(key: key);

  @override
  State<MainScrean> createState() => _MainScreanState();
}

class _MainScreanState extends State<MainScrean> {

  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalizationCubit, LocalizationState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      var cubit = LocalizationCubit.get(context);

      return AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(

            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF64C2F5),
                Color(0xFF0B79B3),
              ],
            ),
          ),
        ),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: cubit.isEnglish()? true  : false,
        // openScale: 1.0,

        disabledGestures: false,
        childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 0.0,
          //   ),
          // ],
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        drawer: SafeArea(
          child: Container(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 128.0.w,
                    height: 128.0.h,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 64.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/image/preview-HMeq0RCYE-transformed-removebg-preview.png',
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.home),
                    title: Text(S.of(context).Home,style: TextStyle(fontSize: 15.sp),),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.account_circle_rounded),
                    title: Text(S.of(context).Profile,style: TextStyle(fontSize: 15.sp),),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.favorite),
                    title: Text('Favourites'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.settings),
                    title: Text(S.of(context).Settings,style: TextStyle(fontSize: 15.sp),),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        cubit.ChangeLanguageConndation();
                      });

                    },
                    leading: cubit.isArabic()
                        ? Image.asset('assets/image/united-kingdom.png',width: 40.w,height: 40.h)
                        : Image.asset('assets/image/united-arab-emirates.png',width: 40.w,height: 40.h),
                    title: cubit.isArabic()
                        ? Text('English',style: TextStyle(fontSize: 15.sp),)
                        : Text('العربية',style: TextStyle(fontSize: 15.sp)  ) ,
                  ),





                ],
              ),
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title:  Text(S.of(context).Home),

            leading :cubit.isEnglish()?IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            ) :null ,
            actions: cubit.isEnglish()? null : [
              IconButton(
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
            ],

          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height ,
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1.5),
                      children: [
                        ChatBotCard(),
                        ChatGroubCard(),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    },
    );
  }
}
