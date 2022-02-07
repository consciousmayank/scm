import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/product/product_list/product_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SubCategoryView extends ViewModelWidget<ProductListViewModel> {
  const SubCategoryView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ProductListViewModel viewModel) {
    return SizedBox(
      height: Dimens().getSubCategoryListViewHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ActionChip(
            elevation: Dimens().getDefaultElevation,
            pressElevation: Dimens().getDefaultElevation * 2,
            label: Text(
              'View All',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onPressed: () => viewModel.showAllSubCategoriesDialogBox(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: 1,
            height: 40,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 4,
                      right: 4,
                    ),
                    child: ActionChip(
                      elevation: Dimens().getDefaultElevation,
                      pressElevation: Dimens().getDefaultElevation * 2,
                      padding: const EdgeInsets.all(2.0),
                      label: NullableTextWidget(
                        stringValue: viewModel.subCategoryListResponse.subTypes
                            ?.elementAt(index)
                            .subType,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(
                              color: viewModel.subCategoryFilterList.contains(
                                      viewModel.subCategoryListResponse.subTypes
                                          ?.elementAt(index))
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                      backgroundColor: viewModel.subCategoryFilterList.contains(
                        viewModel.subCategoryListResponse.subTypes?.elementAt(
                          index,
                        ),
                      )
                          ? Theme.of(context).primaryColorLight
                          : Colors.white,
                      onPressed: () {
                        if (!viewModel.subCategoryFilterList.contains(
                          viewModel.subCategoryListResponse.subTypes?.elementAt(
                            index,
                          ),
                        )) {
                          viewModel.addToSubCategoryFilterList(
                            subType: viewModel.subCategoryListResponse.subTypes
                                ?.elementAt(
                              index,
                            ),
                          );
                        } else {
                          viewModel.removeFromSubCategoryFilterList(
                            subType: viewModel.subCategoryListResponse.subTypes
                                ?.elementAt(
                              index,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
              itemCount:
                  viewModel.subCategoryListResponse.subTypes?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
