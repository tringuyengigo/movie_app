import 'package:movie_app/model/MediaItem.dart';

abstract class MediaRepo {
  Future<List<MediaItem>> loadMovies(String category, int page);
  Future<List<MediaItem>> loadTVShows(String category, int page);

}