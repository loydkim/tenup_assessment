import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tenup_project/developer/model/developer_review.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.developerReview});
  final DeveloperReview developerReview;

  @override
  Widget build(BuildContext context) {
    final photoSize = 60.0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: photoSize,
                height: photoSize,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  borderRadius:
                      BorderRadius.all(Radius.circular(photoSize / 2)),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 3.0,
                  ),
                ),
                child: ClipOval(
                    child: CachedNetworkImage(
                  imageUrl: developerReview.image,
                  width: photoSize,
                  height: photoSize,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(developerReview.name,
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                      "${developerReview.company} - ${developerReview.position}",
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          Divider(),
          Text(developerReview.review,
              style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
