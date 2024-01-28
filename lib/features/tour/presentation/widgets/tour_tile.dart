import 'package:flutter/material.dart';

class TourTile extends StatelessWidget {
  const TourTile({super.key,
    required this.titleText, required this.subtitleText, required this.icon});

  final String titleText;
  final String subtitleText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 40),
      leading: Icon(
        icon,
        color: Colors.black, size: 24,
      ),
      title: Text(titleText,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(subtitleText,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
