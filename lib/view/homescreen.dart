import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siya/viewcontroller/controller.dart';
// Screens
class HomeScreen extends StatelessWidget {
  final StoryController controller = Get.put(StoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hacker News")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value, style: TextStyle(color: Colors.red)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.fetchStories,
                  child: Text("Retry"),
                )
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.stories.length,
          itemBuilder: (context, index) {
            final story = controller.stories[index];
            return ListTile(
              title: Text(story.title),
              subtitle: Text(story.url.isEmpty ? "No URL available" : story.url),
              onTap: () {
                if (story.url.isNotEmpty) {
                  // Open URL in browser
                }
              },
            );
          },
        );
      }),
    );
  }
}


