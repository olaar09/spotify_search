class ThumbNailEntityItem {
  double? height;
  String? url;
  double? width;

  ThumbNailEntityItem.setData({
    required this.height,
    required this.url,
    required this.width,
  });

  factory ThumbNailEntityItem.fromJson(Map<dynamic, dynamic> map) {
    return ThumbNailEntityItem.setData(
      width: double.tryParse("${map['width']}") ?? 0,
      url: map['url'],
      height: double.tryParse("${map['height']}") ?? 0,
    );
  }

  @override
  String toString() {
    return "$url";
  }
}
