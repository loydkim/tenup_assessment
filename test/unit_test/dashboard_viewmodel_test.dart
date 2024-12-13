import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider_test/provider_test.dart';
import 'package:tenup_project/dashboard/view_model/dashboard_model.dart';
import 'package:yelp_api/yelp_api.dart';

const restaurantId = "crM1idgY_glhtxXT5kERNg";
const restaurantName = "The Halal Guys";
const restaurantPrice = "\$\$";

class MockRestaurant extends Mock implements Restaurant {}

class MockYelpApiClient extends Mock implements YelpApiClient {}

void main() {
  group('Dashboard Viewmodel Test', () {
    late Restaurant restaurant;
    late YelpApiClient yelpApiClient;
    late DashboardModel dashboardModel;
    setUp(() async {
      restaurant = MockRestaurant();
      yelpApiClient = MockYelpApiClient();

      when(() => restaurant.id).thenReturn(restaurantId);
      when(() => restaurant.name).thenReturn(restaurantName);
      when(() => restaurant.price).thenReturn(restaurantPrice);
      when(
        () => yelpApiClient.getRestaurants(),
      ).thenAnswer((_) async => [restaurant]);
    });

    test('mock restaurant is correct with model', () {
      dashboardModel = DashboardModel(restaurants: [restaurant]);

      expect(dashboardModel.restaurants.length, 1);
      expect(dashboardModel.restaurants.first.id, restaurantId);
      expect(dashboardModel.restaurants.first.name, restaurantName);
      expect(dashboardModel.restaurants.first.price, restaurantPrice);
    });

    test('initial state is correct', () async {
      dashboardModel = DashboardModel();
      await dashboardModel.fetchRestaurant(yelpApiClient: yelpApiClient);
      expect(dashboardModel.restaurants.length, 1);
      expect(dashboardModel.restaurants.first.id, restaurantId);
      expect(dashboardModel.restaurants.first.name, restaurantName);
      expect(dashboardModel.restaurants.first.price, restaurantPrice);
    });

    group('fetchRestaurant', () {
      testProvider<DashboardModel>(
        'DashboardModel set nothing when no restaurant.',
        build: () => DashboardModel(),
        act: (_) {},
        expect: {
          (provider) => provider.restaurants.length: [0],
        },
      );

      testProvider<DashboardModel>(
        'DashboardModel start Loading',
        build: () => DashboardModel(),
        act: (provider) => provider.setLoading(true),
        expect: {
          (provider) => provider.isLoading: [true],
        },
      );

      testProvider<DashboardModel>(
        'DashboardModel fetch restaurant with mock data',
        build: () => DashboardModel(),
        act: (provider) =>
            provider.fetchRestaurant(yelpApiClient: yelpApiClient),
        expect: {
          (provider) => provider.restaurants.length: [1],
        },
      );

      testProvider<DashboardModel>(
        'DashboardModel set exist restaurant data',
        build: () => DashboardModel(restaurants: [restaurant]),
        act: (_) => {},
        expect: {
          (provider) => provider.restaurants.length: [1],
          (provider) => provider.restaurants.first.id!: [restaurantId],
          (provider) => provider.restaurants.first.name!: [restaurantName],
          (provider) => provider.restaurants.first.price!: [restaurantPrice],
        },
      );
    });
  });
}
