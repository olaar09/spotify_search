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

class SpotifyEmoodieHome extends StatefulWidget {
  const SpotifyEmoodieHome({
    Key? key,
  }) : super(key: key);

  @override
  State<SpotifyEmoodieHome> createState() => _SpotifyEmoodieHomeState();
}

class _SpotifyEmoodieHomeState extends State<SpotifyEmoodieHome> {
  final _inputDebounceId = 'input-debounce';
  String? _albumsViewCurrentSearch;
  String? _artistsViewCurrentSearch;

  late final SpotifySearchCubit albumsCubit;
  late final SpotifySearchCubit artitsCubit;
  ViewTypes? _selectedView = ViewTypes.albums;
  String? userSearch;

  @override
  void initState() {
    albumsCubit = SpotifySearchCubit(
      itemsKey: st.itemsKeyAlbums,
      searchType: AlbumEntity(),
    );
    artitsCubit = SpotifySearchCubit(
      itemsKey: st.itemsKeyArtists,
      searchType: ArtistEntity(),
    );
    super.initState();
  }

  void _onInputUpdated(String? input) {
    setState(() => userSearch = input);

    if (_selectedView == ViewTypes.albums) {
      setState(() => _albumsViewCurrentSearch = input);
    } else if (_selectedView == ViewTypes.artists) {
      setState(() => _artistsViewCurrentSearch = input);
    }

    // wait 500 seconds for user to finish typing before triggering search to prevent unnecessary api calls
    EasyDebounce.debounce(_inputDebounceId, const Duration(milliseconds: 500),
        () {
      _selectedView == ViewTypes.albums
          ? albumsCubit.executeSearch(q: userSearch!)
          : artitsCubit.executeSearch(q: userSearch!);
    });
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
              const SliverToBoxAdapter(child: YSpaceBetween(space: 10)),
              const SliverToBoxAdapter(
                child: BoldText(
                  text: stringSearch,
                  color: Colors.white,
                  size: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
              ),
              const SliverToBoxAdapter(child: YSpaceBetween(space: 15)),
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    TextInput(
                      hintText: stringSearchInputHint,
                      bgColor: Colors.white,
                      hintColor: Colors.grey.shade800,
                      textColor: Colors.grey.shade800,
                      fontSize: 13,
                      textBoxPadding: 35,
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
              if (isUserhasInput)
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
              if (isUserhasInput && _selectedView == ViewTypes.albums)
                AlbumsViewComponent(bloc: albumsCubit),
              if (isUserhasInput && _selectedView == ViewTypes.artists)
                ArtistsViewComponent(bloc: artitsCubit),
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
