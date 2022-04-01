class CampaignRoutePart {
  final int? campID;
  final bool isUnknown;

  CampaignRoutePart.home()
      : campID = null,
        isUnknown = false;

  CampaignRoutePart.detail(this.campID) : isUnknown = false;

  CampaignRoutePart.unknown()
      : campID = null,
        isUnknown = true;

  bool get isHomePage => campID == null;
  bool get isDetailPage => campID != null;
}
