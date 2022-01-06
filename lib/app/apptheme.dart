// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';

AppBarTheme getAppBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    titleTextStyle: getAppTextTheme().headline1,
    iconTheme: const IconThemeData(
      color: Colors.white,
      opacity: 1,
      size: 24,
    ),
  );
}

getButtonStyle() {
  return TextButton.styleFrom(
    // primary: AppColors().primaryColor,
    // backgroundColor: AppColors().primaryColor[700],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          Dimens().getDefaultRadius,
        ),
      ),
    ),
    // shadowColor: AppColors().primaryColor[900],
    textStyle: getAppTextTheme().caption,
  );
}

getOutlinedButtonStyle() {
  return TextButton.styleFrom(
    padding: const EdgeInsets.all(5),
    primary: Colors.black,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          Dimens().getDefaultRadius,
        ),
      ),
    ),
    textStyle: getAppTextTheme().bodyText2!.copyWith(
          color: Colors.black,
        ),
  );
}

getTextButtonStyle() {
  return TextButton.styleFrom(
    primary: Colors.black,
    backgroundColor: Colors.transparent,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.all(
    //     Radius.circular(
    //       defaultBorder,
    //     ),
    //   ),
    // ),
    // shadowColor: AppColors().primaryColor[900],
    textStyle: getAppTextTheme().bodyText2,
  );
}

TextTheme getAppTextTheme() {
  return TextTheme(
    headline1: GoogleFonts.openSans(
      fontSize: 100,
      fontWeight: FontWeight.w300,
      color: Colors.black,
      // letterSpacing: -1.5,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 62,
      fontWeight: FontWeight.w300,
      color: Colors.black,
      // letterSpacing: -0.5,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 50,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    headline4: GoogleFonts.openSans(
      fontSize: 35,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.black,
    ),
    headline5: GoogleFonts.openSans(
      fontSize: 25,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 21,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Colors.black,
    ),
    subtitle1: GoogleFonts.openSans(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Colors.black,
    ),
    subtitle2: GoogleFonts.openSans(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Colors.black,
    ),
    bodyText1: GoogleFonts.openSans(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.black,
    ),
    bodyText2: GoogleFonts.openSans(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.black,
    ),
    button: GoogleFonts.openSans(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: Colors.black,
    ),
    caption: GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: Colors.black,
    ),
    overline: GoogleFonts.openSans(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Colors.black,
    ),
  );
}

class ApplicationTheme {
  final MaterialColor demandPrimaryColor = const MaterialColor(0xFF2D2F42, {
    50: Color(0xFFefedfc),
    100: const Color(0xFFd2d6e9),
    200: const Color(0xFFb8bad2),
    300: const Color(0xFF9c9fbb),
    400: const Color(0xFF888ba9),
    500: const Color(0xFF737798),
    600: const Color(0xFF646987),
    700: const Color(0xFF525570),
    800: const Color(0xFF41435a),
    900: const Color(0xFF2D2F42),
  });

  final MaterialColor primaryColor = const MaterialColor(0xFF2d4235, {
    50: Color(0xFF92c4b0),
    100: Color(0xFF92c4b0),
    200: Color(0xFF92c4b0),
    300: Color(0xFF6fac94),
    400: Color(0xFF5b9b80),
    500: Color(0xFF4f8a6f),
    600: Color(0xFF497d64),
    700: Color(0xFF416e57),
    800: Color(0xFF3a5e4b),
    900: Color(0xFF2d4235),
  });

  final MaterialColor shadesOfBlack = const MaterialColor(0xFF000000, {
    50: const Color(0xffff5f5f5),
    100: const Color(0xFFe9e9e9),
    200: const Color(0xFFd9d9d9),
    300: const Color(0xFFc4c4c4),
    400: const Color(0xFF9d9d9d),
    500: const Color(0xFF7b7b7b),
    600: const Color(0xFF555555),
    700: const Color(0xFF434343),
    800: const Color(0xFF262626),
    900: const Color(0xFF000000),
  });

