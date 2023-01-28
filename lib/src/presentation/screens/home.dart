import 'package:emoodie/src/entities/album.dart';
import 'package:emoodie/src/entities/artist.dart';
import 'package:emoodie/src/presentation/cubits/spotify_search_cubit.dart';
import 'package:emoodie/src/utils/constants.dart' as st;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final SpotifySearchCubit albumsCubit;
  late final SpotifySearchCubit artitsCubit;

  @override
  void initState() {
    albumsCubit = SpotifySearchCubit(
      itemsKey: st.ITEMS_KEY_ALBUMS,
      searchType: AlbumEntity(),
    );
    artitsCubit = SpotifySearchCubit(
      itemsKey: st.ITEMS_KEY_ARTISTS,
      searchType: ArtistEntity(),
    );
    super.initState();
  }

  int _counter = 0;

  void _incrementCounter() async {
    albumsCubit.executeSearch(q: "davido");
    artitsCubit.executeSearch(q: "sigala");
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    albumsCubit.close();
    artitsCubit.close();
  }
}
