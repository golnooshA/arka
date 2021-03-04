import 'package:wood/core/config/design_config.dart';
import 'package:wood/core/config/http_config.dart';
import 'package:wood/widget/carousel_indicator.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PostSlider extends StatelessWidget {

  final CarouselIndicatorController carouselIndicatorController = CarouselIndicatorController();
  final List<String> imageUrls;
  final double width;
  final double height;

  PostSlider({
    this.width,
    this.height,
    this.imageUrls
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
            options: CarouselOptions(
                initialPage: 0,
                //height: MediaQuery.of(context).size.width / 1.6,
                viewportFraction: 1,
                aspectRatio: width/height,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                onPageChanged: (index, _) {
                  carouselIndicatorController.setIndex(index);
                }),
            items: imageUrls.map((imagePath) => DefaultNetworkImage(
              // margin: EdgeInsets.only(top: 20),
              url: HttpConfig.url(imagePath, isApi: false),
              fit: BoxFit.cover,
            )).toList()
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 14,
          child: Container(
            width: width,
            alignment: Alignment.center,
            child: CarouselIndicator(
              controller: carouselIndicatorController,
              count: imageUrls.length,
              initialIndex: 0,
              child: Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                    border: Border.all(color: DesignConfig.errorColor)),
              ),
              selectedChild: Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(color: DesignConfig.errorColor),
              ),
            ),
          ),
        )
      ],
    );
  }
}