  final MaterialColor supplyPrimaryColor = const MaterialColor(0xff003f63, {
    50: const Color(0xFFe2eff3),
    100: const Color(0xFFb8d8e4),
    200: const Color(0xFF8fc0d2),
    300: const Color(0xFF69a7c1),
    400: const Color(0xFF4e96b7),
    500: const Color(0xFF3486ad),
    600: const Color(0xFF287aa2),
    700: const Color(0xFF1a6a92),
    800: const Color(0xFF0f5a81),
    900: const Color(0xFF003f63),
  });

  List<ThemeData> getThemes() {
    return [
      getDefaultTheme(),
      getDemandTheme(),
      getSupplyTheme(),
    ];
  }

  getDefaultTheme() {
    return ThemeData(
      appBarTheme: getAppBarTheme(),
      primarySwatch: primaryColor,
      brightness: Brightness.light,
      // primaryColor: AppColors().primaryColor[400],
      primaryColorBrightness: Brightness.light,
      // primaryColorLight: AppColors().primaryColor[100],
      // primaryColorDark: AppColors().primaryColor[800],
      // canvasColor: AppColors().primaryColor[50],
      // scaffoldBackgroundColor: AppColors().appScaffoldBgColor,
      bottomAppBarColor: Colors.white,
      cardTheme: CardTheme(
          // color: AppColors().primaryColor[50],
          shape: Dimens().getCardShape(),
          elevation: 2,
          margin: const EdgeInsets.all(4)),
      // dividerColor: AppColors().primaryColor[800],
      // highlightColor: AppColors().primaryColor[200],
      // the splash color in tabs of bottombar items.
      // splashColor: AppColors().primaryColor[900],
      // selectedRowColor: AppColors().primaryColor[400],
      // unselectedWidgetColor: AppColors().primaryColor[100],
      disabledColor: Colors.grey[400],
      // toggleableActiveColor: AppColors().primaryColor[700],
      // secondaryHeaderColor: AppColors().primaryColor[300],
      // backgroundColor: AppColors().primaryColor[300],
      // dialogBackgroundColor: AppColors().primaryColor[100],
      // indicatorColor: AppColors().primaryColor[900],
      hintColor: const Color(0x8a000000),
      errorColor: const Color(0xffd32f2f),
      textTheme: getAppTextTheme(),
      primaryTextTheme: getAppTextTheme(),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(
          16,
        ),
        labelStyle: getAppTextTheme().overline,
        helperStyle: getAppTextTheme().overline,
        hintStyle: getAppTextTheme().overline,
        errorStyle: getAppTextTheme().caption,
        errorMaxLines: 1,
        isDense: true,
        isCollapsed: false,
        prefixStyle: getAppTextTheme().headline3,
        suffixStyle: getAppTextTheme().bodyText1,
        counterStyle: getAppTextTheme().overline,
        filled: true,
        // fillColor: AppColors().primaryColor[50]!,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            // color: AppColors().primaryColor[500]!,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().getDefaultRadius,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            // color: AppColors().primaryColor[900]!,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().getDefaultRadius,
            ),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().getDefaultRadius,
            ),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            // color: AppColors().primaryColor[700]!,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().getDefaultRadius,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            // color: AppColors().primaryColor[800]!,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().getDefaultRadius,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            // color: AppColors().primaryColor[900]!,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().getDefaultRadius,
            ),
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        // color: AppColors().primaryColor[800],
        opacity: 1,
        size: 24,
      ),
      primaryIconTheme: const IconThemeData(
        // color: AppColors().primaryColor[700],
        opacity: 1,
        size: 24,
      ),
      sliderTheme: SliderThemeData(
        // activeTrackColor: AppColors().primaryColor[600],
        // inactiveTrackColor: AppColors().primaryColor[300],
        disabledActiveTrackColor: Colors.grey[400],
        disabledInactiveTrackColor: Colors.grey[400],
        // activeTickMarkColor: AppColors().primaryColor[600],
        // inactiveTickMarkColor: AppColors().primaryColor[300],
        disabledActiveTickMarkColor: Colors.grey[400],
        disabledInactiveTickMarkColor: Colors.grey[400],
        // thumbColor: AppColors().primaryColor[600],
        disabledThumbColor: Colors.grey[400],
        thumbShape: SliderComponentShape.noOverlay,
        // overlayColor: AppColors().primaryColor[300],
        valueIndicatorColor: null,
        valueIndicatorShape: null,
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorTextStyle: getAppTextTheme().bodyText1,
      ),
      tabBarTheme: TabBarTheme(
        labelStyle: getAppTextTheme().bodyText2,
        unselectedLabelStyle: getAppTextTheme().overline,
        labelColor: AppColors().white,
        unselectedLabelColor: AppColors().white,
        indicator: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: BorderSide(
              width: 2.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
      // chipTheme: ChipThemeData(
      //   backgroundColor: ColorScheme.,
      //   brightness: Brightness.dark,
      //   // deleteIconColor: AppColors().primaryColor[900],
      //   disabledColor: Colors.grey[400]!,
      //   labelPadding:
      //       const EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
      //   labelStyle: getAppTextTheme().bodyText1!,
      //   padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
      //   secondaryLabelStyle: getAppTextTheme().bodyText2!,
      //   // secondarySelectedColor: AppColors().primaryColor[400]!,
      //   // selectedColor: AppColors().primaryColor[900]!,
      //   shape: StadiumBorder(
      //       side: BorderSide(
      //     // color: AppColors().primaryColor[400]!,
      //     width: 1,
      //     style: BorderStyle.solid,
      //   )),
      // ),
      dialogTheme: DialogTheme(
        contentTextStyle: getAppTextTheme().subtitle2,
        backgroundColor: Colors.white,
        titleTextStyle: getAppTextTheme().headline6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().getDefaultRadius,
            ),
          ),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: Color(0xff90caf9),
        selectionHandleColor: Color(0xff64b5f6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: getButtonStyle(),
      ),
      textButtonTheme: TextButtonThemeData(
        style: getTextButtonStyle(),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: getOutlinedButtonStyle(),
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: primaryColor,
        brightness: Brightness.light,
      ),
    );
  }

  getSupplyTheme() {
    return ThemeData(
      appBarTheme: getAppBarTheme(),
      primarySwatch: supplyPrimaryColor,
      brightness: Brightness.light,
      primaryColor: supplyPrimaryColor[400],
      primaryColorBrightness: Brightness.light,
      primaryColorLight: supplyPrimaryColor[100],
      primaryColorDark: supplyPrimaryColor[800],
      canvasColor: supplyPrimaryColor[50],
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarColor: Colors.white,
      cardTheme: CardTheme(
          color: AppColors().white,
          shape: Dimens().getCardShape(),
          elevation: 2,
          margin: const EdgeInsets.all(4)),
      dividerColor: supplyPrimaryColor[800],
      highlightColor: supplyPrimaryColor[200],
      // the splash color in tabs of bottombar items.
      splashColor: supplyPrimaryColor[900],
      selectedRowColor: supplyPrimaryColor[400],
      unselectedWidgetColor: supplyPrimaryColor[100],
      disabledColor: Colors.grey[400],
      toggleableActiveColor: supplyPrimaryColor[700],
      secondaryHeaderColor: supplyPrimaryColor[300],
      backgroundColor: supplyPrimaryColor[300],
      dialogBackgroundColor: supplyPrimaryColor[100],
      indicatorColor: supplyPrimaryColor[900],
      hintColor: const Color(0x8a000000),
      errorColor: const Color(0xffd32f2f),
      textTheme: getAppTextTheme(),
      primaryTextTheme: getAppTextTheme(),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 4,
          bottom: 4,
        ),
        labelStyle: getAppTextTheme().subtitle1,
        helperStyle: getAppTextTheme().subtitle1,
        hintStyle: getAppTextTheme().subtitle2,
        errorStyle: getAppTextTheme().caption,
        errorMaxLines: 2,
        isDense: false,
        isCollapsed: false,
        prefixStyle: getAppTextTheme().headline3,
        suffixStyle: getAppTextTheme().bodyText1,
        counterStyle: getAppTextTheme().subtitle1,
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: supplyPrimaryColor[400]!,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().defaultBorder,
            ),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: supplyPrimaryColor[900]!,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().defaultBorder,
            ),
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().defaultBorder,
            ),
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[400]!,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().defaultBorder,
            ),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: supplyPrimaryColor[800]!,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().defaultBorder,
            ),
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: supplyPrimaryColor[900]!,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().defaultBorder,
            ),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: supplyPrimaryColor[800],
        opacity: 1,
        size: 24,
      ),
      primaryIconTheme: IconThemeData(
        color: supplyPrimaryColor[700],
        opacity: 1,
        size: 24,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: supplyPrimaryColor[600],
        inactiveTrackColor: supplyPrimaryColor[300],
        disabledActiveTrackColor: Colors.grey[400],
        disabledInactiveTrackColor: Colors.grey[400],
        activeTickMarkColor: supplyPrimaryColor[600],
        inactiveTickMarkColor: supplyPrimaryColor[300],
        disabledActiveTickMarkColor: Colors.grey[400],
        disabledInactiveTickMarkColor: Colors.grey[400],
        thumbColor: supplyPrimaryColor[600],
        disabledThumbColor: Colors.grey[400],
        thumbShape: SliderComponentShape.noOverlay,
        overlayColor: supplyPrimaryColor[300],
        valueIndicatorColor: null,
        valueIndicatorShape: null,
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorTextStyle: getAppTextTheme().bodyText1,
      ),
      tabBarTheme: TabBarTheme(
        labelStyle: getAppTextTheme().bodyText2,
        unselectedLabelStyle: getAppTextTheme().overline,
        labelColor: AppColors().white,
        unselectedLabelColor: AppColors().white,
        indicator: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: BorderSide(
              width: 2.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: supplyPrimaryColor[600]!,
        brightness: Brightness.light,
        deleteIconColor: supplyPrimaryColor[900],
        disabledColor: Colors.grey[400]!,
        labelPadding:
            const EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
        labelStyle: getAppTextTheme().bodyText1!,
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
        secondaryLabelStyle: getAppTextTheme().bodyText2!,
        secondarySelectedColor: supplyPrimaryColor[400]!,
        selectedColor: supplyPrimaryColor[900]!,
        shape: StadiumBorder(
            side: BorderSide(
          color: supplyPrimaryColor[400]!,
          width: 1,
          style: BorderStyle.solid,
        )),
      ),
      dialogTheme: DialogTheme(
        contentTextStyle: getAppTextTheme().subtitle2,
        backgroundColor: Colors.white,
        titleTextStyle: getAppTextTheme().headline6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens().defaultBorder,
            ),
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors().black,
        selectionColor: const Color(0xff90caf9),
        selectionHandleColor: const Color(0xff64b5f6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: getButtonStyle(),
      ),
      textButtonTheme: TextButtonThemeData(
        style: getTextButtonStyle(),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: getOutlinedButtonStyle(),
      ),
    );
  }

  getDemandTheme() {
    return ThemeData(
      appBarTheme: getAppBarTheme(),
      primarySwatch: demandPrimaryColor,
      brightness: Brightness.light,
      primaryColor: demandPrimaryColor[400],
      primaryColorBrightness: Brightness.light,
      primaryColorLight: demandPrimaryColor[100],
      primaryColorDark: demandPrimaryColor[800],
      canvasColor: demandPrimaryColor[50],
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarColor: Colors.white,
      cardTheme: CardTheme(
          color: AppColors().white,
          shape: Dimens().getCardShape(),
          elevation: 2,
          margin: const EdgeInsets.all(4)),
      dividerColor: demandPrimaryColor[800],
      highlightColor: demandPrimaryColor[200],
      // the splash color in tabs of bottombar items.
      splashColor: demandPrimaryColor[900],
      selectedRowColor: demandPrimaryColor[400],
      unselectedWidgetColor: demandPrimaryColor[100],
      disabledColor: Colors.grey[400],
      toggleableActiveColor: demandPrimaryColor[700],
      secondaryHeaderColor: demandPrimaryColor[300],
      backgroundColor: demandPrimaryColor[300],
      dialogBackgroundColor: demandPrimaryColor[100],
      indicatorColor: demandPrimaryColor[900],
      hintColor: const Color(0x8a000000),
      errorColor: const Color(0xffd32f2f),
      textTheme: getAppTextTheme(),
      primaryTextTheme: getAppTextTheme(),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 4,
          bottom: 4,
        ),
        labelStyle: getAppTextTheme().subtitle1,
        helperStyle: getAppTextTheme().subtitle1,
        hintStyle: getAppTextTheme().subtitle1,
        errorStyle: getAppTextTheme().headline6?.copyWith(color: Colors.red),
        errorMaxLines: 2,
        isDense: false,
        isCollapsed: false,
        prefixStyle: getAppTextTheme().headline3,
        suffixStyle: getAppTextTheme().bodyText1,
        counterStyle: getAppTextTheme().subtitle1,
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens().defaultBorder),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
            // color: Colors.blue,
            // width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          // gapPadding: 12,
          borderRadius: BorderRadius.circular(Dimens().defaultBorder),
          borderSide: BorderSide(
            width: 1.5,
            color: demandPrimaryColor[500]!,
            // color: Colors.yellow,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens().defaultBorder),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens().defaultBorder),
          borderSide: BorderSide(
            color: shadesOfBlack[500]!,
            // color: Colors.green,
            width: 1.50,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens().defaultBorder),
          borderSide: BorderSide(
            color: shadesOfBlack[500]!,
            // color: Colors.green,
            width: 1.50,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens().defaultBorder),
          borderSide: BorderSide(
            color: shadesOfBlack[500]!,
            // color: Colors.green,
            width: 1.50,
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: demandPrimaryColor[800],
        opacity: 1,
        size: 24,
      ),
      primaryIconTheme: IconThemeData(
        color: demandPrimaryColor[700],
        opacity: 1,
        size: 24,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: demandPrimaryColor[600],
        inactiveTrackColor: demandPrimaryColor[300],
        disabledActiveTrackColor: Colors.grey[400],
        disabledInactiveTrackColor: Colors.grey[400],
        activeTickMarkColor: demandPrimaryColor[600],
        inactiveTickMarkColor: demandPrimaryColor[300],
        disabledActiveTickMarkColor: Colors.grey[400],
        disabledInactiveTickMarkColor: Colors.grey[400],
        thumbColor: demandPrimaryColor[600],
        disabledThumbColor: Colors.grey[400],
        thumbShape: SliderComponentShape.noOverlay,
        overlayColor: demandPrimaryColor[300],
        valueIndicatorColor: null,
        valueIndicatorShape: null,
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorTextStyle: getAppTextTheme().bodyText1,
      ),
      tabBarTheme: TabBarTheme(
        labelStyle: getAppTextTheme().bodyText2,
        unselectedLabelStyle: getAppTextTheme().overline,
        labelColor: AppColors().white,
        unselectedLabelColor: AppColors().white,
        indicator: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: BorderSide(
              width: 2.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: demandPrimaryColor[600]!,
        brightness: Brightness.light,
        deleteIconColor: demandPrimaryColor[900],
        disabledColor: Colors.grey[400]!,
        labelPadding:
            const EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
        labelStyle: getAppTextTheme().bodyText1!,
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
        secondaryLabelStyle: getAppTextTheme().bodyText2!,
        secondarySelectedColor: demandPrimaryColor[400]!,
        selectedColor: demandPrimaryColor[900]!,
        shape: StadiumBorder(
            side: BorderSide(
          color: demandPrimaryColor[400]!,
          width: 1,
          style: BorderStyle.solid,
        )),
      ),
      dialogTheme: DialogTheme(
        contentTextStyle: getAppTextTheme().subtitle2,
        backgroundColor: Colors.white,
        titleTextStyle: getAppTextTheme().headline6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Dimens().defaultBorder),
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors().black,
        selectionColor: const Color(0xff90caf9),
        selectionHandleColor: const Color(0xff64b5f6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: getButtonStyle(),
      ),
      textButtonTheme: TextButtonThemeData(
        style: getTextButtonStyle(),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: getOutlinedButtonStyle(),
      ),
    );
  }
}
