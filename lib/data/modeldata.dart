// Models
class Story {
  final int id;
  final String title;
  final String url;
  final String? text;

  Story({required this.id, required this.title, required this.url, this.text});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      title: json['title'] ?? 'No title',
      url: json['url'] ?? '',
      text: json['text'] ?? '',
    );
  }
}