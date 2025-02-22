import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siya/api/api.dart';
import 'package:siya/data/modeldata.dart';

// Controller
class StoryController extends GetxController {
  var stories = <Story>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchStories();
    super.onInit();
  }

  Future<void> fetchStories() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      stories.clear(); // Clear old data before fetching new data
      List<int> storyIds = await ApiService.fetchTopStories();
      for (var id in storyIds.take(10)) {
        try {
          Story story = await ApiService.fetchStory(id);
          stories.add(story);
        } catch (e) {
          errorMessage.value = "Some stories failed to load.";
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}