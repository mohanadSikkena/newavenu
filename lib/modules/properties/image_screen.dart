import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class ImageScreen extends StatelessWidget {
   List<String>images;
   ImageScreen({Key? key , required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PhotoViewGallery.builder( 

          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {

            return PhotoViewGalleryPageOptions(  
              
              imageProvider:
               NetworkImage(images[index]),
              initialScale: PhotoViewComputedScale.contained * 1,
            );
          },
          itemCount: images.length,
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!.toInt(),
              ),
            ),
          ),
          
        ),
        const IgnorePointer(
          child: Image(image: AssetImage('images/black_logo.png', ), height: 200,))
      ],
    );
}
  }
