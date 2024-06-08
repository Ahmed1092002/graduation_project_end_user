import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project_end_user/Views/FeedbacksView/FeedbackCubit/feedback_cubit.dart';
import 'package:graduation_project_end_user/Views/MainScrean/View/main_Screen.dart';
import 'package:graduation_project_end_user/generated/l10n.dart';
import 'package:graduation_project_end_user/utils/navigator.dart';

class FeedbacksView extends StatelessWidget {
   FeedbacksView({Key? key}) : super(key: key);
  TextEditingController? feedbackController =  TextEditingController() ;
int rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(S.of(context).FeedBack),
      ),
      body:  Center(
        child: BlocProvider(
  create: (context) => FeedbackCubit(),
  child: BlocConsumer<FeedbackCubit, FeedbackState>(
  listener: (context, state) {
if (state is FeedbackLoaded) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green,
    content: Text('Feedback Sent'),
  ));
} else if (state is FeedbackError) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text('Error'),
  ));

}
  },
  builder: (context, state) {
    var cubit = FeedbackCubit.get(context);
    return Container(
      color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,

                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.blueAccent,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                  this.rating = rating.toInt();
                },
              ),
              SizedBox(height: 20,),
              Padding(
                  padding:  EdgeInsets.all(8.0),
                child:  TextField(
                  controller:feedbackController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.blueAccent),

                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    labelText: S.of(context).FeedBack,
                    hintText: S.of(context).FeedBack,
                  ),

                ) ,
              ),

              SizedBox(height: 20,),

              ElevatedButton(
                onPressed: () async {
                  print (rating);
                  print (feedbackController!.text);
                  if (feedbackController!.text.isEmpty ) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please Enter Feedback'),
                    ));
                    return;
                  }
                  await cubit.sendFeedback(rating: rating, message: feedbackController!.text);
                  navigateToScreen(context, MainScrean());
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),

                ),
                child: Text(S.of(context).send_feedback,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),

                ),
              )
            ],
          )

        );
  },
),
),
      ),
    );
  }
}
