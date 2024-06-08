import 'package:flutter/material.dart';
import 'package:graduation_project_end_user/Models/ContentModel.dart';

class ContentDetails extends StatelessWidget {
  final ContentModel? contentModel;

  const ContentDetails({Key? key, this.contentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.blueAccent),
        title: Text(
          ' ${contentModel?.title ?? ''}',
          style: const TextStyle(
            color: Colors.blueAccent,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:  Center(
        child: Text(
          ' ${contentModel?.description ?? ''}',
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
