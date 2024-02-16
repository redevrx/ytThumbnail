import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:ythumbnail/app/modules/home/controllers/home_controller.dart';

ScreenshotController screenshotController =
    screenshotController = ScreenshotController();

class BaseCanvasView extends GetView<HomeController> {
  const BaseCanvasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () async {
                // add base image
                final picker = ImagePicker();
                final xfile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (xfile != null) {
                  controller.baseImage = await xfile.readAsBytes();

                  if (controller.baseTitle.isEmpty) {
                    controller.baseTitle.value = controller.sampleTitle;
                  }

                  controller.update(['canvas']);
                }
              },
              label: const Text('Add base image'),
              icon: const Icon(Icons.add_circle),
            ),
          ),
          // base image
          Expanded(
            child: Center(
              child: GetBuilder(
                id: 'canvas',
                init: HomeController(),
                builder: (controller) {
                  return (controller.baseImage != null)
                      ? LayoutBuilder(builder: (context, constraints) {
                          return Screenshot(
                            controller: screenshotController,
                            child: Stack(
                              children: [
                                Image.memory(
                                  controller.baseImage!,
                                  fit: BoxFit.fitWidth,
                                ),
                                Positioned(
                                  top: 120,
                                  left: 72,
                                  child: SizedBox(
                                    width: constraints.maxWidth - 132 - 32,
                                    child: Text(
                                      controller.baseTitle.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        })
                      : Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
