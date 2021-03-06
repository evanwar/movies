import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/utils/tools.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: new Swiper(
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context, int index) {
            movies[index].uniqueId = '${movies[index].id}-Swipper';

            return GestureDetector(
              child: Hero(
                tag: movies[index].uniqueId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    image: NetworkImage(movies[index].getPoster()),
                    placeholder: AssetImage(getAssetImageDefault()),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'detail',
                    arguments: movies[index]);
              },
            );
          },
          itemCount: movies.length),
    );
  }
}
