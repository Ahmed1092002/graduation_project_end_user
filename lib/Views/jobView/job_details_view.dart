import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project_end_user/Models/JobModel.dart';
import 'package:graduation_project_end_user/Views/jobView/jobCubit/job_cubit.dart';
import 'package:graduation_project_end_user/Views/jobView/list_of_job_view.dart';
import 'package:graduation_project_end_user/utils/navigator.dart';

import '../../Models/JobResponseModel.dart';

class JobDetailsView extends StatelessWidget {
   JobDetailsView({Key? key, this.jobModel}) : super(key: key);
   JobResponseModel? jobModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
        titleTextStyle: const TextStyle(
          color: Colors.blueAccent,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
  create: (context) => JobCubit(),
  child: BlocConsumer<JobCubit,JobState>(
  listener: (context, state) {
  if (state is JobApplyingSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text('Applied Successfully'),
      ),
    );
  } else if (state is JobApplyingError) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     backgroundColor: Colors.red,
    //     content: Text('Error'),
    //   ),
    // );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('Refugee Alredy Applied on this Job'),
      ),
    );

  }
  },
  builder: (context, state) {
    final cubit = JobCubit.get(context);
    return Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(

                child: Column(
mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                       border: Border.all(
                         color: Colors.blueGrey,
                         width: 1,
                       ),
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        jobModel!.jobName!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    //salary
                    SizedBox(height: 10),
                    Text(
                      'Salary',

                      style: TextStyle(
                        fontSize:17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        jobModel!.salary.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),

                    //country
                    SizedBox(height: 10),
                    Text(
                      'Country',

                      style: TextStyle(
                        fontSize:17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        jobModel!.country!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    //Location
                    SizedBox(height: 10),
                    Text(
                      'Location',

                      style: TextStyle(
                        fontSize:17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        jobModel!.location!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    //Years of Experience
                    SizedBox(height: 10),
                    Text(
                      'Years of Experience',

                      style: TextStyle(
                        fontSize:17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.2,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        jobModel!.yearsOfExperience.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    //Description
                    SizedBox(height: 10),
                    Text(
                      'Description',

                      style: TextStyle(
                        fontSize:17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text(
                        jobModel!.description!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    MaterialButton(onPressed: () async {
                 await     cubit.applyJob(
                        id: jobModel!.jobID,
                      );
                 if (State is JobApplyingSuccess) {
                   navigateToScreenAndExit(context, ListOfJobView());
                 }else if (State is JobApplyingError) {
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       backgroundColor: Colors.red,
                       content: Text('Refugee Alredy Applied on this Job'),
                     ),
                   );

                 }




                    },
                      child: Text('Apply Now',style: TextStyle(fontSize: 20.sp),),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
        );
  },
),
),
      ) ,

    );
  }
}
