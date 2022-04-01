import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool isLogged = false;

class LoginPage extends StatelessWidget {
  final Function() onLogged;
  LoginPage({required this.onLogged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? null
          : AppBar(
              title: Text("Flutter Demo"),
            ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 32, width: 16),
              Text(
                "Welcome to MyDemo",
                style: GoogleFonts.mitr(fontSize: 22, color: Colors.black),
              ),
              SizedBox(height: 32, width: 16),
              Text("กรุณาระบุ Login เพื่อเข้าทำงาน"),
              SizedBox(height: 32, width: 16),
              TextField(),
              SizedBox(height: 32, width: 16),
              TextField(),
              SizedBox(height: 32, width: 16),
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: () {}, child: Text("ลืมรหัสผ่าน?")),
                ),
              ),
              SizedBox(height: 18, width: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("เข้าสู่ระบบ"),
                  onPressed: () {
                    onLogged();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
