import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/utils/tools.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return _newCard(context, movies[index]);
        },
        pageSnapping: false,
        controller: _pageController,
      ),
    );
  }

  Widget _newCard(BuildContext context, Movie movie) {
    movie.uniqueId = '${movie.id}-Detail';

    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder:
                    AssetImage(getAssetImageDefault(defaultgif: false)),
                image: NetworkImage(movie.getPoster()),
                fit: BoxFit.cover,
                height: 120.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption),
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }
}
