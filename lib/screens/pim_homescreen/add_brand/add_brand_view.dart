import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/screens/pim_homescreen/add_brand/add_brand_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/brands_dialog_box/brand_list_view.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';
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
                    subTitle:
                        'Search before adding new brand, so check if the brand already exists.',
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: BrandListView(
                              arguments: BrandListViewArguments(
                                onTap: ({required Brand selectedBrand}) {
                                  // model.updateBrand(
                                  //     selectedBrand: selectedBrand);
                                },
                              ),
                            ),
                          ),
                          wSizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                AppTextField(
                                  hintText: brandTitleHintText,
                                  controller: model.brandTitleController,
                                  onTextChange: (value) => model.brandToAdd =
                                      model.brandToAdd.copyWith(
                                    title: value,
                                  ),
                                ),
                                model.selectedFiles.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                        ),
                                        child: SizedBox(
                                          height: Dimens().buttonHeight,
                                          width: Dimens().buttonHeight * 5,
                                          child: AppButton(
                                            buttonBg:
                                                AppColors().buttonGreenColor,
                                            onTap: () {
                                              model.pickImages();
                                            },
                                            leading:
                                                const Icon(Icons.add_a_photo),
                                            title: labelAddImage,
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                        ),
                                        child: Stack(
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
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
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
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: Dimens().buttonHeight,
                                    child: AppButton(
                                      buttonBg: AppColors().buttonGreenColor,
                                      onTap: () {
                                        if (model.brandToAdd.title!.isEmpty) {
                                          //check if brand title is empty
                                          model.showErrorSnackBar(
                                              message:
                                                  brandTitleRequiredErrorMessage,
                                              onSnackBarOkButton: model
                                                  .brandTitleFocusNode
                                                  .requestFocus);
                                        } else {
                                          model.addBrand();
                                        }
                                      },
                                      title: labelAddBrand,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) => ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      title: NullableTextWidget(
                                        stringValue: model.addedProductList
                                            .elementAt(index)
                                            .title,
                                      ),
                                      leading: ProfileImageWidget(
                                        imageUrlString: model.addedProductList
                                            .elementAt(index)
                                            .image,
                                      ),
                                      onTap: () {},
                                    ),
                                    itemCount: model.addedProductList.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
