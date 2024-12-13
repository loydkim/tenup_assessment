import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tenup_project/app_routes.dart';
import 'package:tenup_project/favorites/view_model/favorite_model.dart';
import 'package:tenup_project/restaurant/view/restaurant_page.dart';
import 'package:tenup_project/theme/app_color.dart';
import 'package:yelp_api/yelp_api.dart';

class FeatureList extends StatefulWidget {
  const FeatureList({super.key, required this.restaurants, this.favoriteModel});

  final FavoriteModel? favoriteModel;
  final List<Restaurant> restaurants;

  @override
  State<FeatureList> createState() => _FeatureListState();
}

class _FeatureListState extends State<FeatureList> {
  final PageController _pageController = PageController();

  late Timer _timer;
  int _start = 4;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _startTimer();
    }
    _pageController.addListener(() {
      _timer.cancel();
      _startTimer();
    });
  }

  void _startTimer() {
    _start = 4;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        setState(() {
          if (_start < 1) {
            timer.cancel();
            _pageController.animateToPage(
                _pageController.page == 2.0
                    ? 0
                    : _pageController.page!.toInt() + 1,
                duration: const Duration(seconds: 1),
                curve: Curves.ease);
            _startTimer();
          } else {
            _start = _start - 1;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            width: size.width,
            height: size.width * 0.48,
            child: PageView(
              controller: _pageController,
              children: widget.restaurants
                  .map((data) => _featureItem(data, size))
                  .toList(),
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: widget.restaurants.length,
            effect: const ExpandingDotsEffect(
                dotHeight: 10, dotWidth: 12, activeDotColor: Colors.pink),
            // type: WormType.thinUnderground,
          ),
        ],
      ),
    );
  }

  Widget _featureItem(Restaurant restaurant, Size size) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.detailView,
              arguments: DetailViewArgument(
                  widget.favoriteModel!, restaurant, restaurant.id!));
        },
        child: restaurantThumbnail(restaurant, restaurant.id!, size));
  }

  restaurantThumbnail(Restaurant restaurant, String heroTag, Size size) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: size.width,
            height: size.width * 0.48,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: Hero(
                tag: heroTag,
                child: restaurant.photos?.first != null
                    ? CachedNetworkImage(
                        imageUrl: restaurant.photos!.first,
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Positioned.fill(
            left: 26,
            top: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.white, fontSize: 22),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  restaurant.location?.formattedAddress ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white, fontSize: 20),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                          child: Row(
                            children: [
                              Icon(Icons.restaurant,
                                  color: Colors.white, size: 18.0),
                              SizedBox(width: 8),
                              Text(
                                restaurant.categories?.first.title ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 26.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColor.star,
                              size: 22.0,
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
