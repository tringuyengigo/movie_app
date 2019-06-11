
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:movie_app/model/MediaItem.dart';
import 'package:movie_app/util/utils.dart';


class MediaApi {
  var client = Client();
  final _http = HttpClient();

  Future<dynamic> _getJson(Uri uri) async {
    var response = await (await _http.getUrl(uri)).close();
    var transformedResponse = await response.transform(utf8.decoder).join();
    print("_getJson" + response.toString());
    return json.decode(transformedResponse);
  }

  Future<List<MediaItem>> loadMovies(int page, String category) async {
    var url = Uri.https(baseUrl, '3/movie/$category',
        {'api_key': API_KEY, 'page': page.toString()});

    print("[MediaApi] Link load loadMovies " + url.toString());

    return _getJson(url).then((json) => json['results']).then((data) => data
        .map<MediaItem>((item) => MediaItem(item, MediaType.movie))
        .toList());
  }

  Future<List<MediaItem>> loadTVShows(int page, String category) async {
    var url = Uri.https(baseUrl, '3/tv/$category',
        {'api_key': API_KEY, 'page': page.toString()});

    print("[MediaApi] Link load loadTVShows " + url.toString());

    return _getJson(url).then((json) => json['results']).then((data) => data
        .map<MediaItem>((item) => MediaItem(item, MediaType.show))
        .toList());
  }



}