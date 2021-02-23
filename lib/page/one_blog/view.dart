import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wood/data/article.dart';
import 'package:wood/page/one_blog/state.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_widget_from_html_core/apt/html_options.dart'
;import '../../core/config/design_config.dart';

class OneBlog extends StatefulWidget {

  final Article article;

  OneBlog({this.article});

  @override
  _OneBlogState createState() => _OneBlogState();
}

class _OneBlogState extends State<OneBlog> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  void initState() {
    final blogData = Provider.of<OneBlogController>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      blogData.getOneArticle(id: widget.article.id);
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
          elevation: 0),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: DefaultNetworkImage(
              url: widget.article.image,
              fit: BoxFit.cover,
              margin: EdgeInsets.zero,
              height: MediaQuery.of(context).size.height / 2.3,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(widget.article.name,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: DesignConfig.titleColor,
                    fontSize: DesignConfig.appBarTextFontSize,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: HtmlWidget(
                widget.article.description,
                textStyle: TextStyle(
                  fontSize: DesignConfig.textFontSize,
                  color: Colors.black,
                ),
                htmlOptions: HtmlOptions(
                  textAlign: TextAlign.justify,
                  textFontSize: DesignConfig.textFontSize,
                  textColor: Colors.black,
                  selectableText: true,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
