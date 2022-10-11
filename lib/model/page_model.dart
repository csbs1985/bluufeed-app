enum PageEnum {
  ABOUT('/about'),
  ACTIVITY('/actvities'),
  BIOGRAPHY('biography'),
  BLOCKEDS('blockeds'),
  CODE('/code'),
  CREATE('/create'),
  DENOUNCE('/denounce'),
  DELETE_ACCOUNT('/delete_account'),
  FORGOT_PASSWORD('/forgot_password'),
  JUSTIFY('/justify'),
  HISTORY('/history'),
  HOME('/home'),
  LOGIN('/login'),
  NAME('/name'),
  NOTIFICATION('/notification'),
  QUESTIONS('/questions'),
  PASSWORD('/password'),
  PASSWORD_CREATE('/password_create'),
  PASSWORD_EDIT('/password_edit'),
  PERFIL('/perfil'),
  PRIVACY('/privacy'),
  REGISTER('/register'),
  SETTINGS('/settings'),
  TERMS('/terms');

  final String value;
  const PageEnum(this.value);
}
