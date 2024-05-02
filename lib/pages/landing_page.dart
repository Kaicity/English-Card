import 'package:english_card_app/pages/home_page.dart';
import 'package:english_card_app/values/app_assets.dart';
import 'package:english_card_app/values/app_colors.dart';
import 'package:english_card_app/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                //color: Colors.green,
                child: Text(
                  'Welcome to',
                  style: AppStyle.h3
                ),
              ),
            ),

            Expanded(
              child: Container(
                //color: Colors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'English',
                      style: AppStyle.h2.copyWith(
                        color: AppColors.blackGrey,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                          'Qoutes"',
                        style: AppStyle.h4.copyWith(height: 0.5),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 72),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false );
                  },
                  child: Image.asset(AppAssets.righArrow),
                  fillColor: AppColors.lighBlue,
                  shape: CircleBorder(),

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
