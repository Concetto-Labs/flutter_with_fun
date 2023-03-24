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
        padding: EdgeInsets.all(info.width * 0.02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(info.width * 0.04),
            border:
                Border.all(color: Colors.black54, width: info.width * 0.01)),
        child: Column(
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.black54,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
