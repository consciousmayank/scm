import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/product/product_list/product_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SizeListView extends ViewModelWidget<ProductListViewModel> {
  const SizeListView({
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
            onPressed: () => viewModel.showAllSizesDialogBox(),
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
                        stringValue:
                            '${viewModel.productSizesListResponse.productSize?.elementAt(index).measurement} ${viewModel.productSizesListResponse.productSize?.elementAt(index).measurementUnit}',
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(
                              color: viewModel.sizeFilterList.contains(
                                viewModel.productSizesListResponse.productSize
                                    ?.elementAt(
                                  index,
                                ),
                              )
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                      backgroundColor: viewModel.sizeFilterList.contains(
                        viewModel.productSizesListResponse.productSize
                            ?.elementAt(
                          index,
                        ),
                      )
                          ? Theme.of(context).primaryColorLight
                          : Colors.white,
                      onPressed: () {
                        if (!viewModel.sizeFilterList.contains(
                          viewModel.productSizesListResponse.productSize
                              ?.elementAt(
                            index,
                          ),
                        )) {
                          viewModel.addToSizesFilterList(
                            subType: viewModel
                                .productSizesListResponse.productSize
                                ?.elementAt(
                              index,
                            ),
                          );
                        } else {
                          viewModel.removeFromaSizesFilterList(
                            subType: viewModel
                                .productSizesListResponse.productSize
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
                  viewModel.productSizesListResponse.productSize?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
