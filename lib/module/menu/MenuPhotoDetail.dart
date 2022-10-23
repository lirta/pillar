import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:photo_view/photo_view.dart';

class MenuPhotoDetail extends StatefulWidget {
  final List images;
  const MenuPhotoDetail({Key key, this.images}) : super(key: key);

  @override
  State<MenuPhotoDetail> createState() => _MenuPhotoDetailState();
}

class _MenuPhotoDetailState extends State<MenuPhotoDetail> {
  @override
  Widget build(BuildContext context) {
    bool isFailed = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: widget.images != null
          ? displaySwipePic(context, widget.images)
          : isFailed
              ? displayPhotoDetailNotFound()
              : Container(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 100.0),
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
    );
  }

  Widget displayPhotoDetailNotFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 30),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/no_image_available.jpg")),
      ],
    );
  }

  Widget displaySwipePic(BuildContext context, List<String> images) {
    return new Swiper(
        itemBuilder: (BuildContext context, int index) {
          print("link image " + images[index].toString());
          return Column(
            children: <Widget>[
              Expanded(
                child: PhotoView(
                  imageProvider: NetworkImage(images[index].toString()),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: 4.0,
                ),
              ),
            ],
          );
        },
        autoplay: false,
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        pagination: new SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
                activeColor: Colors.red, color: Colors.red[100])),
        physics: images.length <= 1 ? NeverScrollableScrollPhysics() : null,
        control: images.length > 1 ? SwiperControl() : null);
  }
}
