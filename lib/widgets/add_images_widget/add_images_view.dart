import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/add_images_widget/add_images_viewmodel.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:stacked/stacked.dart';

class AddImagesView extends StatelessWidget {
  const AddImagesView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final AddImagesViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddImagesViewModel>.reactive(
      builder: (context, model, child) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.50,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Images'),
                SizedBox.fromSize(
                  size: Size(
                    Dimens().buttonHeight * 4,
                    Dimens().buttonHeight,
                  ),
                  child: AppButton(
                    buttonBg: AppColors().buttonGreenColor,
                    title: labelAddImage,
                    onTap: () {
                      model.pickImages();
                    },
                  ),
                ),
              ],
            ),
            hSizedBox(height: 8),
            Flexible(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.height * 0.40,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.memory(
                        model.selectedFiles.elementAt(index),
                        height: MediaQuery.of(context).size.height * 0.40,
                        fit: BoxFit.fitHeight,
                        width: MediaQuery.of(context).size.height * 0.40,
                      ),
                      InkWell(
                        onTap: () {
                          model.selectedFiles.removeAt(index);
                          model.notifyListeners();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                itemCount: model.selectedFiles.length,
                separatorBuilder: (BuildContext context, int index) =>
                    wSizedBox(
                  width: 5,
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => AddImagesViewModel(),
    );
  }
}

class AddImagesViewArguments {}
