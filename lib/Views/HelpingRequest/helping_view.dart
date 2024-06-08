import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Views/HelpingRequest/HelpingCubit/helping_cubit.dart';

import '../../generated/l10n.dart';

class HelpingView extends StatelessWidget {
   HelpingView({Key? key}) : super(key: key);
TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text(S.of(context).RequestHelp),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      body:  BlocProvider(
  create: (context) => HelpingCubit(),
  child: BlocConsumer<HelpingCubit, HelpingState>(
  listener: (context, state) {
 if (state is HelpingLoaded) {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
     backgroundColor: Colors.green,
     content: Text('Request Sent'),
   ));
  } else if (state is HelpingError) {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
     backgroundColor: Colors.red,
     content: Text('Error'),
   ));
 }
  },
  builder: (context, state) {
    var cubit = HelpingCubit.get(context);
    return Column(
        children: [
          Center(
            child: Text(S.of(context).send_request,style:TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ) ,),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 10,
              controller: _controller,
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                  ),
                    ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),

                hintText: S.of(context).enter_your_request,
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),

            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () async{
              if (_controller.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Please Enter Request'),
                ));
                return;
              }
              await cubit.sendRequest(message: _controller.text);

            },
            child: Text(S.of(context).send_request,style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ) ,
    ),
            style: ElevatedButton.styleFrom(
             backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      );
  },
),
),
    );
  }
}
