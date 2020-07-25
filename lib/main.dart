import 'package:doglover/api/dog_api_service.dart';
import 'package:doglover/api/dog_lover_api_service.dart';
import 'package:doglover/data/repository/account_repository.dart';
import 'package:doglover/data/repository/breeds_repository.dart';
import 'package:doglover/data/repository/dogs_repository.dart';
import 'package:doglover/data/repository/favourite_repository.dart';
import 'package:doglover/data/source/local/favourite_local_data_source.dart';
import 'package:doglover/data/source/remote/account_remote_data_source.dart';
import 'package:doglover/data/source/remote/breeds_remote_data_source.dart';
import 'package:doglover/data/source/remote/dogs_remote_data_source.dart';
import 'package:doglover/screens/breed_screen.dart';
import 'package:doglover/screens/create_account_screen.dart';
import 'package:doglover/screens/host_screen.dart';
import 'package:doglover/screens/login_screen.dart';
import 'package:doglover/screens/reset_password_screen.dart';
import 'package:doglover/screens/search_results_screen.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/widgets/bottomnavigation/bottom_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final dogLoverApiService = DogLoverApiService();
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        Provider<BreedsRepository>(
          create: (_) {
            return BreedsRepository(BreedsRemoteDataSource(
              DogApiService(),
            ));
          },
        ),
        Provider<AccountRepository>(
          create: (_) {
            var accountRepo =
                AccountRepository(AccountsRemoteDataSource(dogLoverApiService));
            return accountRepo;
          },
        ),
        Provider<DogsRepository>(
          create: (_) {
            return DogsRepository(DogsRemoteService(dogLoverApiService));
          },
        ),
        Provider<FavouriteRepository>(
          create: (_) {
            return FavouriteRepository(FavouriteLocalDataSource());
          },
        ),
        ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (_) => BottomNavigationBarProvider(),
        )
      ],
      child: MaterialApp(
          title: 'I Love Dogs',
          theme: ThemeData(accentColor: Styles.primaryDark),
          initialRoute: HostScreen.id,
          routes: {
            HostScreen.id: (context) => HostScreen(),
            BreedScreen.id: (context) => BreedScreen(),
            SearchResultsScreen.id: (context) => SearchResultsScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            CreateAccountScreen.id: (context) => CreateAccountScreen(),
            ResetPasswordScreen.id: (context) => ResetPasswordScreen()
          }),
    );
  }
}
