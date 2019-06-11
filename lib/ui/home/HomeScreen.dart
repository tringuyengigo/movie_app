
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/MediaItem.dart';
import 'package:movie_app/ui/home/HomeScreenViewModel.dart';
import 'package:movie_app/util/utils.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {

  @override
  State createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  MediaType mediaType = MediaType.movie;
  int _page = 0;
  LoadingState _loadingState = LoadingState.LOADING;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: HomeScreenViewModel.getInstance(),
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () => goToSearch(context),
            )
          ],
          title: Text("Cinematic"),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xff2b5876),
                          const Color(0xff4e4376),
                        ])),
                  )),
              ListTile(
                title: Text("Search"),
                trailing: Icon(Icons.search),
                onTap: () => goToSearch(context),
              ),
              ListTile(
                title: Text("Favorites"),
                trailing: Icon(Icons.favorite),
                onTap: () => goToFavorites(context),
              ),
              Divider(
                height: 5.0,
              ),
              ListTile(
                title: Text("Movies"),
                selected: mediaType == MediaType.movie,
                trailing: Icon(Icons.local_movies),
                onTap: () {
                  _changeMediaType(MediaType.movie);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("TV Shows"),
                selected: mediaType == MediaType.show,
                trailing: Icon(Icons.live_tv),
                onTap: () {
                  _changeMediaType(MediaType.show);
                  Navigator.of(context).pop();
                },
              ),
              Divider(
                height: 5.0,
              ),
              ListTile(
                title: Text("Close"),
                trailing: Icon(Icons.close),
                onTap: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ),
        body: PageView(
          children: _getMediaList(),
          pageSnapping: true,
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              _page = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _getNavBarItems(),
          onTap: _navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }

  List<Widget> _getMediaList() {

    return <Widget>[
      listPopularMediaWidget(),
      listUpComingMediaWidget(),
      listTopRateMediaWidget(),

    ];

  }

  Widget get _loadingView {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget listPopularMediaWidget() => ScopedModelDescendant<HomeScreenViewModel> (
    builder: (BuildContext context, Widget child, HomeScreenViewModel model) {
      if(mediaType == MediaType.movie) {
        if(model.isLoadingMoviePopular == (LoadingState.LOADING)) {
          return _loadingView;
        } else if( model.isLoadingMoviePopular == (LoadingState.ERROR)) {
          return Text('Sorry, there was an error loading the data!');
        } else {
          return ListView.builder(
              itemCount: model.moviePopularListStore.length,
              itemBuilder: (BuildContext context, int index) {
                if ( index > (model.moviePopularListStore.length * 0.7)) {
                  model.updateMoviePopular("popular");
                }
                return  MediaListItem(model.moviePopularListStore[index]);
              });
        }
      } else {
        if(model.isLoadingTvPopular == (LoadingState.LOADING)) {
          return _loadingView;
        } else if( model.isLoadingTvPopular == (LoadingState.ERROR)) {
          return Text('Sorry, there was an error loading the data!');
        } else {
          return ListView.builder(
              itemCount: model.tvPopularListStore.length,
              itemBuilder: (BuildContext context, int index) {
                if ( index > (model.tvPopularListStore.length * 0.7)) {
                  model.updateTVShowPopular("popular");
                }
                return  MediaListItem(model.tvPopularListStore[index]);
              });
        }
      }

    },
  );

  Widget listUpComingMediaWidget() => ScopedModelDescendant<HomeScreenViewModel> (
    builder: (BuildContext context, Widget child, HomeScreenViewModel model) {
      if(mediaType == MediaType.movie) {
        if(model.isLoadingMovieUpcoming == (LoadingState.LOADING)) {
          return _loadingView;
        } else if( model.isLoadingMovieUpcoming == (LoadingState.ERROR)) {
          return Text('Sorry, there was an error loading the data!');
        } else {
          return ListView.builder(
              itemCount: model.movieUpComingListStore.length,
              itemBuilder: (BuildContext context, int index) {
                if ( index > (model.movieUpComingListStore.length * 0.7)) {
                  model.updateMovieUpComing("upcoming");
                }
                return  MediaListItem(model.movieUpComingListStore[index]);
              });
        }
      } else {
        if(model.isLoadingTvOnTheAir == (LoadingState.LOADING)) {
          return _loadingView;
        } else if( model.isLoadingTvOnTheAir == (LoadingState.ERROR)) {
          return Text('Sorry, there was an error loading the data!');
        } else {
          return ListView.builder(
              itemCount: model.tvTVShowOnTheAirListStore.length,
              itemBuilder: (BuildContext context, int index) {
                if ( index > (model.tvTVShowOnTheAirListStore.length * 0.7)) {
                  model.updateTVShowOnTheAir("on_the_air");
                }
                return  MediaListItem(model.tvTVShowOnTheAirListStore[index]);
              });
        }
      }
    },
  );

  Widget listTopRateMediaWidget() => ScopedModelDescendant<HomeScreenViewModel> (
    builder: (BuildContext context, Widget child, HomeScreenViewModel model) {
      if(mediaType == MediaType.movie) {
        if(model.isLoadingMovieTopRated == (LoadingState.LOADING)) {
          return _loadingView;
        } else if( model.isLoadingMovieTopRated == (LoadingState.ERROR)) {
          return Text('Sorry, there was an error loading the data!');
        } else {
          return ListView.builder(
              itemCount: model.movieTopRateListStore.length,
              itemBuilder: (BuildContext context, int index) {
                if ( index > (model.movieTopRateListStore.length * 0.7)) {
                  model.updateMovieTopRate("top_rated");
                }
                return  MediaListItem(model.movieTopRateListStore[index]);
              });
        }
      } else {
        if(model.isLoadingTvTopRated == (LoadingState.LOADING)) {
          return _loadingView;
        } else if( model.isLoadingTvTopRated == (LoadingState.ERROR)) {
          return Text('Sorry, there was an error loading the data!');
        } else {
          return ListView.builder(
              itemCount: model.tvTopRateListStore.length,
              itemBuilder: (BuildContext context, int index) {
                if ( index > (model.tvTopRateListStore.length * 0.7)) {
                  model.updateTVShowTopRate("top_rated");
                }
                return  MediaListItem(model.tvTopRateListStore[index]);
              });
        }
      }
    },

  );

  void _changeMediaType(MediaType type) {
    if (mediaType != type) {
      setState(() {
        mediaType = type;
      });
    }
  }

  Widget loadingLocationWidget(bool isLoading) {
    return Container(
      width: 20,
      height: 20,
      margin: EdgeInsets.only(right: 16),
      child: isLoading
          ? CircularProgressIndicator(
        strokeWidth: 2,
      )
          : null,
    );
  }

  List<BottomNavigationBarItem> _getNavBarItems() {
    if (mediaType == MediaType.movie) {
      return [
        BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up), title: Text('Popular')),
        BottomNavigationBarItem(
            icon: Icon(Icons.update), title: Text('Upcoming')),
        BottomNavigationBarItem(
            icon: Icon(Icons.star), title: Text('Top Rated')),
      ];
    } else {
      return [
        BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up), title: Text('Popular')),
        BottomNavigationBarItem(
            icon: Icon(Icons.live_tv), title: Text('On The Air')),
        BottomNavigationBarItem(
            icon: Icon(Icons.star), title: Text('Top Rated')),
      ];
    }
  }

  void _navigationTapped(int page) {
    print("HomeScreenViewModel -> updateMedia() page " + page.toString());

    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  goToSearch(BuildContext context) {

  }

  goToFavorites(BuildContext context) {}


}


class MediaListItem extends StatelessWidget {
  MediaListItem(this.movie);

  final MediaItem movie;

  Widget _getTitleSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    movie.title,
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    getGenreString(movie.genreIds),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.body1,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 12.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Container(
                    width: 4.0,
                  ),
                  Icon(
                    Icons.star,
                    size: 16.0,
                  )
                ],
              ),
              Container(
                height: 4.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    movie.getReleaseYear().toString(),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Container(
                    width: 4.0,
                  ),
                  Icon(
                    Icons.date_range,
                    size: 16.0,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
//        onTap: () => goToMovieDetails(context, movie),
        child: Column(
          children: <Widget>[
            Hero(
              child: FadeInImage.assetNetwork(
                placeholder: "assets/placeholder.jpg",
                image: movie.getBackDropUrl(),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
                fadeInDuration: Duration(milliseconds: 50),
              ),
              tag: "Movie-Tag-${movie.id}",
            ),
            _getTitleSection(context),
          ],
        ),
      ),
    );
  }
}