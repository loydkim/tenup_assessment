import 'package:flutter/material.dart';
import 'package:tenup_project/common/widgets/app_place_holder.dart';
import 'package:tenup_project/common/widgets/is_open.dart';
import 'package:tenup_project/restaurant/widgets/detail_view_app_bar.dart';
import 'package:tenup_project/restaurant/widgets/review_row_item.dart';
import 'package:tenup_project/common/consts/shared_const.dart';
import 'package:tenup_project/theme/app_color.dart';
import 'package:tenup_project/favorites/view_model/favorite_model.dart';
import 'package:yelp_api/yelp_api.dart';

class DetailViewArgument {
  final FavoriteModel favoriteModel;
  final Restaurant restaurant;
  final String heroTag;

  DetailViewArgument(this.favoriteModel, this.restaurant, this.heroTag);
}

class RestaurantPage extends StatefulWidget {
  final FavoriteModel favoriteModel;
  final Restaurant restaurant;
  final String heroTag;

  const RestaurantPage(this.favoriteModel, this.restaurant, this.heroTag,
      {super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  late ScrollController _scrollController;
  bool isShrink = false;

  _scrollListener() {
    setState(() {
      if (_scrollController.hasClients &&
          _scrollController.offset > (kNavigationBarHeight - kToolbarHeight)) {
        isShrink = true;
      } else {
        isShrink = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          DetailViewAppBar(widget.favoriteModel, widget.restaurant, isShrink,
              widget.heroTag),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      priceAndIsOpen(),
                      address(true),
                      overallRating(),
                      reviews(true)
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget reviews(bool hasData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.restaurant.reviews?.length ?? 0} Reviews",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        hasData
            ? Column(
                children:
                    widget.restaurant.reviews!.asMap().entries.map((entry) {
                return ReviewRowItem(
                    isLoading: false,
                    isLastComment:
                        entry.key == widget.restaurant.reviews!.length - 1,
                    theme: Theme.of(context),
                    review: entry.value,
                    index: entry.key);
              }).toList())
            : Column(// Review Place Holder
                children: const [
                ReviewRowItem(isLoading: true),
                ReviewRowItem(isLoading: true),
                ReviewRowItem(isLoading: true, isLastComment: true)
              ])
      ],
    );
  }

  Widget overallRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overall Rating",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${widget.restaurant.rating ?? 5}",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 0, 2),
                child: Icon(
                  Icons.star,
                  color: AppColor.star,
                  size: 16,
                ),
              )
            ],
          ),
        ),
        divider(),
      ],
    );
  }

  Widget priceAndIsOpen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "${widget.restaurant.price ?? ""}, ",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  widget.restaurant.categories?.first.title ?? "",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            IsOpen(widget.restaurant.hours!.first.isOpenNow ?? false)
          ],
        ),
        divider(),
      ],
    );
  }

  Widget address(bool hasData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: hasData
              ? Text(
                  widget.restaurant.location!.formattedAddress != null
                      ? widget.restaurant.location!.formattedAddress!
                      : "102 Lakeside Ave\nSeattle, WA 98122",
                )
              : Column(
                  children: const [
                    AppPlaceHolder(
                      height: 22,
                      width: 163,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: AppPlaceHolder(
                        height: 22,
                        width: 163,
                      ),
                    ),
                  ],
                ),
        ),
        divider(),
      ],
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Divider(color: AppColor.dividerLine, thickness: 1),
    );
  }
}
