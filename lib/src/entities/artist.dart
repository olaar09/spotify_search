import 'package:emoodie/src/core/utils/iterable_entity_interface.dart';
import 'package:emoodie/src/entities/thumnail.dart';
import 'package:emoodie/src/core/utils/constants.dart' as st;

class ArtistEntity implements IterableEntity {
  ArtistEntity();

  @override
  List fromJsonArr(List list) {
    return List<ArtistEntityItem>.from(
        list.map((x) => ArtistEntityItem.fromJson(x)));
  }

  @override
  String toString() {
    return st.searchTypeArtist;
  }
}

class ArtistEntityItem {
  final String? artistName;
  final ThumbNailEntityItem? thumNail640;

  ArtistEntityItem.setData({
    required this.artistName,
    this.thumNail640,
  });

  factory ArtistEntityItem.fromJson(Map<dynamic, dynamic> map) {
    List? images = map['images'];
    return ArtistEntityItem.setData(
      artistName: map['name'],
      thumNail640: images == null || images.isEmpty
          ? null
          : ThumbNailEntityItem.fromJson(images.first),
    );
  }

  @override
  String toString() {
    return "$artistName $thumNail640";
  }
}
