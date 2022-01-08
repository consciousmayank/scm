import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';

class LottieStopAnimation extends StatelessWidget {
  const LottieStopAnimation({
    Key? key,
    required this.args,
  }) : super(key: key);

  final LottieStopAnimationArgs args;

  Widget getAnimatedChild() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: args.showBg
          ? BoxDecoration(
              color: AppColors().white,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            )
          : null,
      child: Lottie.asset(
        args.animation,
        height: args.height,
        width: args.width,
        fit: BoxFit.cover,
        repeat: args.repeatAnimation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return args.onTap != null
        ? InkWell(
            onTap: args.onTap,
            child: getAnimatedChild(),
          )
        : getAnimatedChild();
  }
}

class LottieStopAnimationArgs {
  LottieStopAnimationArgs({
    required this.animation,
    this.onTap,
    this.width = 40,
    this.height = 40,
    this.repeatAnimation = false,
    this.showBg = true,
  });

  final Function()? onTap;
  final String animation;
  final bool repeatAnimation, showBg;
  final double height, width;
}
