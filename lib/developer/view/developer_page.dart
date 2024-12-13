import 'package:flutter/material.dart';
import 'package:tenup_project/developer/model/developer_contact.dart';
import 'package:tenup_project/developer/model/developer_review.dart';
import 'package:tenup_project/developer/widgets/developer_list_tile.dart';
import 'package:tenup_project/developer/widgets/developer_profile.dart';
import 'package:tenup_project/developer/widgets/developer_title_text.dart';
import 'package:tenup_project/developer/widgets/review_item.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            key: const Key('DeveloperPageScrollView'),
            child: Column(
              children: [
                DeveloperProfile(),
                DeveloperTitleText(title: "Personal Apps"),
                ...developerTiles
                    .getRange(0, 2)
                    .map((e) => DeveloperListTile(developerTile: e)),
                DeveloperTitleText(title: "Contact Me"),
                ...developerTiles
                    .getRange(2, 6)
                    .map((e) => DeveloperListTile(developerTile: e)),
                DeveloperTitleText(title: "Reviews in LinkedIn"),
                ...developerReviews.map((e) => ReviewItem(developerReview: e)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
