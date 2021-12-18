enum AuthenticatedUserRoles {
  ROLE_SUPPLY,
  ROLE_DEO,
  ROLE_SUPVR,
  ROLE_GD,
  ROLE_MANAGER,
}

extension AuthenticatedUserRolesValues on AuthenticatedUserRoles {
  int get getStatusCode {
    switch (this) {
      case AuthenticatedUserRoles.ROLE_DEO:
        return AuthenticatedUserRoles.ROLE_DEO.index + 1;

      case AuthenticatedUserRoles.ROLE_SUPPLY:
        return AuthenticatedUserRoles.ROLE_SUPPLY.index + 1;

      case AuthenticatedUserRoles.ROLE_SUPVR:
        return AuthenticatedUserRoles.ROLE_SUPVR.index + 1;
      case AuthenticatedUserRoles.ROLE_GD:
        return AuthenticatedUserRoles.ROLE_GD.index + 1;
      case AuthenticatedUserRoles.ROLE_MANAGER:
        return AuthenticatedUserRoles.ROLE_MANAGER.index + 1;

      default:
        return -1;
    }
  }
}

extension AuthenticatedUserRolesValue on AuthenticatedUserRoles {
  String get getStatusString {
    switch (this) {
      case AuthenticatedUserRoles.ROLE_DEO:
        return 'ROLE_DEO';

      case AuthenticatedUserRoles.ROLE_SUPPLY:
        return 'ROLE_SUPPLY';

      case AuthenticatedUserRoles.ROLE_SUPVR:
        return 'ROLE_SUPVR';

      case AuthenticatedUserRoles.ROLE_GD:
        return 'ROLE_GD';

      case AuthenticatedUserRoles.ROLE_MANAGER:
        return 'ROLE_MANAGER';

      default:
        return 'UNKNOWN';
    }
  }
}
