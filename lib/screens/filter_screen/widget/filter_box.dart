import 'package:flutter/material.dart';

class FilterBox extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  final Widget selectedImage;
  final ColorFilter colorFilter;

  const FilterBox(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isSelected,
      required this.selectedImage,
      required this.colorFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      width: 3)),
              child: ColorFiltered(
                colorFilter: colorFilter,
                child: selectedImage,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
