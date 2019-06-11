import 'package:movie_app/data/repo/MediaRepo.dart';
import 'package:movie_app/data/repo/MediaRepoImpl.dart';
import 'package:movie_app/model/MediaItem.dart';
import 'package:movie_app/util/utils.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreenViewModel extends Model {
  static HomeScreenViewModel _instance;

  int pageMoviePopular = 1;
  int pageMovieUpcoming = 1;
  int pageMovieTopRated = 1;
  int pageTvPopular = 1;
  int pageTvOnTheAir = 1;
  int pageTvTopRated = 1;

  String category = "popular";
  LoadingState isLoadingMoviePopular = LoadingState.LOADING;
  LoadingState isLoadingMovieUpcoming = LoadingState.LOADING;
  LoadingState isLoadingMovieTopRated = LoadingState.LOADING;
  LoadingState isLoadingTvPopular = LoadingState.LOADING;
  LoadingState isLoadingTvOnTheAir = LoadingState.LOADING;
  LoadingState isLoadingTvTopRated = LoadingState.LOADING;

  static HomeScreenViewModel getInstance() {
    if (_instance == null) {
      _instance = HomeScreenViewModel();
    }
    return _instance;
  }

  MediaRepo mediaRepo = MediaRepoImpl();

  List<MediaItem> moviePopularTempList = [];
  List<MediaItem> movieUpComingTempList = [];
  List<MediaItem> movieTopRateTempList = [];

  List<MediaItem> moviePopularListStore = [];
  List<MediaItem> movieUpComingListStore = [];
  List<MediaItem> movieTopRateListStore = [];

  List<MediaItem> tvPopularTempList = [];
  List<MediaItem> tvTVShowOnTheAirTempList = [];
  List<MediaItem> tvTopRateTempList = [];

  List<MediaItem> tvPopularListStore = [];
  List<MediaItem> tvTVShowOnTheAirListStore = [];
  List<MediaItem> tvTopRateListStore = [];


  HomeScreenViewModel() {
    updateMoviePopular("popular");
    updateMovieUpComing("upcoming");
    updateMovieTopRate("top_rated");

    updateTVShowPopular("popular");
    updateTVShowOnTheAir("on_the_air");
    updateTVShowTopRate("top_rated");

  }

  void updateMoviePopular(String key) async {
    isLoadingMoviePopular = LoadingState.LOADING;
    try {
      category = key;
      print("HomeScreenViewModel -> updateMoviePopular() category " + category);
      moviePopularTempList = await mediaRepo.loadMovies(category, pageMoviePopular);
      moviePopularListStore.addAll(moviePopularTempList);
      isLoadingMoviePopular = LoadingState.DONE;
      pageMoviePopular++;
      notifyListeners();
    } catch (e) {
      print("HomeScreenViewModel -> updateMoviePopular() exception " + e.toString());
      isLoadingMoviePopular = LoadingState.ERROR;
    }
  }

  void updateMovieTopRate(String key) async {
    isLoadingMovieTopRated = LoadingState.LOADING;
    try {
      category = key;
      print("HomeScreenViewModel -> updateMovieTopRate() category " + category);
      movieTopRateTempList = await mediaRepo.loadMovies(category, pageMovieTopRated);
      movieTopRateListStore.addAll(movieTopRateTempList);
      isLoadingMovieTopRated = LoadingState.DONE;
      pageMovieTopRated++;
      notifyListeners();
    } catch (e) {
      print("HomeScreenViewModel -> updateMovieTopRate() exception " + e.toString());
      isLoadingMovieTopRated = LoadingState.ERROR;
    }
  }

  void updateMovieUpComing(String key) async {
    isLoadingMovieUpcoming = LoadingState.LOADING;
    try {
      category = key;
      print("HomeScreenViewModel -> updateMovieUpComing() category " + category);
      movieUpComingTempList = await mediaRepo.loadMovies(category, pageMovieUpcoming);
      movieUpComingListStore.addAll(movieUpComingTempList);
      isLoadingMovieUpcoming = LoadingState.DONE;
      pageMovieUpcoming++;
      notifyListeners();
    } catch (e) {
      print("HomeScreenViewModel -> updateMovieUpComing() exception " + e.toString());
      isLoadingMovieUpcoming = LoadingState.ERROR;
    }
  }

  void updateTVShowPopular(String key) async {
    isLoadingTvPopular = LoadingState.LOADING;
    try {
      category = key;
      print("HomeScreenViewModel -> updateTVShowPopular() category " + category);
      tvPopularTempList = await mediaRepo.loadTVShows(category, pageTvPopular);
      tvPopularListStore.addAll(tvPopularTempList);
      isLoadingTvPopular = LoadingState.DONE;
      pageTvPopular++;
      notifyListeners();
    } catch (e) {
      print("HomeScreenViewModel -> updateTVShowPopular() exception " + e.toString());
      isLoadingTvPopular = LoadingState.ERROR;
    }
  }

  void updateTVShowTopRate(String key) async {
    isLoadingTvTopRated = LoadingState.LOADING;
    try {
      category = key;
      print("HomeScreenViewModel -> updateTVShowTopRate() category " + category);
      tvTopRateTempList = await mediaRepo.loadTVShows(category, pageTvTopRated);
      tvTopRateListStore.addAll(tvTopRateTempList);
      isLoadingTvTopRated = LoadingState.DONE;
      pageTvTopRated++;
      notifyListeners();
    } catch (e) {
      print("HomeScreenViewModel -> updateTVShowTopRate() exception " + e.toString());
      isLoadingTvTopRated = LoadingState.ERROR;
    }
  }

  void updateTVShowOnTheAir(String key) async {
    isLoadingTvOnTheAir = LoadingState.LOADING;
    try {
      category = key;
      print("HomeScreenViewModel -> updateTVShowOnTheAir() category " + category);
      tvTVShowOnTheAirTempList = await mediaRepo.loadTVShows(category, pageTvOnTheAir);
      tvTVShowOnTheAirListStore.addAll(tvTVShowOnTheAirTempList);
      isLoadingTvOnTheAir = LoadingState.DONE;
      pageTvOnTheAir++;
      notifyListeners();
    } catch (e) {
      print("HomeScreenViewModel -> updateTVShowOnTheAir() exception " + e.toString());
      isLoadingTvOnTheAir = LoadingState.ERROR;
    }
  }


  static void destroyInstance() {
    _instance = null;
  }
}