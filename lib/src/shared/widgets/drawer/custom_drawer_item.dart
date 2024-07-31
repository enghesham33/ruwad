import 'package:flutter/material.dart';
import '../../themes/palette.dart';

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({super.key, required this.icon, required this.title, required this.action});

  final IconData icon;
  final String title;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Icon(icon, color: Palette.accentColor, size: 32),
            // Icon(icon, color: Palette.white, size: 32),
            const SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
               textAlign: TextAlign.center,
               // style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Palette.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
