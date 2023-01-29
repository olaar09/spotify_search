import 'package:emoodie/src/entities/album.dart';
import 'package:emoodie/src/presentation/cubits/spotify_search_cubit.dart';
import 'package:flutter/material.dart';

class AlbumsViewComponent extends StatelessWidget {
  const AlbumsViewComponent({
    Key? key,
    required this.albumsState,
  }) : super(key: key);

  final SpotifySearchState albumsState;

  @override
  Widget build(BuildContext context) {
    if (albumsState.loading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(
            value: 15,
            color: Colors.white,
          ),
        ),
      );
    }
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          AlbumEntityItem album = albumsState.items![index];
          return Container(
            alignment: Alignment.center,
            color: Colors.teal,
            child: Text(album.albumName!),
          );
        },
        childCount: albumsState.items?.length ?? 0,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1.0,
      ),
    );
  }
}
