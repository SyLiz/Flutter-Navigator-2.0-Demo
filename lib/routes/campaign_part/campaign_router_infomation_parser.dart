import 'package:flutter/material.dart';
import 'package:flutter_web/ui/login/login_page.dart';
import 'campaign_route_part.dart';

class CampaignRouteInformationParser extends RouteInformationParser<CampaignRoutePart> {
  @override
  Future<CampaignRoutePart> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse("${routeInformation.location}");

    /// TODO; Handle Uri pathSegments

    // Handle check login
    if (!isLogged) return CampaignRoutePart.home();

    // Handle '/'
    if (uri.pathSegments.length == 0) return CampaignRoutePart.home();

    // Handel 'campaign/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments.first != 'detail') return CampaignRoutePart.unknown();
      final getCampIDFromURI = uri.pathSegments.elementAt(1);
      final tryIntCamID = int.tryParse(getCampIDFromURI);
      if (tryIntCamID == null) return CampaignRoutePart.unknown();
      return CampaignRoutePart.detail(tryIntCamID);
    }

    // Handle unknown routes
    return CampaignRoutePart.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(CampaignRoutePart path) {
    if (path.isUnknown) return RouteInformation(location: '/404');
    if (path.isHomePage) return RouteInformation(location: '/');
    if (path.isDetailPage) return RouteInformation(location: 'detail/${path.campID!}');
    return null;
  }
}
