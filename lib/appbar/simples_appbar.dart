import 'package:flutter/material.dart';

class SimplesAppbar extends StatefulWidget implements PreferredSizeWidget {
  const SimplesAppbar({super.key});

  @override
  State<SimplesAppbar> createState() => _HistoriaAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HistoriaAppbarState extends State<SimplesAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
