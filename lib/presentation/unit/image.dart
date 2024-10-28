import 'dart:convert';
import 'dart:typed_data'; // إضافة هذا للاستيراد

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    required this.height,
    required this.width,
    required this.image,
    required this.sql,
  });

  final double height;
  final double width;
  final String image;
  final int sql;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: sql == 1
            ? FutureBuilder<Uint8List>(
          future: decodeImage(image),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: width,
                height: height,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Container(
                width: width,
                height: height,
                color: Colors.grey[200],
                child: Center(child: Text("!!"))
              );
            } else if (snapshot.hasData) {
              return Image.memory(
                snapshot.data!,
                width: width,
                height: height,
                fit: BoxFit.cover,
              );
            } else {
              return Container(); // حالة افتراضية
            }
          },
        )
            : CachedNetworkImage(
          width: width,
          height: height,
          imageUrl: image,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Center(child: Text("!!!")),
        ),
      ),
    );
  }
  Future<Uint8List> decodeImage(String base64String) async {
    try {
      return base64Decode(base64String);
    } catch (e) {
      throw Exception('Failed to decode image: $e');
    }
  }
}
