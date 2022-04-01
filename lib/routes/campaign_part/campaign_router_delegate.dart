import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/models/campaign_model.dart';
import 'package:flutter_web/routes/campaign_part/campaign_route_part.dart';
import 'package:flutter_web/ui/unknown_page.dart';
import '../../ui/dashboard/dashboard_page.dart';
import '../../ui/dashboard/detail_page.dart';
import '../../ui/login/login_page.dart';
import '../../utils/share_preference.dart';

class CampaignRouterDelegate extends RouterDelegate<CampaignRoutePart>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<CampaignRoutePart> {
  CampaignModel? _selected;
  bool show404 = false;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  // TODO: implement navigatorKey
  CampaignRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  void _handleCampaignTapped(CampaignModel model) {
    _selected = model;
    notifyListeners();
  }

  void _handleLogin() async {
    isLogged = true;
    Storage.setUserLogin(Storage.keyLogin, true);
    notifyListeners();
  }

  void _handleLogout() async {
    isLogged = false;
    Storage.logout();
    notifyListeners();
  }

  @override
  // TODO: implement currentConfiguration
  CampaignRoutePart? get currentConfiguration {
    if (show404) return CampaignRoutePart.unknown();
    if (_selected == null) return CampaignRoutePart.home();
    return CampaignRoutePart.detail(campaignList.indexOf(_selected!));
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      transitionDelegate: kIsWeb ? NoAnimationTransitionDelegate() : Navigator().transitionDelegate,
      key: navigatorKey,
      pages: [
        MaterialPage(child: LoginPage(onLogged: () {
          _handleLogin();
        })),
        if (isLogged)
          MaterialPage(
              child: DashboardPage(
            didSelect: (value) {
              _handleCampaignTapped(value!);
            },
            onLogout: () {
              _handleLogout();
            },
          )),
        if (show404)
          MaterialPage(key: ValueKey('404'), child: UnknownPage())
        else if (_selected != null && isLogged)
          MaterialPage(
              child: DetailPage(
            model: _selected!,
          ))
      ],
      onPopPage: (Route route, result) {
        if (!route.didPop(result)) return false;
        _selected = null;
        show404 = false;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(CampaignRoutePart part) async {
    if (part.isUnknown) {
      _selected = null;
      show404 = true;
      return;
    }

    if (part.isDetailPage) {
      if (part.campID!.isNegative || part.campID! > campaignList.length - 1) {
        show404 = true;
        return;
      }
      _selected = campaignList[part.campID!];
      return;
    }
    _selected = null;
    show404 = false;
    return;
  }
}

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];

    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
    }

    for (final exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }
      results.add(exitingPageRoute);
    }

    return results;
  }
}
