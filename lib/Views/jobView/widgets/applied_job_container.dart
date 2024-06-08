import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Models/JobAppliedModel.dart';
import '../../../Models/JobModel.dart';

class AppliedJobContainer extends StatelessWidget {
   AppliedJobContainer({Key? key,
     this.jobModel,
     this.jobAppliedModel
   }) : super(key: key);
  JobModel? jobModel;
   JobAppliedModel? jobAppliedModel;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: Container(

        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blueAccent,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      jobModel!.jobName!,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  if (jobAppliedModel!.jobStatus == 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Pending',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Icon(Icons.pending_actions_outlined, color: Colors.grey)
                      ],
                    ),
                  if (jobAppliedModel!.jobStatus == 1)
                    Column(
                      children: [
                        Text(
                          'Accepted',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Icon(Icons.check_circle, color: Colors.green)
                      ],
                    ),
                  if (jobAppliedModel!.jobStatus == 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Rejected',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Icon(Icons.cancel, color: Colors.red)
                      ],
                    ),
                ],
              ),

              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Salary :',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    jobModel!.salary!.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Years Of Experience :',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    jobModel!.yearsOfExperience!.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Text(
              //   'yearsOfExperience',
              //   style: TextStyle(
              //     fontSize: 15,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Location :',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    jobModel!.location!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
            ],
          ),
        ),


      ),
    );
  }
}
