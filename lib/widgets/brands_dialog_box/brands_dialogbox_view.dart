import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/brands_dialog_box/brand_list_view.dart';
import 'package:scm/widgets/brands_dialog_box/brands_dialogbox_viewmodel.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/profile_image_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BrandsDialogBoxView extends StatefulWidget {
  const BrandsDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _BrandsDialogBoxViewState createState() => _BrandsDialogBoxViewState();
}

class _BrandsDialogBoxViewState extends State<BrandsDialogBoxView> {
  @override
  Widget build(BuildContext context) {
    BrandsDialogBoxViewArguments arguments =
        widget.request.data as BrandsDialogBoxViewArguments;
    return RightSidedBaseDialog(
      arguments: RightSidedBaseDialogArguments(
        // contentPadding: EdgeInsets.only(
        //   top: MediaQuery.of(context).size.height * 0.15,
        //   bottom: MediaQuery.of(context).size.height * 0.15,
        //   left: MediaQuery.of(context).size.width * 0.20,
        //   right: MediaQuery.of(context).size.width * 0.20,
        // ),
        request: widget.request,
        completer: widget.completer,
        title: arguments.title,
        child: BrandListView(
          arguments: BrandListViewArguments(
            onTap: ({required Brand selectedBrand}) {
              widget.completer(
                DialogResponse(
                  confirmed: true,
                  data: BrandsDialogBoxViewOutArguments(
                    selectedBrand: selectedBrand,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BrandsDialogBoxViewArguments {
  BrandsDialogBoxViewArguments({
    required this.title,
  });

  final String title;
}

class BrandsDialogBoxViewOutArguments {
  BrandsDialogBoxViewOutArguments({required this.selectedBrand});

  final Brand selectedBrand;
}
