import 'package:cigarKey/model/ProductsModel.dart';
import 'package:cigarKey/providers/provider.dart';
import 'package:cigarKey/screens/Login/publicDetails.dart';
import 'package:cigarKey/screens/Lounges/ContactUsPage.dart';
import 'package:cigarKey/screens/Lounges/DetailsPage.dart';
import 'package:cigarKey/screens/Login/ForgotPassword.dart';
import 'package:cigarKey/screens/HomeOptions/AboutUs.dart';
import 'package:cigarKey/screens/HomeOptions/AppFeatures.dart';
import 'package:cigarKey/screens/InitialTest/CoffeeNotes.dart';
import 'package:cigarKey/screens/InitialTest/FruitNotes.dart';
import 'package:cigarKey/screens/InitialTest/HerbNotes.dart';
import 'package:cigarKey/screens/InitialTest/NatureNotes.dart';
import 'package:cigarKey/screens/InitialTest/Result.dart';
import 'package:cigarKey/screens/InitialTest/StartTest.dart';
import 'package:cigarKey/screens/InitialTest/WhiskeyNotes.dart';
import 'package:cigarKey/screens/Lounges/LocationPage.dart';
import 'package:cigarKey/screens/Login/LoginPage.dart';
import 'package:cigarKey/screens/Login/PhotoPage.dart';
import 'package:cigarKey/screens/Lounges/Products.dart';
import 'package:cigarKey/screens/Menu/TabBarPage.dart';
import 'package:cigarKey/screens/Menu/Tabs/FavoritesPage.dart';
import 'package:cigarKey/screens/Profile/RewardsPage.dart';
import 'package:cigarKey/screens/Login/ScanQR.dart';
import 'package:cigarKey/screens/Profile/SettingsPage.dart';
import 'package:cigarKey/screens/Login/SingUp.dart';
import 'package:cigarKey/screens/Profile/SuggestionsPage.dart';
import 'package:cigarKey/screens/InitialTest/SweetNotes.dart';

import 'package:cigarKey/screens/Profile/changePassword.dart';
import 'package:cigarKey/screens/Profile/editProfile.dart';
import 'package:cigarKey/screens/Lounges/map.dart';
import 'package:cigarKey/utils/notification_api.dart';
import 'package:cigarKey/widgets/LoadingPage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationApi.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() : super();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider<MyProvider>(
        create: (context) => MyProvider(),
        child: Consumer<MyProvider>(
          builder: (context, myProvider, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cigar Key',
            theme: ThemeData(
              primarySwatch: Colors.yellow,
              unselectedWidgetColor: Color.fromRGBO(197, 169, 1, 1),
            ),
            home: LoadingPage(),
            routes: <String, WidgetBuilder>{
              '/LoadingPage': (BuildContext context) => new LoadingPage(),
              '/LoginPage': (BuildContext context) => new LoginPage(),
              '/SingUp': (BuildContext context) => new SingUp(),
              '/ForgotPassword': (BuildContext context) => new ForgotPassword(),
              '/ScanQR': (BuildContext context) => new ScanQRPage(),
              '/StartTest': (BuildContext context) => new StartTest(),
              '/NatureTest': (BuildContext context) => new NatureNotes(),
              '/CoffeeTest': (BuildContext context) => new CoffeeNotes(),
              '/HerbTest': (BuildContext context) => new HerbNotes(),
              '/SweetTest': (BuildContext context) => new SweetNotes(),
              '/FruitTest': (BuildContext context) => new FruitNotes(),
              '/WhiskeyTest': (BuildContext context) => new WhiskeyNotes(),
              '/PhotoPage': (BuildContext context) => new PhotoPage(),
              '/ProfileResult': (BuildContext context) => new ProfileResult(),
              '/AppFeatures': (BuildContext context) => new AppFeatures(),
              '/AboutUs': (BuildContext context) => new AboutUs(),
              '/TabBar': (BuildContext context) => new TabBarPage(),
              '/SuggestionsPage': (BuildContext context) =>
                  new SuggestionsPage(),
              '/DetailsPage': (BuildContext context) => new DetailsPage(),
              '/RewardsPage': (BuildContext context) => new RewardsPage(),
              '/EditProfile': (BuildContext context) => new EditProfile(),
              '/ChangePassword': (BuildContext context) => new ChangePassword(),
              '/Settings': (BuildContext context) => new Settings(),
              '/Location': (BuildContext context) => new LocationPage(),
              '/MapPage': (BuildContext context) => new MapPage(),
              '/FavoritePage': (BuildContext context) => new FavoritesPage(),
              '/PublicDetails': (BuildContext context) => new PublicDetails(),
              '/Products': (BuildContext context) => new ProductsPage(),
              '/ContactUsPage': (BuildContext context) => new ContactUsPage(),
            },
          ),
        ));
  }
}
