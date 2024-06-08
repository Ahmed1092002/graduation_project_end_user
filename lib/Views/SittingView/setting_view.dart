import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project_end_user/Views/EditProfile/PersonView/PersonCubit/person_cubit.dart';
import 'package:graduation_project_end_user/Views/EditProfile/PersonView/person_view.dart';
import 'package:graduation_project_end_user/Views/EditProfile/refugee_view/RefugeeCubit/refugee_cubit.dart';
import 'package:graduation_project_end_user/utils/navigator.dart';

import '../../generated/l10n.dart';
import '../EditProfile/ChangePassword/change_password_view.dart';
import '../EditProfile/refugee_view/refugge_view.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Setting),
      ),
      body: Center(
        child: Container(

width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(

            children:  <Widget>[
              BlocProvider(
  create: (context) => PersonCubit(),
  child: BlocBuilder<PersonCubit, PersonState>(
  builder: (context, state) {
    return ListTileSetting(
                  onTap: () async{
                    await PersonCubit.get(context).getPersonById();
                    navigateToScreen(context, PersonView(
                      personModel: PersonCubit.get(context).personModel,
                    ));
                  },
                icon: Icons.person ,
                Title: S.of(context).personal_information,
              );
  },
),
),
              
              
              BlocProvider(create: (context) => RefugeeCubit(),
                child: BlocBuilder<RefugeeCubit, RefugeeState>(
                  builder: (context, state) {
                    final cubit = RefugeeCubit.get(context);

                    return   ListTileSetting(
                      onTap: ()async {
                        await cubit.getRefugeeById();
await cubit.getAllCountry();
                        await cubit.getCountryById();
                        navigateToScreen(context, RefuggeView(
                          refugeeModel: cubit.refugeeModel,
                          countryModelList: cubit.countryModelList,
                          countryModel: cubit.countryModel,

                        ));
                      },
                      icon: Icons.info ,
                      Title: S.of(context).Change_Refugee,
                    );
                  },
                ),
              ),

              ListTileSetting(
                  onTap: (){
navigateToScreen(context, ChangePasswordView());
                  },
                icon: Icons.password ,
                Title: S.of(context).Change_Password,
              ),






            ],
          ),
        )
      ),
    );
  }
}

class ListTileSetting extends StatelessWidget {
   ListTileSetting({
    super.key,
    this.Title,
    this.icon,
    this.onTap,
  });
String? Title;
IconData? icon;
Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: ListTile(
        onTap:onTap ,
        title: Text(Title!),
        trailing: Icon(icon!,color: Colors.blueAccent,),
      ),
    );
  }
}
