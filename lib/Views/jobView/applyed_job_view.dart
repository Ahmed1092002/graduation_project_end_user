import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Views/jobView/jobCubit/job_cubit.dart';
import 'package:graduation_project_end_user/Views/jobView/widgets/applied_job_container.dart';

import '../../generated/l10n.dart';

class ApplyedJobView extends StatelessWidget {
  const ApplyedJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobCubit()..getAllAppliedjobs(),
      child: BlocConsumer<JobCubit, JobState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = JobCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).yourAppliedJobs),
              titleTextStyle: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 20,
              ),
            ),
            body: state is getAllAppliedjobsLoading || state is GetJobByIdLoading
                ? Center(child: CircularProgressIndicator())
                : cubit.jobAppliedModelList == null || cubit.jobModelList == null
                ? Center(child: Text("No jobs found"))
                : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: ListView.builder(
                    itemCount: cubit.jobAppliedModelList!.length,
                    itemBuilder: (context, index) {
                      if (index < cubit.jobModelList!.length) {
                        return AppliedJobContainer(
                          jobModel: cubit.jobModelList![index],
                          jobAppliedModel: cubit.jobAppliedModelList![index],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
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

