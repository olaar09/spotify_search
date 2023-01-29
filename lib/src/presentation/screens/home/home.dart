import 'package:easy_debounce/easy_debounce.dart';
import 'package:emoodie/src/core/components/library.dart';
import 'package:emoodie/src/entities/album.dart';
import 'package:emoodie/src/entities/artist.dart';
import 'package:emoodie/src/presentation/cubits/spotify_search_cubit.dart';

import 'package:emoodie/src/core/utils/library.dart';
import 'package:emoodie/src/core/utils/constants.dart' as st;
import 'package:emoodie/src/presentation/screens/home/components/library.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ViewTypes { albums, artists }

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _inputDebounceId = 'input-debounce';
  String? _albumsViewCurrentSearch = null;
  String? _artistsViewCurrentSearch = null;

  late final SpotifySearchCubit albumsCubit;
  late final SpotifySearchCubit artitsCubit;
  ViewTypes? _selectedView = ViewTypes.albums;
  String? userSearch;
  bool albumsLoaded = false;
  bool artistsLoaded = false;

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

  void _setArtistsLoaded(bool isLoaded) {
    setState(() {
      artistsLoaded = isLoaded;
    });
  }

  void _setAlbumsLoaded(bool isLoaded) {
    setState(() {
      albumsLoaded = isLoaded;
    });
  }

  void _onInputUpdated(String? input) {
    setState(() => userSearch = input);

    if (input == null || input.isEmpty) {
      setState(() => _selectedView == null);
    } else {
      // wait 500 seconds for user to finish typing before triggering search to prevent uneccary api calls
      EasyDebounce.debounce(_inputDebounceId, const Duration(milliseconds: 500),
          () {
        _selectedView == ViewTypes.albums
            ? albumsCubit.executeSearch(q: userSearch!)
            : artitsCubit.executeSearch(q: userSearch!);
      });
    }

    if (_selectedView == ViewTypes.albums) {
      setState(() => _albumsViewCurrentSearch = input);
    } else if (_selectedView == ViewTypes.artists) {
      setState(() => _artistsViewCurrentSearch = input);
    }
  }

  void _onViewSelected(ViewTypes view) async {
    setState(() {
      _selectedView = view;
    });

    if (userSearch != null) {
      // If view type is equals and user input has changed between view switches.
      // If user input has not changed between view type switch, no need to trigger search again
      if (_albumsViewCurrentSearch != userSearch && view == ViewTypes.albums) {
        _albumsViewCurrentSearch = userSearch;
        albumsCubit.executeSearch(q: userSearch!);
      } else if (_artistsViewCurrentSearch != userSearch &&
          view == ViewTypes.artists) {
        _artistsViewCurrentSearch = userSearch;
        artitsCubit.executeSearch(q: userSearch!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUserhasInput = (userSearch != null && userSearch!.isNotEmpty);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const PagePadding.horizontalSymmetric(value: 10),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: YSpaceBetween(space: 30)),
              const SliverToBoxAdapter(
                child: BoldText(
                    text: "Search",
                    color: Colors.white,
                    size: 28,
                    fontWeight: FontWeight.w700),
              ),
              const SliverToBoxAdapter(child: YSpaceBetween(space: 15)),
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    TextInput(
                      hintText: "Artists, albums...",
                      bgColor: Colors.white,
                      hintColor: Colors.grey.shade800,
                      textColor: Colors.grey.shade800,
                      fontSize: 13,
                      textBoxPadding: 40,
                      onChanged: _onInputUpdated,
                    ),
                    Positioned(
                      top: 15,
                      left: 6,
                      child: Icon(
                        Icons.search_outlined,
                        color: Colors.grey.shade800,
                        size: 24,
                      ),
                    )
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: YSpaceBetween(space: 25)),
              if (isUserhasInput || (albumsLoaded || artistsLoaded))
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      SelectorChip(
                        isActive: _selectedView == ViewTypes.albums,
                        text: ViewTypes.albums.name.capitalized(),
                        onSelect: () => _onViewSelected(ViewTypes.albums),
                      ),
                      const XSpaceBetween(space: 17),
                      SelectorChip(
                        isActive: _selectedView == ViewTypes.artists,
                        text: ViewTypes.artists.name.capitalized(),
                        onSelect: () => _onViewSelected(ViewTypes.artists),
                      ),
                    ],
                  ),
                ),
              const SliverToBoxAdapter(child: YSpaceBetween(space: 25)),
              if (_selectedView == ViewTypes.albums)
                BlocConsumer<SpotifySearchCubit, SpotifySearchState>(
                  bloc: albumsCubit,
                  listener: (context, state) {
                    _setAlbumsLoaded(state.items != null);
                  },
                  builder: (context, state) {
                    return AlbumsViewComponent(albumsState: state);
                  },
                ),
              if (_selectedView == ViewTypes.artists)
                BlocConsumer<SpotifySearchCubit, SpotifySearchState>(
                  bloc: artitsCubit,
                  listener: (context, state) {
                    _setArtistsLoaded(state.items != null);
                  },
                  builder: (context, state) {
                    return ArtistsViewComponent(artistsState: state);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    albumsCubit.close();
    artitsCubit.close();
    EasyDebounce.cancel(_inputDebounceId);
  }
}
