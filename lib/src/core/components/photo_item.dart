import 'package:emoodie/src/entities/thumnail.dart';
import 'package:flutter/material.dart';

import 'library.dart';

class PhotoItem extends StatelessWidget {
  final ThumbNailEntityItem photo;

  const PhotoItem({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(photo.url!),
        ),
      ),
    );
  }
}
