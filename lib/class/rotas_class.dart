import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage transicaoPaginas<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: child,
    ),
  );
}

enum RouteEnum {
  BUSCAR('/buscar'),
  EDITAR_PERFIL('/editar_perfil'),
  ENTRAR('/entrar'),
  INICIO('/inicio'),
  HISTORIA('/historia'),
  PERFIL('/perfil');

  final String value;
  const RouteEnum(this.value);
}



  // ABOUT('/about'),
  // ACTIVITY('/actvities'),
  // BIOGRAPHY('/biography'),
  // BLOCKEDS('/blockeds'),
  // CODE('/code'),
  // CREATE('/create'),
  // DELETE_ACCOUNT('/delete_account'),
  // DENOUNCE('/denounce'),
  // FORGOT_PASSWORD('/forgot_password'),
  // JUSTIFY('/justify'),
  // HISTORY('/history'),
  // HOME('/home'),
  // LOADING('/loading'),
  // LOGIN('/login'),
  // NAME('/name'),
  // NOTIFICATION('/notification'),
  // QUESTIONS('/questions'),
  // PASSWORD('/password'),
  // PERFIL('/perfil'),
  // PRIVACY('/privacy'),
  // REGISTER('/register'),
  // SETTINGS('/settings'),
  // TERMS('/terms');

