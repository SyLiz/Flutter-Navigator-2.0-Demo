import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: kIsWeb ? null : AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Not fond - 404'),
              SizedBox(
                height: 36,
              ),
              kIsWeb
                  ? TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back to homepage'))
                  : SizedBox(),
            ],
          ),
        ));
  }
}
