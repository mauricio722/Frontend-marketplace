

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatefulWidget {

  final List images;

  PhotoViewPage({this.images});

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState(images: this.images);
}

class _PhotoViewPageState extends State<PhotoViewPage> {

  List images;

  _PhotoViewPageState({this.images});
  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      itemCount: images.length, 
      builder: (context, index){
        return PhotoViewGalleryPageOptions(
        imageProvider: NetworkImage(
          images[index],
        ),
        minScale: PhotoViewComputedScale.contained *0.8,
        maxScale: PhotoViewComputedScale.covered  *2,
        );
      },
      scrollPhysics: BouncingScrollPhysics(),
      // backgroundDecoration: BoxDecoration(
      //   color: Theme.of(context).canvasColor,
      // ),
      loadFailedChild: Center(
        child: CircularProgressIndicator(),
      )
      
    ); 
  }
}