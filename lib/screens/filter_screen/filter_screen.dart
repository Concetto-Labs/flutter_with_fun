import 'dart:io';
import 'package:filter_app/common/app_string.dart';
import 'package:filter_app/screens/filter_screen/widget/filter_box.dart';
import 'package:filter_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/image_filter.dart';

class FilterScreen extends StatefulWidget {
  final XFile image;

  const FilterScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<FilterImageModel> filterList = [];
  int selectedIndex = 0;
  GlobalKey captureKey = GlobalKey();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    prepareFilterList();
  }

  prepareFilterList() {
    filterList.clear();
    filterList.addAll([
      FilterImageModel(title: "None", filterColor: ImageFilters.none),
      FilterImageModel(title: "Old-Life", filterColor: ImageFilters.coldLife),
      FilterImageModel(title: "Cyan", filterColor: ImageFilters.cyan),
      FilterImageModel(title: "Old-Times", filterColor: ImageFilters.oldTimes),
      FilterImageModel(
          title: "Black&White", filterColor: ImageFilters.blackAndWhite),
      FilterImageModel(title: "Purple", filterColor: ImageFilters.purple),
      FilterImageModel(title: "Sepium", filterColor: ImageFilters.sepium),
      FilterImageModel(title: "Milk", filterColor: ImageFilters.milk),
      FilterImageModel(title: "Invert", filterColor: ImageFilters.invert),
      FilterImageModel(title: "Sepia", filterColor: ImageFilters.sepia),
      FilterImageModel(title: "Greyscale", filterColor: ImageFilters.greyscale),
      FilterImageModel(title: "Yellow", filterColor: ImageFilters.yellow),
      FilterImageModel(title: "Orange", filterColor: ImageFilters.orange),
      FilterImageModel(
          title: "Light-Cyan", filterColor: ImageFilters.lightCyan),
      FilterImageModel(
          title: "Light-Pink", filterColor: ImageFilters.lightPink),
      FilterImageModel(title: "Dark-Grey", filterColor: ImageFilters.darkGrey),
      FilterImageModel(
          title: "Deep-Orange", filterColor: ImageFilters.deepOrange),
      FilterImageModel(title: "Pink", filterColor: ImageFilters.pink),
      FilterImageModel(title: "Green", filterColor: ImageFilters.green),
      FilterImageModel(
          title: "Dark-Green", filterColor: ImageFilters.darkGreen),
      FilterImageModel(
          title: "Thine-Green", filterColor: ImageFilters.thineGreen),
      FilterImageModel(title: "Light-Red", filterColor: ImageFilters.lightRed),
      FilterImageModel(
          title: "Light-Blue", filterColor: ImageFilters.lightBlue),
      FilterImageModel(title: "Dark-Red", filterColor: ImageFilters.darkRed),
      FilterImageModel(title: "Dark", filterColor: ImageFilters.dark),
      FilterImageModel(title: "Blue", filterColor: ImageFilters.blue),
    ]);
    setState(() {
      selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size info = MediaQuery.of(context).size;
    final Image selectedImage = Image.file(
      File(widget.image.path),
      fit: BoxFit.cover,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          AppString.filterImage,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async => await onNextTap(context),
              icon: const Icon(Icons.arrow_forward_outlined))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: info.height * 0.6,
                width: info.width,
                child: RepaintBoundary(
                  key: captureKey,
                  child: ColorFiltered(
                    colorFilter: filterList[selectedIndex].filterColor,
                    child: Image.file(
                      File(widget.image.path),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: info.height * 0.2,
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: filterList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return FilterBox(
                          isSelected: selectedIndex == index,
                          title: filterList[index].title,
                          selectedImage: selectedImage,
                          onTap: () {
                            if (!(index == selectedIndex)) {
                              scrollController.animateTo(
                                index >= selectedIndex && !(index <= 1)
                                    ? scrollController.position.pixels + 150
                                    : scrollController.position.pixels - 150,
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.easeIn,
                              );
                            }
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          colorFilter: filterList[index].filterColor,
                        );
                      }),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> onNextTap(BuildContext context) async {
    final RenderRepaintBoundary boundary =
        captureKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    Uint8List? imageIntList = await AppUtils.getImageIntList(boundary);
    if (context.mounted) Navigator.pop(context, imageIntList);
  }
}
