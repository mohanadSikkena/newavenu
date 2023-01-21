import 'package:flutter/material.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PropertiesCubit cubit=PropertiesCubit.get(context);
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(cubit.currentProperty.images[index]),
          initialScale: PhotoViewComputedScale.contained * 1,
        );
      },
      itemCount: cubit.currentProperty.images.length,
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
      
    );
}
  }
