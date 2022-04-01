import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/models/campaign_model.dart';

class DetailPage extends StatelessWidget {
  final CampaignModel model;
  const DetailPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: kIsWeb ? false : true,
          title: Text('${model.title}'),
        ),
        body: Center(
          child: Text("Campaign id = ${model.id}"),
        ));
  }
}
