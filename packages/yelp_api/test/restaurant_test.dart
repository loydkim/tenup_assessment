import 'package:yelp_api/yelp_api.dart';
import 'package:test/test.dart';

void main() {
  group('Restaurant', () {
    group('fromJson', () {
      test('returns correct Restaurant object', () {
        expect(
            Restaurant.fromJson(
              <String, dynamic>{
                'id': "faPVqws-x-5k2CQKDNtHxw",
                'name': 'Yardbird Southern Table & Bar',
                "price": "\$\$",
                "rating": 4.5,
                "photos": [
                  "https:///s3-media4.fl.yelpcdn.com/bphoto/_zXRdYX4r1OBfF86xKMbDw/o.jpg"
                ],
                "categories": [
                  {"alias": "southern", "title": "Southern"},
                ],
                "hours": [
                  {"is_open_now": true},
                ],
                "reviews": [
                  {
                    "id": "sjZoO8wcK1NeGJFDk5i82Q",
                    "rating": 5,
                    "user": {
                      "id": "BuBCkWFNT_O2dbSnBZvpoQ",
                      "image_url":
                          "https:///s3-media2.fl.yelpcdn.com/photo/v8tbTjYaFvkzh1d7iE-pcQ/o.jpg",
                      "name": "Gina T."
                    }
                  },
                ],
                "location": {
                  "formatted_address": "1020 W Madison St",
                },
              },
            ),
            isA<Restaurant>()
                .having((w) => w.id, 'id', 'faPVqws-x-5k2CQKDNtHxw')
                .having((w) => w.name, 'name', 'Yardbird Southern Table & Bar')
                .having((w) => w.price, 'price', "\$\$")
                .having((w) => w.rating, 'rating', 4.5)
                .having((w) => w.photos, 'photos', [
              "https:///s3-media4.fl.yelpcdn.com/bphoto/_zXRdYX4r1OBfF86xKMbDw/o.jpg"
            ]).having((w) => w.categories, 'categories', [
              isA<Category>()
                  .having((c) => c.alias, 'alias', 'southern')
                  .having((c) => c.title, 'title', 'Southern'),
            ]).having((w) => w.hours, 'hours', [
              isA<Hours>().having((h) => h.isOpenNow, 'is_open_now', true)
            ]).having((w) => w.reviews, 'reviews', [
              isA<Review>()
                  .having((r) => r.id, 'id', 'sjZoO8wcK1NeGJFDk5i82Q')
                  .having((r) => r.rating, 'rating', 5)
                  .having(
                      (r) => r.user,
                      'user',
                      isA<User>()
                          .having((u) => u.id, 'id', 'BuBCkWFNT_O2dbSnBZvpoQ')
                          .having(
                            (u) => u.imageUrl,
                            'image_url',
                            "https:///s3-media2.fl.yelpcdn.com/photo/v8tbTjYaFvkzh1d7iE-pcQ/o.jpg",
                          )
                          .having((u) => u.name, 'name', 'Gina T.'))
            ]).having(
                    (w) => w.location,
                    'location',
                    isA<Location>().having((l) => l.formattedAddress,
                        'formatted_address', "1020 W Madison St")));
      });
    });
  });
}
