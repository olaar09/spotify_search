import 'package:emoodie/src/core/components/library.dart';
import 'package:emoodie/src/core/components/photo_item.dart';
import 'package:emoodie/src/entities/album.dart';
import 'package:emoodie/src/core/utils/library.dart';
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                child: PhotoItem(photo: album.thumNail640!),
              ),
              const YSpaceBetween(),
              BoldText.smaller(album.albumName!, color: Colors.white),
              const YSpaceBetween(space: 4),
              Wrap(
                children: album.artists.map(
                  (artist) {
                    final isFirst = album.artists.indexOf(artist) == 0;
                    final isLast = album.artists.indexOf(artist) ==
                        album.artists.indexOf(album.artists.last);
                    return Padding(
                      padding: PagePadding.horizontalSymmetric(
                          value: isFirst ? 0 : 4),
                      child: BoldText.smaller(
                          "${artist.artistName} ${isLast ? "" : ","}"),
                    );
                  },
                ).toList(),
              ),
              const YSpaceBetween(space: 4),
              Row(
                children: [
                  BoldText.smaller(album.albumType?.capitalized() ?? ""),
                  BoldText.smaller(" . "),
                  BoldText.smaller(album.releaseDate ?? ""),
                ],
              ),
            ],
          );
        },
        childCount: albumsState.items?.length ?? 0,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.65,
      ),
    );
  }
}
