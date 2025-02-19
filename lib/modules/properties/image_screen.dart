import 'package:flutter/material.dart';
import 'package:newavenue/shared/router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../main.dart';

// ignore: must_be_immutable
class ImageScreen extends StatelessWidget {
   List<String>images;
   ImageScreen({Key? key , required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(

        leading:IconButton(onPressed: (){
          CustomRouter.pop();
        }, icon:const  Icon(Icons.arrow_back_ios,color: Colors.white),)
        
        ,elevation: 0.0,
        backgroundColor: Colors.transparent,
        
      ),
      body: PhotoViewGallery.builder(

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
    );}
  }
