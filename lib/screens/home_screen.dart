import 'package:filter_app/common/app_string.dart';
import 'package:filter_app/utils/utils.dart';
import 'package:filter_app/widget/square_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'filter_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? selectedImageIntList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.choseImage,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //Image if not null
            if (selectedImageIntList != null)
              SelectedImage(uInt8list: selectedImageIntList!),
            const Spacer(),
            //Row menu
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SquareButton.camera(
                      onTap: () =>
                          onImagePickerTap(context, ImageSource.camera)),
                  SquareButton.gallery(
                      onTap: () =>
                          onImagePickerTap(context, ImageSource.gallery)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onImagePickerTap(BuildContext context, ImageSource imageSource) async {
    var image = await AppUtils.pickImage(imageSource);
    if (image != null && context.mounted) {
      Uint8List? imageIntList = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FilterScreen(
                    image: image,
                  )));

      if (imageIntList != null) {
        setState(() {
          selectedImageIntList = imageIntList;
        });
      }
    }
  }
}

class SelectedImage extends StatelessWidget {
  const SelectedImage({super.key, required this.uInt8list});

  final Uint8List uInt8list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Image.memory(uInt8list),
    );
  }
}
