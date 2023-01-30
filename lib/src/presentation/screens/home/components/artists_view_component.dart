import 'package:emoodie/src/core/components/library.dart';
import 'package:emoodie/src/entities/artist.dart';
import 'package:emoodie/src/presentation/cubits/spotify_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistsViewComponent extends StatelessWidget {
  const ArtistsViewComponent({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final SpotifySearchCubit bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotifySearchCubit, SpotifySearchState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.loading) {
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
              ArtistEntityItem artist = state.items![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YSpaceBetween(),
                  Row(children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          NetworkImage(artist.thumNail640?.url ?? ""),
                    ),
                    const XSpaceBetween(space: 12),
                    BoldText.medium(artist.artistName!, color: Colors.white),
                  ]),
                  const YSpaceBetween(),
                ],
              );
            },
            childCount: state.items?.length ?? 0,
          ),
        );
      },
    );
  }
}
