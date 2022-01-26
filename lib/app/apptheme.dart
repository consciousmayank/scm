// ignore_for_file: unnecessary_const

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scm/app/dimens.dart';

AppBarTheme getAppBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    titleTextStyle: getAppTextTheme(
      textColor: Colors.black,
    ).headline1,
    iconTheme: const IconThemeData(
      color: Colors.white,
      opacity: 1,
      size: 24,
    ),
  );
}

InputDecorationTheme getInputDecorationTheme() {
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    ),
    labelStyle: getAppTextTheme(textColor: Colors.black).overline,
    helperStyle: getAppTextTheme(textColor: Colors.black).overline,
    hintStyle: getAppTextTheme(textColor: Colors.black).overline,
    errorStyle: getAppTextTheme(textColor: Colors.black).caption,
    errorMaxLines: 1,
    isDense: true,
    isCollapsed: false,
    prefixStyle: getAppTextTheme(textColor: Colors.black).bodyText1,
    suffixStyle: getAppTextTheme(textColor: Colors.black).bodyText2,
    counterStyle: getAppTextTheme(textColor: Colors.black).overline,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 0.5,
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
        width: 0.5,
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
        width: 0.5,
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
        width: 0.5,
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
        width: 0.5,
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
        width: 0.5,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(
          Dimens().getDefaultRadius,
        ),
      ),
    ),
  );
}

TextTheme getAppTextTheme({
  required Color textColor,
}) {
  return TextTheme(
    headline1: GoogleFonts.nunitoSans(
      fontSize: 36,
      fontWeight: FontWeight.w300,
      color: textColor,
      // letterSpacing: -1.5,
    ),
    headline2: GoogleFonts.nunitoSans(
      fontSize: 32,
      fontWeight: FontWeight.w300,
      color: textColor,
      // letterSpacing: -0.5,
    ),
    headline3: GoogleFonts.nunitoSans(
      fontSize: 30,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),
    headline4: GoogleFonts.nunitoSans(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: textColor,
    ),
    headline5: GoogleFonts.nunitoSans(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),
    headline6: GoogleFonts.nunitoSans(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: textColor,
    ),
    subtitle1: GoogleFonts.nunitoSans(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: textColor,
    ),
    subtitle2: GoogleFonts.nunitoSans(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: textColor,
    ),
    bodyText1: GoogleFonts.nunitoSans(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: textColor,
    ),
    bodyText2: GoogleFonts.nunitoSans(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: textColor,
    ),
    button: GoogleFonts.nunitoSans(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: textColor,
    ),
    caption: GoogleFonts.nunitoSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: textColor,
    ),
    overline: GoogleFonts.nunitoSans(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: textColor,
    ),
  );
}

