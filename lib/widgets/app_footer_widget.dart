import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';

class AppFooterWidget extends StatelessWidget {
  const AppFooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: Container(),
      tablet: Container(),
      desktop: Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        color: Theme.of(context).primaryColorDark,
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Text(
          labelAppFooterTitle,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColors().white,
              ),
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     // Image.asset(
        //     //   scmLogo,
        //     //   height: 40,
        //     //   width: 40,
        //     // ),
        //     // Text(
        //     //   labelAppFooterTitle,
        //     //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
        //     //         color: AppColors().white,
        //     //       ),
        //     // ),
        //     // Row(
        //     //   children: [
        //     //     Text(
        //     //       labelAppFooterSubTitle1,
        //     //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
        //     //             color: AppColors().white,
        //     //           ),
        //     //     ),
        //     //     wSizedBox(
        //     //       width: 16,
        //     //     ),
        //     //     Text(
        //     //       labelAppFooterSubTitle2,
        //     //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
        //     //             color: AppColors().white,
        //     //           ),
        //     //     ),
        //     //     wSizedBox(
        //     //       width: 16,
        //     //     ),
        //     //     Text(
        //     //       labelAppFooterSubTitle3,
        //     //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
        //     //             color: AppColors().white,
        //     //           ),
        //     //     )
        //     //   ],
        //     // ),
        //   ],
        // ),
      ),
    );
  }
}
