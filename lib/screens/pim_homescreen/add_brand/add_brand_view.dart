import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/screens/pim_homescreen/add_brand/add_brand_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:stacked/stacked.dart';

class AddBrandView extends StatelessWidget {
  const AddBrandView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final AddBrandViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddBrandViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
            ? const LoadingWidget()
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const PageBarWidget(
                    title: addBrandPageTitle,
                    // subTitle: '#${model.productListResponse.totalItems}',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: model.selectedFiles.isEmpty
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                hintText: brandTitleHintText,
                                controller: model.brandTitleController,
                                onTextChange: (value) => model.brandToAdd =
                                    model.brandToAdd.copyWith(
                                  title: value,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: model.selectedFiles.isEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: Dimens().buttonHeight,
                                        width: Dimens().buttonHeight * 5,
                                        child: TextButton.icon(
                                          style: AppTextButtonsStyles()
                                              .textButtonStyle,
                                          onPressed: () {
                                            model.pickImages();
                                          },
                                          icon: const Icon(Icons.add_a_photo),
                                          label: const Text(
                                            labelAddImage,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Image.memory(
                                        model.selectedFiles.elementAt(0),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          model.selectedFiles.removeAt(0);
                                          model.notifyListeners();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(
                                            10,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius:
                                                const BorderRadius.only(
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
                                  ))
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: Dimens().buttonHeight,
                      child: TextButton(
                        clipBehavior: Clip.antiAlias,
                        onPressed: () {
                          if (model.brandToAdd.title!.isEmpty) {
                            //check if brand title is empty
                            model.showErrorSnackBar(
                                message: brandTitleRequiredErrorMessage,
                                onSnackBarOkButton:
                                    model.brandTitleFocusNode.requestFocus);
                          } else {
                            model.addBrand();
                          }
                        },
                        child: const Text('Add Product'),
                        style: AppTextButtonsStyles().textButtonStyle,
                      ),
                    ),
                  ),
                ],
              ),
      ),
      viewModelBuilder: () => AddBrandViewModel(),
    );
  }
}

class AddBrandViewArguments {}
