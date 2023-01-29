import 'package:emoodie/src/core/components/spaces.dart';
import 'package:emoodie/src/entities/artist.dart';
import 'package:emoodie/src/presentation/cubits/spotify_search_cubit.dart';
import 'package:flutter/material.dart';

class ArtistsViewComponent extends StatelessWidget {
  const ArtistsViewComponent({
    Key? key,
    required this.artistsState,
  }) : super(key: key);

  final SpotifySearchState artistsState;

  @override
  Widget build(BuildContext context) {
    if (artistsState.loading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(
            value: 15,
            color: Colors.white,
          ),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          ArtistEntityItem artist = artistsState.items![index];
          return Column(
            children: [
              YSpaceBetween(space: 6),
              Container(
                alignment: Alignment.center,
                color: Colors.teal,
                child: Text(artist.artistName!),
              ),
              YSpaceBetween(space: 6),
            ],
          );
        },
        childCount: artistsState.items?.length ?? 0,
      ),
    );
  }
}
