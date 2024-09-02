import 'dart:io';

import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadVerifyImage extends StatelessWidget {
  const UploadVerifyImage({
    super.key,
    required this.placeholder,
    required this.title,
    required this.description,
    required this.titleUpload,
    required this.imagePicker,
    this.image,
    required this.onNext,
  });

  final String title;
  final XFile? image;
  final Image placeholder;
  final RichText description;
  final String titleUpload;
  final VoidCallback imagePicker;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: textTheme.labelMedium,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: (MediaQuery.of(context).size.width * 0.5) * 0.75,
                    child: renderImage(),
                  ),
                ),
                description,
                GestureDetector(
                  onTap: imagePicker,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.file_upload_outlined,
                        color: ColorName.primary,
                      ),
                      Text(
                        titleUpload,
                        style: textTheme.labelMedium?.copyWith(
                          color: ColorName.primary,
                        ),
                      )
                    ].withSpaceBetween(width: 8),
                  ),
                )
              ].withSpaceBetween(height: 45),
            ),
          ),
          CustomElevatedBtn(
              onTap: image != null ? onNext : null, title: 'Next'),
        ],
      ),
    );
  }

  Widget renderImage() {
    if (image == null) {
      return placeholder;
    }

    return Image.file(File(image!.path));
  }
}
