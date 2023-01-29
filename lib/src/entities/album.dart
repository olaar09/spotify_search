import 'package:emoodie/src/core/utils/iterable_entity_interface.dart';
import 'package:emoodie/src/entities/thumnail.dart';
import 'package:emoodie/src/core/utils/constants.dart' as st;

class AlbumEntity implements IterableEntity {
  AlbumEntity();

  @override
  List fromJsonArr(List list) {
    return List<AlbumEntityItem>.from(
        list.map((x) => AlbumEntityItem.fromJson(x)));
  }

  @override
  String toString() {
    return st.SEARCH_TYPE_ALBUM;
  }
}

class AlbumEntityItem {
  String? albumName;
  String? albumType;
  ThumbNailEntityItem? thumNail640;
  String? releaseDate;
  int? totalTracks;

  AlbumEntityItem.setData({
    required this.albumName,
    required this.albumType,
    this.thumNail640,
    required this.releaseDate,
    required this.totalTracks,
  });

  factory AlbumEntityItem.fromJson(Map<dynamic, dynamic> map) {
    List? images = map['images'];
    return AlbumEntityItem.setData(
      albumName: map['name'],
      albumType: map['album_type'],
      thumNail640: images == null || images.isEmpty
          ? null
          : ThumbNailEntityItem.fromJson(images.first),
      releaseDate: map['release_date'],
      totalTracks: map['total_tracks'],
    );
  }

  @override
  String toString() {
    return "$albumName $albumType $thumNail640 $releaseDate $totalTracks";
  }
}
