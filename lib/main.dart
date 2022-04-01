import 'package:flutter/material.dart';
import 'package:flutter_web/routes/campaign_part/campaign_router_delegate.dart';
import 'package:flutter_web/routes/campaign_part/campaign_router_infomation_parser.dart';
import 'package:flutter_web/ui/login/login_page.dart';

import 'package:flutter_web/utils/share_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  isLogged = await Storage.getIsLogged(Storage.keyLogin, defValue: false);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: CampaignRouteInformationParser(),
        routerDelegate: CampaignRouterDelegate());
  }
}
