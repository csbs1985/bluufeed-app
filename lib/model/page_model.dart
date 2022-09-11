enum PageEnum {
  ABOUT('/about'),
  ACTIVITES('/actvities'),
  CODE('/code'),
  CREATE('/create'),
  DENOUNCE('/denounce'),
  DELETE_ACCOUNT('/delete_account'),
  FORGOT_PASSWORD('/FORGOT_PASSWORD'),
  JUSTIFY('/justify'),
  HISTORY('/history/:id'),
  HOME('/home'),
  LOGIN('/login'),
  NAME('/name'),
  NOTIFICATION('/notification'),
  QUESTIONS('/questions'),
  PRIVACY('/privacy'),
  REGISTER('/register'),
  SETTINGS('/settings'),
  TERMS('/terms');

  final String value;
  const PageEnum(this.value);
}
