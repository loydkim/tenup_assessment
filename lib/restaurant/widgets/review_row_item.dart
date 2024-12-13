import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tenup_project/common/widgets/app_place_holder.dart';
import 'package:tenup_project/common/widgets/rating.dart';
import 'package:tenup_project/common/consts/place_holder_value.dart';
import 'package:tenup_project/theme/app_color.dart';
import 'package:yelp_api/yelp_api.dart';

class ReviewRowItem extends StatelessWidget {
  final bool isLoading;
  final bool isLastComment;
  final ThemeData? theme;
  final Review? review;
  final int? index;

  const ReviewRowItem(
      {this.isLoading = false,
      this.isLastComment = false,
      this.theme,
      this.review,
      this.index,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: isLoading
                ? const EdgeInsets.only(top: 8.0)
                : const EdgeInsets.all(0),
            child: Row(
              children: [
                isLoading
                    ? ClipOval(
                        child: Container(
                        width: 40,
                        height: 40,
                        color: AppColor.placeHolder,
                      ))
                    : review!.user!.imageUrl != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                            imageUrl: review!.user!.imageUrl!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ))
                        : const Icon(Icons.account_circle,
                            color: Colors.grey, size: 46),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: isLoading
                      ? const AppPlaceHolder(
                          height: PlaceHolderValue.rateHeight,
                          width: PlaceHolderValue.rateWidth,
                        )
                      : Text(
                          review!.user?.name ?? "No Name",
                        ),
                ),
                Spacer(),
                isLoading
                    ? const AppPlaceHolder(
                        height: PlaceHolderValue.rateHeight,
                        width: PlaceHolderValue.rateWidth,
                      )
                    : Rating(review!.rating?.toDouble() ?? 0),
              ],
            ),
          ),
          Padding(
            padding: isLoading
                ? const EdgeInsets.only(top: 8.0)
                : const EdgeInsets.symmetric(vertical: 8.0),
            child: isLoading
                ? const AppPlaceHolder(height: PlaceHolderValue.normalHeight)
                : Text(
                    dummyReview(index!),
                  ),
          ),
          isLoading
              ? const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: AppPlaceHolder(height: PlaceHolderValue.normalHeight),
                )
              : Container(),
          if (!isLastComment) divider()
        ],
      ),
    );
  }

  divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Divider(color: AppColor.dividerLine, thickness: 1),
    );
  }

  String dummyReview(int index) {
    switch (index) {
      case 0:
        return "The food was absolutely fantastic! Every dish was bursting with flavor, and the presentation was stunning. The staff was attentive and made the entire experience delightful. Highly recommend the burger!";
      case 1:
        return "Loved the cozy atmosphere and tasteful decor. It’s a perfect place for a relaxing evening out. The service was impeccable, and the [specific dish] was the highlight of my meal! :)";
      case 2:
        return "Excellent value for the price. Generous portions, fresh ingredients, and a wide variety of menu options. Will definitely return!";
      default:
        return "No Review";
    }
  }
}
