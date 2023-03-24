// ignore_for_file: file_names

import 'package:filter_app/common/app_string.dart';
import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const SquareButton(
      {super.key, required this.icon, required this.text, required this.onTap});

  const SquareButton.camera({super.key, required this.onTap})
      : icon = Icons.camera_alt_outlined,
        text = AppString.camera;

  const SquareButton.gallery({super.key, required this.onTap})
      : icon = Icons.photo_library_outlined,
        text = AppString.gallery;

  @override
  Widget build(BuildContext context) {
    Size info = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(info.width * 0.03),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(0.0, .0),
            )
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 60,
              color: Colors.blue,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
