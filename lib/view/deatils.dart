import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siya/data/modeldata.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryDetailScreen extends StatelessWidget {
  final Story story;

  StoryDetailScreen({required this.story});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar("Error", "Could not open the link");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(story.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(story.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            if (story.text != null && story.text!.isNotEmpty) ...[
              Text(story.text!, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
            ],
            if (story.url.isNotEmpty)
              ElevatedButton(
                onPressed: () => _launchURL(story.url),
                child: Text("Read More"),
              ),
          ],
        ),
      ),
    );
  }
}