class ApplicationTheme {
  final MaterialColor appPrimaryColor = const MaterialColor(0xFF2D2F42, {
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

  ///
  final Color _bottomAppBarColor = const Color(0xff6D42CE);

  final Color _buttonColor = Colors.blue.shade900;
  final Color _buttonHoverColor = Colors.orange.shade900;
  ///This is default color of MaterialType.canvas (Rectangle using default theme canvas color)
  final Color _canvasColor = const Color(0xffE09E45);

  ///color of Material when used as a Card i.e. default color for Card widget.
  final Color _cardColor = Colors.white;

  //PRimary COLORS
  final Color _darkPrimaryColor = const Color.fromRGBO(115, 107, 172, 1.0);

  final Color _darkSecondaryColor = const Color(0xFF0097A7);
  //color of Dividers and PopMenuDividers also used between ListTiles, between rows in DataTables and so forth
  final Color _dividerColor = const Color(0x1f6D42CE);

  /// focus color used to indicate that a component has input focus.
  final Color _focusColor = const Color(0x1aF5E0C3);

  ///The highlight color is used to show if something is selected.
  ///The highlight color is used during ink splash animations or to indicate an item in a menu is selected.
  final Color _hightlightColorColor = const Color(0x1aF5E0C3);

  ///The hover color is used to indicate when a pointer is hovering over a component or widget.
  final Color _hoverColor = const Color.fromRGBO(211, 207, 230, 1.0);

  final Color _lightPrimaryColor = const Color.fromRGBO(175, 169, 208, 1.0);
  final Color _lightSecondaryColor = const Color(0xFFB2EBF2);
  final Color _primaryColor = const Color.fromRGBO(90, 82, 158, 1.0);
  ///background color of major parts of the app like toolbars, tab bars, appbar,

  /// background color of the Scaffold widget
  final Color _scaffoldColor = Colors.white;

  final Color _secondaryColor = const Color(0xFFD9D7F1);
  /// The splash color is visible when we tap on ink. It is the color of ink splashes
  final Color _splashColor = const Color(0x1aF5E0C3);

  final Color _tabLabelColor = Colors.black;
  final TextStyle _tabSelectedLabelStyle =
      getAppTextTheme(textColor: Colors.black)
          .button!
          .copyWith(fontWeight: FontWeight.bold);

  final Color _tabUnselectedLabelColor = Colors.grey.shade700;
  final TextStyle _tabUnselectedLabelStyle =
      getAppTextTheme(textColor: Colors.grey.shade700).button!;

  getAppTheme() {
    return ThemeData(
      brightness: Brightness.light,
      visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),

      ///background color of major parts of the app like toolbars, tab bars, appbar,
      primaryColor: _primaryColor,
      primaryColorBrightness: Brightness.light,
      primaryColorLight: _lightPrimaryColor,
      primaryColorDark: _darkPrimaryColor,

      ///This is default color of MaterialType.canvas (Rectangle using default theme canvas color)
      canvasColor: _canvasColor,

      /// background color of the Scaffold widget
      scaffoldBackgroundColor: _scaffoldColor,

      /// Color of Bottom App Bar
      bottomAppBarColor: _bottomAppBarColor,

      ///color of Material when used as a Card i.e. default color for Card widget.
      cardColor: _cardColor,
      //color of Dividers and PopMenuDividers also used between ListTiles, between rows in DataTables and so forth
      dividerColor: _dividerColor,

      /// focus color used to indicate that a component has input focus.
      focusColor: _focusColor,

      ///The hover color is used to indicate when a pointer is hovering over a component or widget.
      hoverColor: _hoverColor,

      ///The highlight color is used to show if something is selected.
      ///The highlight color is used during ink splash animations or to indicate an item in a menu is selected.
      highlightColor: const Color(0xff936F3E),

      /// The splash color is visible when we tap on ink. It is the color of ink splashes
      splashColor: const Color(0xff457BE0),
      // splashFactory: # override create method from  InteractiveInkFeatureFactory
      ///The selectedRowColor is used to highlight selected rows.
      selectedRowColor: Colors.grey,

      ///The color used for widgets that are inactive (but enabled) state. For example, an unchecked checkbox.
      unselectedWidgetColor: Colors.grey.shade400,

      ///The color used for widgets that are inoperative and the user can’t interact with it regardless of its state
      ///For eg. it is the color of the disabled checkbox which may be checked or unchecked.
      disabledColor: Colors.grey.shade200,

      ///This provides default configurations of button widgets, like RaisedButton, FlatButton.
      ///We can provide a theme to all buttons through buttonTheme.
      // buttonTheme: ButtonThemeData(
      //   ///Default background color used by RaisedButtons. If not provided, the primarySwatch[600] is used
      //   buttonColor: _buttonColor,
      //   focusColor: _buttonFocusColor,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(
      //       Radius.circular(
      //         Dimens().getDefaultRadius,
      //       ),
      //     ),
      //   ),

      //   ///Color when the mouse passes over it
      //   hoverColor: _buttonHoverColor,

      //   ///Color to start filling the Buttons when pressed. Used in FlatButton, OutlineButton or RaisedButton.
      //   splashColor: _splashColor,
      //   disabledColor: _disabledButtonColor,

      //   /// Color used to fill the background when splash has ended.
      //   highlightColor: _buttonHighlightColor,

      //   /// Default minimum width.
      //   minWidth: Dimens().buttonHeight * 1.5,

      //   /// Default height.
      //   height: Dimens().buttonHeight,
      //   padding: EdgeInsets.all(
      //     Dimens().defaultButtonPadding,
      //   ),
      // ),

      ///This provides default configurations of ToggleButton widgets.
      ///We can provide a theme to all types of toggle buttons with toggleButtonsTheme
      toggleButtonsTheme: ToggleButtonsThemeData(
          color: _buttonColor,
          selectedColor: _buttonHoverColor,
          borderColor: Colors.black
          //toggle button theme
          ),

      ///This is the color of the header of a PaginatedDataTable when there are any selected rows
      secondaryHeaderColor: _primaryColor.withAlpha(180),

      ///This is a color that contrasts with the primary color. It is used to show the remaining parts of a progress bar.
      backgroundColor: const Color(0xff457BE0),

      ///This is the background color of dialog elements.
      dialogBackgroundColor: _lightPrimaryColor,

      ///This is an indicator color of a selected tab in the tab bar.
      indicatorColor: const Color(0xff457BE0),

      ///This is the color of hint texts or placeholder text color in TextFields.
      hintColor: Colors.grey,

      ///The color to use for input validation errors e.g. in TextField fields
      errorColor: Colors.red,

      ///This color is used to highlight the active states of toggleable widgets like Switch, Radio, and Checkbox.
      toggleableActiveColor: _lightSecondaryColor,

      ///Text with color that contrasts with the card and canvas colors.
      textTheme: getAppTextTheme(
        textColor: Colors.black,
      ),

      ///This is a text theme that contrasts with the primary color.
      primaryTextTheme: getAppTextTheme(
        textColor: _lightSecondaryColor,
      ),
      inputDecorationTheme: getInputDecorationTheme(),

      ///This is an icon theme that contrasts with the card and canvas colors.
      iconTheme: IconThemeData(color: _darkSecondaryColor),

      ///This is an icon theme that contrasts with the primary Color.
      primaryIconTheme: IconThemeData(color: _darkPrimaryColor),

      ///The colors and shapes used to render Slider. This value can be obtained by SliderTheme.of
      sliderTheme: const SliderThemeData(
          // slider themes
          ),

      ///A theme for customizing the size, shape and color of tab bar indicator
      tabBarTheme: TabBarTheme(
          labelColor: _tabLabelColor,
          unselectedLabelColor: _tabUnselectedLabelColor,
          labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          labelStyle: _tabSelectedLabelStyle,
          unselectedLabelStyle: _tabUnselectedLabelStyle,
          indicatorSize: TabBarIndicatorSize.tab),

      ///A theme for customizing the visual properties of Tooltips. This value can be obtained by TooltipTheme.of .
      tooltipTheme: const TooltipThemeData(
          // tool tip theme
          ),

      ///The colors and styles used to render Card. This value can be obtained by CardTheme.of
      cardTheme: const CardTheme(
          // card theme
          ),

      ///The colors and styles used to render Chips. This value can be obtained by ChipTheme.of .
      chipTheme: ChipThemeData(
          backgroundColor: _secondaryColor,
          disabledColor: _secondaryColor.withAlpha(
            20,
          ),
          shape: const StadiumBorder(),
          brightness: Brightness.light,
          labelPadding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          labelStyle: getAppTextTheme(textColor: Colors.black).bodyText2!,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          secondaryLabelStyle:
              getAppTextTheme(textColor: Colors.black).caption!,
          secondarySelectedColor: Colors.white38,
          selectedColor: Colors.white
          // chip theme
          ),

      ///The platform the material widgets should adapt to target.
      ///This should be used in order to style UI elements according to platform conventions.
      platform: TargetPlatform.iOS,

      ///This is used to configure hit test size of certain Material widgets
      materialTapTargetSize: MaterialTapTargetSize.padded,

      ///This is toggle for semi-transparent overlay color on Material surfaces that is used to indicate elevation for dark themes.
      ///If true then a semi-transaparent version of colorScheme.onSurface will be applied on top of color of Material widgets when their Material.color is colorScheme.surface.
      ///If false then the surface color will be used unmodified.
      applyElevationOverlayColor: true,

      ///Default MaterialPageRoute transition per TargetPlatform.
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: const ZoomPageTransitionsBuilder(),
        TargetPlatform.windows: const FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: const ZoomPageTransitionsBuilder(),
      }),

      ///This is a theme for customizing the color, elevation, brightness, iconTheme, and textTheme of AppBar.
      appBarTheme: getAppBarTheme().copyWith(
        backgroundColor: _primaryColor,
      ),

      ///A theme for customizing the shape, elevation, and color of a BottomAppBar.
      bottomAppBarTheme: const BottomAppBarTheme(
          // bottom app bar theme
          ),

      dialogTheme: const DialogTheme(
          // dialog theme
          ),

      ///A theme for customizing the shape, elevation, and color of FloatingActionButton.
      // floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //     // floating action button theme
      //     ),

      ///A theme for customizing the background color, elevation, textStyles, and iconThemes of a NavigationRail.
      navigationRailTheme: NavigationRailThemeData(
        selectedIconTheme: const IconThemeData(
          color: Colors.yellow,
          size: 25,
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey.shade200,
          size: 20,
        ),
        backgroundColor: _primaryColor,
        unselectedLabelTextStyle:
            getAppTextTheme(textColor: _secondaryColor).bodyText1?.copyWith(
                  fontSize: 12,
                ),
        selectedLabelTextStyle:
            getAppTextTheme(textColor: Colors.yellow).bodyText1?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  decorationColor: Colors.yellow,
                  decoration: TextDecoration.overline,
                  decorationStyle: TextDecorationStyle.wavy,
                ),
        labelType: NavigationRailLabelType.all,
      ),

      ///The color and geometry TextTheme values used to configure textTheme, primaryTextTheme and accentTextTheme.
      typography: Typography.material2018(),
      cupertinoOverrideTheme: const CupertinoThemeData(
          //cupertino theme
          ),
      bottomSheetTheme: const BottomSheetThemeData(
          //bottom sheet theme
          ),
      bannerTheme: const MaterialBannerThemeData(
          // material banner theme
          ),
      dividerTheme: const DividerThemeData(
          //divider, vertical divider theme
          ),
      buttonBarTheme: const ButtonBarThemeData(
          // button bar theme
          ),
      // fontFamily: 'ROBOTO',
      splashFactory: InkSplash.splashFactory,
    );
  }
}
