import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project_end_user/Views/ProfilePage/ProfileCubit/profile_cubit.dart';
import 'package:graduation_project_end_user/Views/chat_groub_View/pdf_page.dart';
import 'package:graduation_project_end_user/utils/navigator.dart';

import '../../../generated/l10n.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title:  Text(S.of(context).ProfilePage)),
      body: BlocProvider(
  create: (context) => ProfileCubit()..getCountryById()..getRefugeeById()..getPersonById(),
  child: BlocConsumer<ProfileCubit, ProfileState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    final cubit = ProfileCubit.get(context);
    if ( cubit.countryModel==null || cubit.personModel==null|| cubit.refugeeModel==null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: CachedNetworkImageProvider(
                    cubit.refugeeModel!.imagePath!,

                  ),

                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(S.of(context).FirstName, style:TextStyle(
                        fontSize: 15.sp,
                        color: Colors.blueGrey,


                      ) ,),

                                     Container(
             padding: EdgeInsets.all(8),
                       decoration: BoxDecoration(
                      color: Colors.white,
                         border: Border.all(color: Colors.blueAccent),

                       ),
                       child: Text(cubit.personModel!.firstName!),

                                     ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(S.of(context).LastName, style:TextStyle(
                        fontSize: 15.sp,
                        color: Colors.blueGrey,

                      ) ,),
                      Container(
                    padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blueAccent),

                        ),

                        child: Text(cubit.personModel!.lastName!),

                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text("${S.of(context).Email} : ", style:TextStyle(
                    fontSize: 15.sp,
                 color: Colors.blueGrey,

                  ) ,),
                  Container(
                 padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent),

                    ),
                    child: Text(cubit.personModel!.email!),

                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(S.of(context).CV, style:TextStyle(
                    fontSize: 15.sp,
                    color: Colors.blueGrey,

                  ) ,),
                  ElevatedButton(onPressed: (){
                    navigateToScreen(context, PdfPage(
                      path: cubit.refugeeModel!.cv!,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
             backgroundColor: Colors.blueAccent,


                  ),
                    child: Text(S.of(context).ShowYourCv,
                      style: TextStyle(
                        fontSize: 15.sp,
                     color: Colors.white,

                      ) ,

                  ),
                  )
                  // Container(
                  //   width:20.w,
                  //   height: 20.h,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     border: Border.all(color: Colors.blueAccent),
                  //
                  //   ),
                  //   child: Text(cubit.refugeeModel!.cv!),
                  //
                  // ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(S.of(context).CardStartDate, style:TextStyle(
                        fontSize: 15.sp,
                   color: Colors.blueGrey,

                      ) ,),
                      Container(
                        width: 115.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blueAccent),

                        ),
                        child: Text(cubit.refugeeModel!.cardStartDate!),

                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(S.of(context).CardEndDate, style:TextStyle(
                        fontSize: 15.sp,
                     color: Colors.blueGrey,

                      ) ,),
                      Container(

                        width: 115.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blueAccent),

                        ),
                        child: Text(cubit.refugeeModel!.cardEndDate!),

                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text("${S.of(context).RefugeeCardNo} : ", style:TextStyle(
                    fontSize: 15.sp,
          color: Colors.blueGrey,

                  ) ,),
                  Container(
            padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent),

                    ),
                    child: Text(cubit.refugeeModel!.refugeeCardNo!),

                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text("${S.of(context).Birthday} :", style:TextStyle(
                    fontSize: 15.sp,
                   color: Colors.blueGrey,

                  ) ,),
                  Container(
                    width: 115.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent),

                    ),
                    child: Text(cubit.personModel!.dateOfBirth!),

                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text("${S.of(context).Gender} : ", style:TextStyle(
                    fontSize: 15.sp,
                   color: Colors.blueGrey,

                  ) ,),
                  Container(
               padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent),

                    ),
                    child: Text(cubit.personModel!.gender=="Male"?S.of(context).Male:S.of(context).Female)

                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(S.of(context).PhoneNumber, style:TextStyle(
                    fontSize: 15.sp,
                   color: Colors.blueGrey,

                  ) ,),
                  Container(
                  padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent),

                    ),
                    child: Text(cubit.personModel!.phone1!),

                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text("${S.of(context).Country}: ", style:TextStyle(
                    fontSize: 15.sp,
             color: Colors.blueGrey,

                  ) ,),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent),

                    ),
                    child: Text(cubit.countryModel!.countryName!),

                  ),
                ],
              ),




            ],
          ),
        ),
      );
  },
),
)
    );

  }
}
