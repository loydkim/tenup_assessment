import 'package:flutter/material.dart';
import 'package:tenup_project/developer/model/developer_contact.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperListTile extends StatelessWidget {
  const DeveloperListTile({super.key, required this.developerTile});
  final DeveloperTile developerTile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          key: Key(developerTile.title),
          title: Text(developerTile.title,
              style: Theme.of(context).textTheme.headlineSmall),
          subtitle: Text(developerTile.subtitle,
              style: Theme.of(context).textTheme.titleMedium),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: developerTile.iconBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              developerTile.icon,
              color: developerTile.iconForegroundColor,
              size: 40,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () async {
            if (!await launchUrl(Uri.parse(developerTile.urlLink))) {
              throw Exception('Could not launch ${developerTile.urlLink}');
            }
          },
        ),
        Divider(),
      ],
    );
  }
}
