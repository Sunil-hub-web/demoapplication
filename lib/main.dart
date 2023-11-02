
import 'package:demoapplication/EditProfileUi.dart';
import 'package:demoapplication/LoginPage.dart';
import 'package:demoapplication/QuerySerachOnGoogleMap.dart';
import 'package:demoapplication/ShareTheVideoImage.dart';
import 'package:demoapplication/UserNearbyLocation.dart';
import 'package:demoapplication/facebooklogin/FacebookLogin.dart';
import 'package:demoapplication/searchdata/SearchDataList.dart';
import 'package:demoapplication/videorecording/CameraPage.dart';
import 'package:demoapplication/videorecording/VideoApp.dart';
import 'package:demoapplication/videorecording/VideoPlayerExample.dart';
import 'package:demoapplication/videorecording/VideoPlayerScreen.dart';
import 'package:demoapplication/videorecording/VideoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'ApiImplement/ApiImplmentInFlutter.dart';
import 'ConvertLatLongToAddress.dart';
import 'CurrentLocationFlutter.dart';
import 'DirectionAndKmGoogleMap.dart';
import 'DrawPolyLineFlutter.dart';
import 'GridViewbuilderLayout.dart';
import 'ListViewHomePage.dart';
import 'LoginAndRegisterUsingProvider/LoginPageApi.dart';
import 'LoginAndRegisterUsingProvider/dashboard.dart';
import 'LoginAndRegisterUsingProvider/domain/user1.dart';
import 'LoginAndRegisterUsingProvider/providers/auth_provider.dart';
import 'LoginAndRegisterUsingProvider/providers/user_provider.dart';
import 'LoginAndRegisterUsingProvider/utility/shared_preference.dart';
import 'MyHomePageFluShbar.dart';
import 'NearByPlacesOnmap.dart';
import 'RegisterPage.dart';
import 'SearchLocationMap.dart';
import 'SliverAppBarInFlutter.dart';
import 'UserProfile.dart';
import 'ViewListinDioMVVM/UserListConsumer.dart';
import 'ViewUserDetails.dart';
import 'httpgetrequestflutter/PostsPage.dart';
import 'httppostrequestFluttter/sign_up.dart';

void main(){

  runApp(const ProviderScope(child: MyApp()));

  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'HTTP',
        theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity),
        home:ConvertLatLongToAddress(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//
//     Future<User> getUserData () => UserPreferences().getUser();
//
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_)=> AuthProvider()),
//         ChangeNotifierProvider(create: (_)=>UserProvider())
//       ],
//       child:  MaterialApp(
//         title: 'Login Registration',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: FutureBuilder(
//             future: getUserData(),
//             builder: (context, snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.none:
//                 case ConnectionState.waiting:
//                   return const CircularProgressIndicator();
//                 default:
//                   if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else if (snapshot.data!.token == null)
//                     return const LoginPageApi();
//                   else
//                     Provider.of<UserProvider>(context).setUser(snapshot.data!);
//                   return DashBoard();
//
//               }
//             }),
//         routes: {
//           '/login':(context)=>LoginPageApi(),
//           '/register':(context)=>RegisterPage(),
//           '/dashboard':(context)=>DashBoard()
//         },
//       ),
//     );
//   }
// }






