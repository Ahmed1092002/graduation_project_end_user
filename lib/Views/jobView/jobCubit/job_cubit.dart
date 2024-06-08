import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Models/JobAppliedModel.dart';
import 'package:graduation_project_end_user/Models/JobModel.dart';
import 'package:graduation_project_end_user/utils/cashe_helper.dart';
import 'package:graduation_project_end_user/utils/dio_helper.dart';
import 'package:meta/meta.dart';

import '../../../Models/JobResponseModel.dart';

part 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  JobCubit() : super(JobInitial());
  static JobCubit get(context) => BlocProvider.of(context);

  List<JobResponseModel>? jobResponseModel;
  List<JobModel>? jobModelList=[];
  JobModel? jobModel;

  getjob() async {
    emit(JobLoading());
 var cv = await CashHelper.getData(key: 'cv');
 print (cv);
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var data = json.encode({
        "url": cv,
      });
      var dio = Dio();




      var response = await dio.request(
        'https://jobrecommender-production.up.railway.app/upload',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {

        jobResponseModel = (response.data as List).map((e) => JobResponseModel.fromJson(e)).toList();


        emit(JobLoaded());
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
        emit(JobError());
      }
    } catch (e) {
      print(e.toString());
      emit(JobError());
    }
  }
  JobAppliedModel? jobAppliedModel;
List<JobAppliedModel>   ? jobAppliedModelList;
  applyJob({int? id})async{
    emit (JobApplyingLoading());
    var refugeeId = await CashHelper.getData(key: 'refugeeId');
    try {
      var response = await DioHelper.postData(url:'/RefugeeAppliedJobs',
        data: {
          "refugeeId": refugeeId,
          "jobId": id,
          "applyDate": "2024-06-04T12:59:46.857Z",
        }

      );
      if(response.statusCode == 200|| response.statusCode == 201){
        jobAppliedModel = JobAppliedModel.fromJson(response.data);

        emit(JobApplyingSuccess());
      }
      else{
        print (response.data);
        emit(JobApplyingError(
            response.data
        ));
      }
      
    }
    catch(e){
      print(e.toString());
    }
  }
  getAllAppliedjobs() async {
    var refugeeId = await CashHelper.getData(key: 'refugeeId');
    try {
      emit(getAllAppliedjobsLoading());
      var response = await DioHelper.getData(url: '/RefugeeAppliedJobs/$refugeeId');
      if (response.statusCode == 200) {
        print(response.data);
        jobAppliedModelList = (response.data as List).map((e) => JobAppliedModel.fromJson(e)).toList();
        jobModelList?.clear(); // Clear the list before adding new items

        for (var jobApplied in jobAppliedModelList!) {
          var job = await getJobById(jobApplied.jobId!);
          if (job != null) {
            jobModelList?.add(job);
          }
        }
        emit(getAllAppliedjobsSuccess());
      } else {
        emit(getAllAppliedjobsError());
      }
    } catch (e) {
      print(e.toString());
      emit(getAllAppliedjobsError());
    }
  }

  Future<JobModel?> getJobById(int id) async {
    emit(GetJobByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/Jobs/$id");
      if (response.statusCode == 200) {
        var jobModel = JobModel.fromJson(response.data);
        emit(GetJobByIdSuccess());
        return jobModel;
      } else {
        emit(GetJobByIdError());
        throw Exception('Failed to load job');
      }
    } catch (e) {
      emit(GetJobByIdError());
      throw Exception('Failed to load job: $e');
    }
  }
}





