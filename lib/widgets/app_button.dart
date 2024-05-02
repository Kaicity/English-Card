import 'package:english_card_app/values/app_colors.dart';
import 'package:english_card_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton ({Key? key, required this.label, required this.onTap}) : super(key: key);
  
  final String label;
  final VoidCallback onTap;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(3, 6),
              blurRadius: 6
            )
          ]
        ),
        child: Text(
          label,
          style: AppStyle.h5.copyWith(color: AppColors.textColor),
        ),
      ),
    );
  }
}
