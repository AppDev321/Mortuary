import 'package:flutter/material.dart';

class NetworkImageLoader extends StatelessWidget {
  const NetworkImageLoader(
      {Key? key,
        this.progressType = ImageProgressType.circular,
        required this.imageUrl,
        this.width,
        this.headers,
        this.height})
      : super(key: key);

  final String imageUrl;
  final double? height;
  final double? width;
  final Map<String, String>? headers;
  final ImageProgressType progressType;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      headers: headers,
      fit: BoxFit.cover,
      height: height,
      width: width,
    //  errorBuilder: (context, error, stackTrace) => const AppBarLogo(),
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        final value = loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
            loadingProgress.expectedTotalBytes!
            : 0.0;
        return SizedBox(
            height: height,
            width: width,
            // child:
            // progressType == ImageProgressType.translucentLogo
            //     ?
            // Opacity(
            //   opacity: value,
            //   child: const AppBarLogo(),
            // )
          // :
          // CircularProgressIndicator(
          //         color: Colors.white,
          //         value: loadingProgress.expectedTotalBytes != null
          //             ? loadingProgress.cumulativeBytesLoaded /
          //                 loadingProgress.expectedTotalBytes!
          //             : 0.0,
          //       ),
        );
      },
    );
  }
}

enum ImageProgressType { circular, translucentLogo }
