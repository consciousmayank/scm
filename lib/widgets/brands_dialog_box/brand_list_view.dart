import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/brands_dialog_box/brands_dialogbox_viewmodel.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/profile_image_widget.dart';
import 'package:stacked/stacked.dart';

class BrandListView extends StatefulWidget {
  const BrandListView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final BrandListViewArguments arguments;

  @override
  _BrandListViewState createState() => _BrandListViewState();
}

class _BrandListViewState extends State<BrandListView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BrandsDialogBoxViewModel>.reactive(
      onModelReady: (model) => model.getAllBrands(),
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
            ? const LoadingWidget()
            : Column(
                children: [
                  AppTextField(
                    autoFocus: true,
                    initialValue: model.brandToSearch,
                    hintText: brandDialogSearchTitle,
                    onTextChange: (value) {
                      if (value.length > 2) {
                        model.searchBrands(value);
                      }
                    },
                    buttonType: ButtonType.SMALL,
                    buttonIcon: model.brandToSearch.isEmpty
                        ? const Icon(Icons.search)
                        : const Icon(Icons.close),
                    onButtonPressed: () {
                      model.brandToSearch.isEmpty
                          ? model.searchBrands(model.brandToSearch)
                          : model.searchBrands('');
                    },
                  ),
                  Flexible(
                    child: LazyLoadScrollView(
                      scrollOffset: (MediaQuery.of(context).size.height ~/ 6),
                      onEndOfPage: () => model.getAllBrands(showLoader: false),
                      child: ListView.separated(
                        key: const PageStorageKey<String>('page2'),
                        itemBuilder: (context, index) => ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          title: NullableTextWidget(
                            stringValue: model.allBrandsResponse.brands!
                                .elementAt(index)
                                .title,
                          ),
                          leading: ProfileImageWidget(
                            imageUrlString: model.allBrandsResponse.brands!
                                .elementAt(index)
                                .image,
                          ),
                          onTap: () {
                            widget.arguments
                                .onTap(
                                    selectedBrand: model
                                        .allBrandsResponse.brands!
                                        .elementAt(index))
                                .call();
                          },
                        ),
                        separatorBuilder: (context, index) =>
                            const DottedLine(),
                        itemCount: model.allBrandsResponse.brands!.length,
                      ),
                    ),
                  ),
                ],
              ),
      ),
      viewModelBuilder: () => BrandsDialogBoxViewModel(),
    );
  }
}

class BrandListViewArguments {
  BrandListViewArguments({required this.onTap});

  final Function({
    required Brand selectedBrand,
  }) onTap;
}
