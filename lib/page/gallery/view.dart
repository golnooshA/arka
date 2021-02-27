import 'package:provider/provider.dart';
import 'package:wood/component/gallery_view/gallery_view.dart';
import 'package:wood/core/config/http_config.dart';
import 'package:wood/data/status.dart';
import 'package:wood/page/gallery/state.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/error.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wood/widget/loading.dart';
import '../../core/config/design_config.dart';

class Gallery extends StatefulWidget {

  final int id;

  const Gallery({this.id});

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final TextEditingController searchController = TextEditingController();

  final FocusNode searchFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<GalleryView> galleryView;
  ScrollController scrollController;

  void initState() {
    scrollController = ScrollController();
    final galleryData = Provider.of<GalleryController>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      galleryData.getImages(id: widget.id);
    }).then((value) {
      galleryView = makeGalleryViews(galleryData.images, galleryData);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: DesignConfig.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: DesignConfig.appBarOptionsColor),
        elevation: 0,
        centerTitle: true,
        title: Text('Gallery',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: DesignConfig.appBarOptionsColor,
                fontSize: DesignConfig.appBarTextFontSize,
                fontWeight: FontWeight.w400)),
      ),
      body: Consumer<GalleryController>(
        builder: (_, galleryData, child) {
          switch (galleryData.status) {
            case Status.ready:
              return CustomScrollView(
                slivers: [
                  SliverPadding(padding: EdgeInsets.only(
                      left: 20, right: 20, top: 40),
                    sliver: SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 2,
                      itemCount: galleryData.images.length,
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 9,
                      staggeredTileBuilder: (int index) {
                        return new StaggeredTile.count(1, 1);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final item = galleryData.images[index];
                        return InkWrapper(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (_) => galleryView[index]
                            ));
                          },
                          highlightColor: DesignConfig.highlightColor,
                          splashColor: DesignConfig.splashColor,
                          child: DefaultNetworkImage(
                            url:HttpConfig.url(item, isApi: false),
                            fit: BoxFit.cover,
                            margin: EdgeInsets.zero,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                          ),
                        );
                      },
                    ),)
                ],
              );
              break;
            case Status.loading:
              return Loading();
              break;

            default:
              return Error(   message: galleryData.errorMessage,
                  buttonText: "try again",
                  onButtonTap: () {
                    galleryData.getImages(id: widget.id);
                  });
          }
        },
      ),
    );
  }

  List<GalleryView> makeGalleryViews(List<String> images, GalleryController galleryData){
    final List<GalleryView> list = [];
    for(int i=0, len=images.length; i<len; i++){
      list.add(GalleryView(
        photos: galleryData.images.map((e) => HttpConfig.url(e, isApi: false)).toList(),
        initialIndex: i,
      ));
    }
    return list;
  }

}