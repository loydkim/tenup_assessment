import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';
import 'package:yelp_api/yelp_api.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late YelpApiClient api;

  const baseUrl = 'https://api.yelp.com';
  const apiKey =
      'pFOpoemAaDeXkHTfJ1lxZXEL1MGobTl_TXm71fKyT4HfZm9Lw52jTR9Ko2Ds37yWsNz3vWWCO2gI8C1vbOy3SjEuL8ltOltuEaSHmCaRxoYM6TEcTGrN_uf0qcajYnYx';

  setUp(() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/graphql'
        },
      ),
    );
    dioAdapter = DioAdapter(
      dio: dio,
      matcher: const UrlRequestMatcher(),
    );
    dio.httpClientAdapter = dioAdapter;
    api = YelpApiClient(dio: dio);
  });

  group('yelp api test', () {
    test('makes correct http request', () async {
      dioAdapter.onPost(
        '/v3/graphql',
        (server) => server.reply(
          200,
          mockData,
          delay: const Duration(milliseconds: 500),
        ),
      );

      List<Restaurant> actual = [];
      try {
        actual = await api.getRestaurants();
      } catch (_) {}

      expect(actual.length, 10);
      expect(
          actual.first,
          isA<Restaurant>()
              .having((r) => r.id, 'id', 'crM1idgY_glhtxXT5kERNg')
              .having((r) => r.name, 'name', 'Kingyo')
              .having((r) => r.price, 'price', '\$\$')
              .having((r) => r.rating, 'rating', 4.4)
              .having((w) => w.photos, 'photos', [
            "https://s3-media1.fl.yelpcdn.com/bphoto/A33fW_IU1WhwBDeZHYpyPQ/o.jpg"
          ]).having((w) => w.categories, 'categories', [
            isA<Category>()
                .having((c) => c.alias, 'alias', 'japanese')
                .having((c) => c.title, 'title', 'Japanese'),
            isA<Category>()
                .having((c) => c.alias, 'alias', 'tapasmallplates')
                .having((c) => c.title, 'title', 'Tapas/Small Plates'),
          ]).having((w) => w.hours, 'hours', [
            isA<Hours>().having((h) => h.isOpenNow, 'is_open_now', true)
          ]).having((w) => w.reviews, 'reviews', [
            isA<Review>()
                .having((r) => r.id, 'id', 'HhxYQ0qzveRHRCB4Md7Q4g')
                .having((r) => r.rating, 'rating', 5)
                .having(
                    (r) => r.user,
                    'user',
                    isA<User>()
                        .having((u) => u.id, 'id', 'w9p1riXy9ojTdbjHpCMcrA')
                        .having(
                          (u) => u.imageUrl,
                          'image_url',
                          "https://s3-media3.fl.yelpcdn.com/photo/o2vxgBcfKln2ItOGjBSFmQ/o.jpg",
                        )
                        .having((u) => u.name, 'name', 'Evan C.')),
            isA<Review>()
                .having((r) => r.id, 'id', 'BOJ_rIi3Ybs1zZMPxwtmZg')
                .having((r) => r.rating, 'rating', 5)
                .having(
                    (r) => r.user,
                    'user',
                    isA<User>()
                        .having((u) => u.id, 'id', 'jpbiMSdPby2tvOMF-QCjPQ')
                        .having(
                          (u) => u.imageUrl,
                          'image_url',
                          "https://s3-media3.fl.yelpcdn.com/photo/vv1Jd-rcz-7mFcc5TmiVLA/o.jpg",
                        )
                        .having((u) => u.name, 'name', 'Tiffany T.')),
            isA<Review>()
                .having((r) => r.id, 'id', 'an18epFFVXRvzZy3pbKMCA')
                .having((r) => r.rating, 'rating', 4)
                .having(
                    (r) => r.user,
                    'user',
                    isA<User>()
                        .having((u) => u.id, 'id', 'k_GgurDpyDQF2K2IBeD-oQ')
                        .having(
                          (u) => u.imageUrl,
                          'image_url',
                          "https://s3-media1.fl.yelpcdn.com/photo/EqGLVscgyRDOk0nFYmA9PQ/o.jpg",
                        )
                        .having((u) => u.name, 'name', 'Brandi H.'))
          ]).having(
                  (w) => w.location,
                  'location',
                  isA<Location>().having(
                      (l) => l.formattedAddress,
                      'formatted_address',
                      "871 Denman Street\nVancouver, BC V6G 2L9\nCanada")));
    });

    test('throws APIRequestFieldRequiredFailure on non-200 response', () async {
      dioAdapter.onPost(
        '/v3/graphql',
        (server) => server.throws(
          400,
          DioException(
              requestOptions: RequestOptions(path: '/v3/graphql'),
              response: Response(
                requestOptions: RequestOptions(path: '/v3/graphql'),
                statusCode: 400,
                data: mockData,
              )),
          delay: const Duration(milliseconds: 500),
        ),
      );

      expect(
        () async => api.getRestaurants(),
        throwsA(isA<Exception>()),
      );
    });
  });
}

