class Video {
  final String? id;
  final String? title;
  final String? thumbnailUrl;
  final String? channelTitle;
  final String? duration;

  Video({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
    this.duration,
  });

  factory Video.fromMap(Map<String, dynamic> item) {
    return Video(
      id: item['snippet']['resourceId']['videoId'],
      title: item['snippet']['title'],
      thumbnailUrl: item['snippet']['thumbnails']['high']['url'],
      channelTitle: item['snippet']['channelTitle'],
      duration: item['contentDetails']['endAt']?? '0',
    );
  }

    factory Video.fromMapSearch(Map<String, dynamic> item) {
    return Video(
      id: item['id']['videoId'],
      title: item['snippet']['title'],
      thumbnailUrl: item['snippet']['thumbnails']['high']['url'],
      channelTitle: item['channelTitle'],
    );
  }
}