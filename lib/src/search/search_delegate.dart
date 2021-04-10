import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_providers.dart';
import 'package:movies/src/utils/tools.dart';

class DataSearch extends SearchDelegate {
  final moviesProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: moviesProvider.searchCinemas(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;

          return ListView(
            children: movies.map((m) {
              return ListTile(
                leading: FadeInImage(
                    placeholder:
                        AssetImage(getAssetImageDefault(defaultgif: false)),
                    image: NetworkImage(m.getPoster()),
                    width: 50.0,
                    fit: BoxFit.contain),
                title: Text(m.title),
                subtitle: Text(m.originalTitle),
                onTap: () {
                  close(context, null);
                  m.uniqueId = '${m.id}-Swipper';
                  Navigator.pushNamed(context, 'detail', arguments: m);
                },
              );
            }).toList(),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
