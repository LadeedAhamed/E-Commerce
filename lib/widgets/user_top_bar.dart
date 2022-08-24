import 'package:flutter/material.dart';

class UserTopBar extends StatelessWidget {
  final IconButton leadingIconButton;
  const UserTopBar({super.key, required this.leadingIconButton});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leadingIconButton,
        const Spacer(),
        IconButton(onPressed: (){}, icon: const Icon(Icons.menu)),
        IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_bag)),
      ],
    );
  }
}