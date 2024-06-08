import 'package:flutter/material.dart';
import 'package:graduation_project_end_user/Models/JobResponseModel.dart';

class JobContainer extends StatelessWidget {
   JobContainer({Key? key, this.jobModel}) : super(key: key);
  JobResponseModel? jobModel;

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
              Text(
                jobModel!.jobName!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
                ),
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
              SizedBox(height: 15),
              // Text(
              //   'yearsOfExperience',
              //   style: TextStyle(
              //     fontSize: 15,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),

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
