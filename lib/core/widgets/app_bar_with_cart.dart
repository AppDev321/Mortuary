import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onCartPressed;

  const CartAppBar({super.key, 
    required this.title,
    required this.onCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: onCartPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
