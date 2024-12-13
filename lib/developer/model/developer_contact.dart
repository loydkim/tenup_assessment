import 'package:flutter/material.dart';

class DeveloperTile {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconForegroundColor;
  final String urlLink;

  DeveloperTile(
      {required this.title,
      required this.subtitle,
      required this.icon,
      required this.iconBackgroundColor,
      required this.iconForegroundColor,
      required this.urlLink});
}

final List<DeveloperTile> developerTiles = [
  DeveloperTile(
      title: 'Download on App store',
      subtitle: '4.8 / 5 [1,084 Ratings]',
      icon: Icons.apple,
      iconBackgroundColor: Colors.grey.shade200,
      iconForegroundColor: Colors.black,
      urlLink: 'https://apps.apple.com/us/developer/youngsic-kim/id1214575043'),
  DeveloperTile(
      title: 'Download on Google Play Store',
      subtitle: '4.8 / 5 [246 Ratings]',
      icon: Icons.android,
      iconBackgroundColor: Colors.grey.shade200,
      iconForegroundColor: Colors.green,
      urlLink: 'https://play.google.com/store/apps/developer?id=Loyd+Kim'),
  DeveloperTile(
      title: 'LinkedIn - Youngsic Kim',
      subtitle: 'Mobile Application Developer',
      icon: Icons.link,
      iconBackgroundColor: Colors.indigo,
      iconForegroundColor: Colors.white,
      urlLink: 'https://www.linkedin.com/in/youngsic-kim-91545846/'),
  DeveloperTile(
      title: 'Github',
      subtitle: '82 Repositories',
      icon: Icons.hub,
      iconBackgroundColor: Colors.black,
      iconForegroundColor: Colors.white,
      urlLink: 'https://github.com/loydkim'),
  DeveloperTile(
      title: 'Youtube',
      subtitle: '2.89K subscribers, 154 videos',
      icon: Icons.play_arrow,
      iconBackgroundColor: Colors.red,
      iconForegroundColor: Colors.white,
      urlLink: 'https://www.youtube.com/channel/UCLNCErWFQ6LZoaV_JKOq_lQ'),
  DeveloperTile(
      title: 'Portfolio',
      subtitle: 'Show skill summary',
      icon: Icons.portrait,
      iconBackgroundColor: Colors.green,
      iconForegroundColor: Colors.white,
      urlLink: 'https://loydlab.blogspot.com/')
];
