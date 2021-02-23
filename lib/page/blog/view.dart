import 'package:provider/provider.dart';
import 'package:wood/core/router/routes.dart';
import 'package:wood/data/status.dart';
import 'package:wood/page/blog/state.dart';
import 'package:wood/page/main/scroll_state.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/error.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:wood/widget/loading.dart';
import '../../core/config/design_config.dart';

class Blog extends StatefulWidget {


  final ScrollPageState scrollState;
  final int id;

  const Blog({this.id, this.scrollState});


  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController;
  int page = 1;


  scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      final blogData = Provider.of<BlogController>(context, listen: false);
      if (blogData.status == Status.ready) {
        page++;
        await blogData.getArticle(id: widget.id);
      }
    }
    widget.scrollState.setScroll(scrollController.position.pixels);
  }

  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    final blogData = Provider.of<BlogController>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      blogData.getArticle(id: widget.id);
    });
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    if (scrollController.hasClients) {
      if (scrollController.position.pixels != widget.scrollState.getScroll()) {
        scrollController.jumpTo(widget.scrollState.getScroll());
      }
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: DesignConfig.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: DesignConfig.appBarOptionsColor),
        elevation: 0,
        centerTitle: true,
        title: Text('Blog',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: DesignConfig.appBarOptionsColor,
                fontSize: DesignConfig.appBarTextFontSize,
                fontWeight: FontWeight.w400)),
      ),
      body: Consumer<BlogController>(

        builder: (_, blogData, child) {

          switch (blogData.status) {
            case Status.ready:

              return RefreshIndicator(
                onRefresh: () async {
                  await blogData.getArticle(id: widget.id ,refresh: true);
                },
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    if (blogData.articles.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 12),
                          child: Text(
                            'Showing ${blogData.articles.length.toString()} blogs',
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: DesignConfig.textColor,
                              fontSize: DesignConfig.mediumFontSize,
                            ),
                          ),
                        ),
                      ),

                    if (blogData.articles.isNotEmpty)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                                (context, index){
                              final item = blogData.articles[index];


                              return InkWrapper(
                                onTap: (){
                                  Navigator.pushNamed(
                                      context, Routes.oneBlog, arguments: item);
                                },
                                highlightColor: DesignConfig.highlightColor,
                                splashColor: DesignConfig.splashColor,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width / 1.2,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex:5,
                                        child: DefaultNetworkImage(
                                          url: item.image,
                                          fit: BoxFit.cover,
                                          margin: EdgeInsets.zero,
                                          height: double.infinity,
                                          width: double.infinity,

                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 12),
                                        child: Text(
                                          item.name,
                                          textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: DesignConfig.titleColor,
                                              fontSize: DesignConfig.textFontSize,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),

                                      Container(
                                        child: Text(
                                         item.stripDesc,
                                          textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: DesignConfig.textColor,
                                              fontSize: DesignConfig.mediumFontSize,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: 5
                        ),
                      ),

                  ],
                ),
              );

            case Status.loading:
              return Loading();
              break;

            case Status.empty:
              return Loading();
              break;

            default:
              return ListView(
                shrinkWrap: true,
                children: [
                  child,
                 Error(
                     message: blogData.errorMessage,
                     buttonText: "try again",
                     onButtonTap: () {
                       blogData.getArticle(id:widget.id);
                     })
                ],
              );
          }
        },
      )
    );
  }
}
