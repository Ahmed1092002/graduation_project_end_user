import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Views/jobView/jobCubit/job_cubit.dart';
import 'package:graduation_project_end_user/Views/jobView/job_details_view.dart';
import 'package:graduation_project_end_user/Views/jobView/widgets/job_container.dart';
import 'package:graduation_project_end_user/utils/navigator.dart';

import '../../generated/l10n.dart';

class ListOfJobView extends StatelessWidget {
  const ListOfJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => JobCubit()..getjob(),
  child: BlocConsumer<JobCubit, JobState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    final cubit = JobCubit.get(context);
    // if (cubit.jobResponseModel == null) {
    //   return const Center(
    //     child: CircularProgressIndicator(
    //       color: Colors.blueAccent,
    //     ),
    //   );
    // }
    return Scaffold(
      appBar: AppBar(
        title:  Text(S.of(context).job),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        )
      ),
      body: State is JobLoading || cubit.jobResponseModel == null ? Center(
        child: CircularProgressIndicator(

          color: Colors.blueAccent,
        ),
      ):  Center(
        child: SingleChildScrollView(

          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

            child: State is JobLoading || cubit.jobResponseModel == null ? Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            ): ListView.builder(
              itemCount: cubit.jobResponseModel!.length,
                itemBuilder:(context,index){
                return InkWell(
                    onTap: (){
                      navigateToScreen(context, JobDetailsView(
                        jobModel: cubit.jobResponseModel![index],

                      ));
                    },

                    child: JobContainer(
                      jobModel: cubit.jobResponseModel![index],

                    ));
                }
            ),
          ),
        ),
      ),
    );
  },
),
);
  }
}
