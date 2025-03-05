
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class cacheImageWidget extends StatelessWidget {
  const cacheImageWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          image,
      placeholder: (context, url) =>
          Container(
        width: 30,
        height: 30,
        child: const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child:
                CircularProgressIndicator(
              strokeWidth:
                  2, // Personaliza el ancho del indicador como desees
              valueColor:
                  AlwaysStoppedAnimation<
                          Color>(
                      Color.fromARGB(110,
                          253, 176, 42)),
            ),
          ),
        ),
      ),
      errorWidget:
          (context, url, error) =>
              Image.asset(
        'assets/images/image-trip-default.png',
        cacheWidth: 30,
        cacheHeight: 30,
        fit: BoxFit.cover,
      ),
      fit: BoxFit.cover,
      width: 50,
      height: 50,
    );
  }
}
