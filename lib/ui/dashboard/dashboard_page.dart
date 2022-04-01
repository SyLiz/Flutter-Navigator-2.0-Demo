import 'package:flutter/material.dart';
import '../../models/campaign_model.dart';

class DashboardPage extends StatefulWidget {
  final Function(CampaignModel? value) didSelect;
  final Function() onLogout;

  const DashboardPage({Key? key, required this.didSelect, required this.onLogout})
      : super(key: key);
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Flutter Demo"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    widget.onLogout();
                  },
                  child: Center(child: Icon(Icons.logout)),
                )),
          ],
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: campaignList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => widget.didSelect(campaignList[index]),
              child: Card(
                child: ListTile(
                  title: Text(campaignList[index].title),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
