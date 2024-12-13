import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DeveloperProfile extends StatelessWidget {
  const DeveloperProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final photoSize = 140.0;
    return Column(
      children: [
        Container(
          width: photoSize,
          height: photoSize,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            borderRadius: BorderRadius.all(Radius.circular(photoSize / 2)),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 3.0,
            ),
          ),
          child: ClipOval(
              child: CachedNetworkImage(
            imageUrl:
                "https://blogger.googleusercontent.com/img/a/AVvXsEgK8kqO61n9sYzW2mjS8mTFcwPJwv7lgruWDo0EDpS7znxACORD7YV5sYK2un3cz-1q5l7UUGFWbl7NOUdElZeA9ZqM10dEltcafi4aKWYSMJLBv8DNMyM9FFEjf1oWgelXozYyYUt7-Q-H4wEntxEZJOoAcwYmbWuk8EhdGKrU43-KA5km90vIqrFeXg=s320",
            width: 140,
            height: 140,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )),
        ),
        SizedBox(
          height: 10,
        ),
        Text("YOUNGSIC KIM 🇨🇦",
            style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(
          height: 6,
        ),
        Text("Canadian, kimloydmail@gmail.com",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.grey.shade400)),
      ],
    );
  }
}
