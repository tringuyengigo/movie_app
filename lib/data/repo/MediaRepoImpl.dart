

import 'package:movie_app/data/remote/MediaApi.dart';
import 'package:movie_app/data/repo/MediaRepo.dart';
import 'package:movie_app/model/MediaItem.dart';

class MediaRepoImpl with MediaRepo {
  static MediaRepo instance;

  static MediaRepo getInstance() {
    if (instance == null) {
      instance = MediaRepoImpl();
    }
    return instance;
  }

  MediaApi mediaApi = MediaApi(); //online

  @override
  Future<List<MediaItem>> loadMovies(String category, int page) async {
    List<MediaItem> mediaOnline = await mediaApi.loadMovies(page, category);
    return mediaOnline;
  }

  @override
  Future<List<MediaItem>> loadTVShows(String category, int page) async {
    List<MediaItem> mediaOnline = await mediaApi.loadTVShows(page, category);
    return mediaOnline;
  }
}