Map<String, dynamic> mockData = {
  "data": {
    "search": {
      "total": 7965,
      "business": [
        {
          "id": "crM1idgY_glhtxXT5kERNg",
          "name": "Kingyo",
          "price": "\$\$",
          "rating": 4.4,
          "photos": [
            "https://s3-media1.fl.yelpcdn.com/bphoto/A33fW_IU1WhwBDeZHYpyPQ/o.jpg"
          ],
          "reviews": [
            {
              "id": "HhxYQ0qzveRHRCB4Md7Q4g",
              "rating": 5,
              "user": {
                "id": "w9p1riXy9ojTdbjHpCMcrA",
                "image_url":
                    "https://s3-media3.fl.yelpcdn.com/photo/o2vxgBcfKln2ItOGjBSFmQ/o.jpg",
                "name": "Evan C."
              }
            },
            {
              "id": "BOJ_rIi3Ybs1zZMPxwtmZg",
              "rating": 5,
              "user": {
                "id": "jpbiMSdPby2tvOMF-QCjPQ",
                "image_url":
                    "https://s3-media3.fl.yelpcdn.com/photo/vv1Jd-rcz-7mFcc5TmiVLA/o.jpg",
                "name": "Tiffany T."
              }
            },
            {
              "id": "an18epFFVXRvzZy3pbKMCA",
              "rating": 4,
              "user": {
                "id": "k_GgurDpyDQF2K2IBeD-oQ",
                "image_url":
                    "https://s3-media1.fl.yelpcdn.com/photo/EqGLVscgyRDOk0nFYmA9PQ/o.jpg",
                "name": "Brandi H."
              }
            }
          ],
          "categories": [
            {"title": "Japanese", "alias": "japanese"},
            {"title": "Tapas/Small Plates", "alias": "tapasmallplates"}
          ],
          "hours": [
            {"is_open_now": true}
          ],
          "location": {
            "formatted_address":
                "871 Denman Street\nVancouver, BC V6G 2L9\nCanada"
          }
        },
        {
          "id": "4EV_ZcQmjAmP3pmO-_nb2A",
          "name": "Miku",
          "price": "\$\$\$",
          "rating": 4.4,
          "photos": [
            "https://s3-media3.fl.yelpcdn.com/bphoto/zlAuR8-YjU_eExQc7LEbDA/o.jpg"
          ],
          "reviews": [
            {
              "id": "Jf587WKVWELM1ruowPs9ow",
              "rating": 5,
              "user": {
                "id": "KLdT9bLTTt2dCbeJ0UDjcA",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/cHovpjJ20hCZF32inMIDHg/o.jpg",
                "name": "Haime K."
              }
            },
            {
              "id": "SXu-TfxyBzMH3IJC8ZgCbg",
              "rating": 1,
              "user": {
                "id": "1uRa5g-sSFxugM6vcKoiNA",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/uGyftGMI_Pwd_MYQh4tPHQ/o.jpg",
                "name": "Dongbai G."
              }
            },
            {
              "id": "rSIUermfNZAD3ofCYtiZLQ",
              "rating": 4,
              "user": {
                "id": "sr2pTeBbehzepVkzUXft7Q",
                "image_url":
                    "https://s3-media4.fl.yelpcdn.com/photo/YutpL4RQlcZfQ9Ap8pGuTQ/o.jpg",
                "name": "Michael K."
              }
            }
          ],
          "categories": [
            {"title": "Japanese", "alias": "japanese"},
            {"title": "Sushi Bars", "alias": "sushi"}
          ],
          "hours": [
            {"is_open_now": true}
          ],
          "location": {
            "formatted_address":
                "200 Granville Street\nSuite 70\nVancouver, BC V6C 1S4\nCanada"
          }
        },
        {
          "id": "XAH2HpuUUtu7CUO26pbs4w",
          "name": "Saku",
          "price": "\$\$",
          "rating": 4.3,
          "photos": [
            "https://s3-media2.fl.yelpcdn.com/bphoto/RJV1GXwxPCbfeB6pKfvV9w/o.jpg"
          ],
          "reviews": [
            {
              "id": "bXCjyp5XtchqYAsRvNsu_g",
              "rating": 5,
              "user": {
                "id": "G4F2A2xxgX9vgAqqrfaVxQ",
                "image_url":
                    "https://s3-media1.fl.yelpcdn.com/photo/Tmf3s9kFN68Buq7hZclT3g/o.jpg",
                "name": "May-Lynn L."
              }
            },
            {
              "id": "uh9s2TZjeCpvn9ohBPihIg",
              "rating": 5,
              "user": {
                "id": "OfdWjgGIIHmosl5WuPaJwg",
                "image_url":
                    "https://s3-media3.fl.yelpcdn.com/photo/iD2ro8FHLbCSJBt4m1JmgQ/o.jpg",
                "name": "Thu P."
              }
            },
            {
              "id": "xs6OcSIZLx6NYu2vUmuM6w",
              "rating": 4,
              "user": {
                "id": "8Lot9H9IYAMBF4zYqeCGIw",
                "image_url":
                    "https://s3-media1.fl.yelpcdn.com/photo/cE0Ee9wNEBqJzt03PsTu-Q/o.jpg",
                "name": "Amy N."
              }
            }
          ],
          "categories": [
            {"title": "Japanese", "alias": "japanese"},
            {"title": "Noodles", "alias": "noodles"},
            {"title": "Seafood", "alias": "seafood"}
          ],
          "hours": [
            {"is_open_now": true}
          ],
          "location": {
            "formatted_address": "548 W Broadway\nVancouver, BC V5Z 1E9\nCanada"
          }
        },
        {
          "id": "GmEeIcJ9vR04kxzYgPMEgg",
          "name": "Guu with Garlic",
          "price": "\$\$",
          "rating": 4.3,
          "photos": [
            "https://s3-media3.fl.yelpcdn.com/bphoto/A1wPc9kltHE-0ZtMTGnTjA/o.jpg"
          ],
          "reviews": [
            {
              "id": "CgyO7RdKmh-ELyJCAO6vSw",
              "rating": 5,
              "user": {
                "id": "Z8IKH9m1bGQtbbnzIddlVw",
                "image_url":
                    "https://s3-media4.fl.yelpcdn.com/photo/mzSWQzeqeQcWaelO9E2arA/o.jpg",
                "name": "Linh D."
              }
            },
            {
              "id": "jZiLxu5G3D1A9dZwKEU3pQ",
              "rating": 1,
              "user": {
                "id": "iyLIicGuC3EsP5PZjcUVKg",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/6x8jXYF6HiCOnyBKQL-yQw/o.jpg",
                "name": "Tony T."
              }
            },
            {
              "id": "b0OVgknwfdbMfI8UAW_4Xw",
              "rating": 3,
              "user": {
                "id": "EpIkXeN4GCLOvFmz-3mywg",
                "image_url":
                    "https://s3-media3.fl.yelpcdn.com/photo/Pi_W1jRZImBA1KMaTPPurA/o.jpg",
                "name": "Henry T."
              }
            }
          ],
          "categories": [
            {"title": "Japanese", "alias": "japanese"},
            {"title": "Tapas/Small Plates", "alias": "tapasmallplates"}
          ],
          "hours": [
            {"is_open_now": true}
          ],
          "location": {
            "formatted_address":
                "1698 Robson Street\nVancouver, BC V6G 1C7\nCanada"
          }
        },
        {
          "id": "LjdbthVdtLYKSi7iVAFl0g",
          "name": "Jam Cafe on Beatty",
          "price": "\$\$",
          "rating": 4.4,
          "photos": [
            "https://s3-media4.fl.yelpcdn.com/bphoto/1VCRutsqx_jR2HUqMDafDA/o.jpg"
          ],
          "reviews": [
            {
              "id": "o_DdC3dqfMg5OGkXxFe8rQ",
              "rating": 5,
              "user": {
                "id": "xw0ed8SJuOV3pjkh8mgHVw",
                "image_url":
                    "https://s3-media4.fl.yelpcdn.com/photo/RugDgrnkdSU8xSbUyqH8DA/o.jpg",
                "name": "Michael L."
              }
            },
            {
              "id": "MhWFaGObvLRaafZV8xPdTw",
              "rating": 3,
              "user": {
                "id": "HXuSa7FE7iFxkpQPktfswg",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/SyLomuTxSWQPxlylQP1jCA/o.jpg",
                "name": "Jill N."
              }
            },
            {
              "id": "_3UxCX1zTH5L0LBXzfCp-A",
              "rating": 5,
              "user": {
                "id": "yjz9yPnWSa9duKamcv_irA",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/TU0c4QcRrvtC1x6h3fozmg/o.jpg",
                "name": "Stephanie T."
              }
            }
          ],
          "categories": [
            {"title": "Breakfast & Brunch", "alias": "breakfast_brunch"}
          ],
          "hours": [
            {"is_open_now": true}
          ],
          "location": {
            "formatted_address":
                "556 Beatty Street\nVancouver, BC V6B 2L3\nCanada"
          }
        },
        {
          "id": "Ufhxnrt_OJu4jHfVTP3aRQ",
          "name": "Fanny Bay Oyster Bar & Shellfish Market",
          "price": "\$\$\$",
          "rating": 4.4,
          "photos": [
            "https://s3-media1.fl.yelpcdn.com/bphoto/Qh9mkTecj35trmXhiRSHgw/o.jpg"
          ],
          "reviews": [
            {
              "id": "F6NIjb8JTMeejGiDE6Pplg",
              "rating": 5,
              "user": {
                "id": "49jIYN_SPuOYNN2J0IoOOQ",
                "image_url":
                    "https://s3-media1.fl.yelpcdn.com/photo/sFB-9oke19HOxR90LkNHwg/o.jpg",
                "name": "Katherine R."
              }
            },
            {
              "id": "3OPESmIj5sBBa7s0ENK9ww",
              "rating": 3,
              "user": {
                "id": "aZ3QPY2VYaqXG1oezEf48w",
                "image_url":
                    "https://s3-media4.fl.yelpcdn.com/photo/F3fsiVeVMAJ7MfCYc1BZJQ/o.jpg",
                "name": "Jae V."
              }
            },
            {
              "id": "wepQCw1nQKdDh5L4e8IAnA",
              "rating": 4,
              "user": {
                "id": "nnLX60O7sIFXY92J3HEZaw",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/LwqZP49TCnx-wCWe-W3V7Q/o.jpg",
                "name": "Stephen C."
              }
            }
          ],
          "categories": [
            {"title": "Seafood", "alias": "seafood"},
            {"title": "Seafood Markets", "alias": "seafoodmarkets"}
          ],
          "hours": [
            {"is_open_now": false}
          ],
          "location": {
            "formatted_address": "762 Cambie St\nVancouver, BC V6B 2P2\nCanada"
          }
        },
        {
          "id": "gt1BSfVFvzI-qHdJ3LUZug",
          "name": "Blue Water Cafe",
          "price": "\$\$\$\$",
          "rating": 4.4,
          "photos": [
            "https://s3-media1.fl.yelpcdn.com/bphoto/Oll5duzZPe8MNYqUtDgTug/o.jpg"
          ],
          "reviews": [
            {
              "id": "XYUg19m1RyGNWCXJWMKlrg",
              "rating": 5,
              "user": {
                "id": "NxIhS4KSnqO5ApTwoKUsSA",
                "image_url":
                    "https://s3-media4.fl.yelpcdn.com/photo/ZjDN4oxXJS9WVIUTwrasSg/o.jpg",
                "name": "Damien M."
              }
            },
            {
              "id": "Ak9LlaqM1k0oRsNhTpl-mw",
              "rating": 3,
              "user": {
                "id": "CZTnYFMqq_dd910yWRI2AQ",
                "image_url":
                    "https://s3-media4.fl.yelpcdn.com/photo/DMvSZiUBCoddJDr1govmkw/o.jpg",
                "name": "Ania D."
              }
            },
            {
              "id": "38CA0c1F-87UHCYqgKN2xA",
              "rating": 4,
              "user": {
                "id": "RVdkcf9X_7oaQcbFogELPQ",
                "image_url":
                    "https://s3-media4.fl.yelpcdn.com/photo/Yuw3RwAIDRj7mHw2EP1mkw/o.jpg",
                "name": "Gerry L."
              }
            }
          ],
          "categories": [
            {"title": "Seafood", "alias": "seafood"}
          ],
          "hours": [
            {"is_open_now": false}
          ],
          "location": {
            "formatted_address":
                "1095 Hamilton St\nVancouver, BC V6B 5T4\nCanada"
          }
        },
        {
          "id": "QmkGDL-8zexdKV3Xcn8ZYg",
          "name": "OEB Breakfast Co. - Yaletown",
          "price": "\$\$",
          "rating": 4.3,
          "photos": [
            "https://s3-media1.fl.yelpcdn.com/bphoto/B-MxxZfzVpBu8XGEQBGxDg/o.jpg"
          ],
          "reviews": [
            {
              "id": "Q2K9TpPg_8YQeMofQjQu5g",
              "rating": 5,
              "user": {
                "id": "bdweX-O2_Paw-WbBbihgiQ",
                "image_url": null,
                "name": "Barinder P."
              }
            },
            {
              "id": "J_JnYcTvCgQsj6i3_VkXDg",
              "rating": 5,
              "user": {
                "id": "R2JS0EOjeC7HCWIYgXmsQA",
                "image_url":
                    "https://s3-media1.fl.yelpcdn.com/photo/eGb5yF7p1NIYH8LGDCEggw/o.jpg",
                "name": "Elizabeth S."
              }
            },
            {
              "id": "Ke098Y3ayYGeEoet_VKOBw",
              "rating": 5,
              "user": {
                "id": "bJgfxs6_h5Tcp5anvdTtYQ",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/elhVKwElEqF3TckRtn1TXg/o.jpg",
                "name": "Mike C."
              }
            }
          ],
          "categories": [
            {"title": "Breakfast & Brunch", "alias": "breakfast_brunch"}
          ],
          "hours": [
            {"is_open_now": true}
          ],
          "location": {
            "formatted_address":
                "1137 Marinaside Crescent\nVancouver, BC V6Z 2Y3\nCanada"
          }
        },
        {
          "id": "yeNenSjz_HCqngGFU5d8NQ",
          "name": "Phnom Penh",
          "price": "\$\$",
          "rating": 4.2,
          "photos": [
            "https://s3-media2.fl.yelpcdn.com/bphoto/XzbN2-p09hEFJe2sT30B3g/o.jpg"
          ],
          "reviews": [
            {
              "id": "WQTG3Dds69oTpDgbcCREHQ",
              "rating": 5,
              "user": {
                "id": "Jiools7ao_Pkmr-EsEUEUw",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/zJiX6_FkHKo-67CnMFLPgw/o.jpg",
                "name": "Amber S."
              }
            },
            {
              "id": "BUU9mcB0VCI3-QxpxOMZbA",
              "rating": 5,
              "user": {
                "id": "BXjG6ljYq306T25Fqu71Fw",
                "image_url":
                    "https://s3-media1.fl.yelpcdn.com/photo/7HzkJcAAeyycQuCJf5wBCw/o.jpg",
                "name": "Natasha P."
              }
            },
            {
              "id": "7HM8DkcROsg1_dtvnQTL_Q",
              "rating": 4,
              "user": {
                "id": "AHrFQZPjBumgGOvtRQ36xg",
                "image_url":
                    "https://s3-media3.fl.yelpcdn.com/photo/qHiY75_4-VKz1uJkrkmBvw/o.jpg",
                "name": "Linda L."
              }
            }
          ],
          "categories": [
            {"title": "Cambodian", "alias": "cambodian"},
            {"title": "Vietnamese", "alias": "vietnamese"}
          ],
          "hours": [
            {"is_open_now": false}
          ],
          "location": {
            "formatted_address":
                "244 E Georgia Street\nVancouver, BC V6A 1Z7\nCanada"
          }
        },
        {
          "id": "p5thThuUITUjAy8gS3sPMw",
          "name": "Fable Kitchen",
          "price": "\$\$",
          "rating": 4.3,
          "photos": [
            "https://s3-media3.fl.yelpcdn.com/bphoto/mIfjavZhuvotp9enRH7hUA/o.jpg"
          ],
          "reviews": [
            {
              "id": "SKQM--aTlIrF9kW0Ye7ihw",
              "rating": 5,
              "user": {
                "id": "9B48Mi-lUsacdx4zQrDtyQ",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/nDurq1wnnXynZYHvpQ0xEg/o.jpg",
                "name": "Alyson M."
              }
            },
            {
              "id": "xEPjCf_jOKs0OW8YV4Mwhg",
              "rating": 4,
              "user": {
                "id": "teXLmGR-kiEEVW93TCe32w",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/vakUwcDmdeOpVU4RqK72Tw/o.jpg",
                "name": "Natalie T."
              }
            },
            {
              "id": "kM4aoq93OxW7AN7cY5c2oA",
              "rating": 3,
              "user": {
                "id": "Mlwl-C6ZZ7cO7-Yx1ZEHqA",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/7rynHSyBor1WXf89vtCpGg/o.jpg",
                "name": "Josh L."
              }
            }
          ],
          "categories": [
            {"title": "Canadian (New)", "alias": "newcanadian"}
          ],
          "hours": [
            {"is_open_now": true}
          ],
          "location": {
            "formatted_address":
                "1944 W 4th Avenue\nVancouver, BC V6J 1M5\nCanada"
          }
        }
      ]
    }
  }
};
