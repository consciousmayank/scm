enum AppThemesType {
  PRIMARY_THEME,
  SUPPLY_THEME,
  DEMAND_THEME,
}

extension AppThemesTypeValues on AppThemesType {
  int get getValueIndex {
    switch (this) {
      case AppThemesType.PRIMARY_THEME:
        return AppThemesType.PRIMARY_THEME.index;
      case AppThemesType.SUPPLY_THEME:
        return AppThemesType.SUPPLY_THEME.index;
      case AppThemesType.DEMAND_THEME:
        return AppThemesType.DEMAND_THEME.index;

      default:
        return 0;
    }
  }
}
