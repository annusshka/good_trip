import 'package:flutter/material.dart';

import '../../../../core/domain/models/models.dart';

class ProfileInfo extends StatelessWidget {
  final User user;
  const ProfileInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(user.fullName(),
        style: Theme.of(context).textTheme.bodyLarge,),
      subtitle: Text(user.role.displayTitle,
        style: Theme.of(context).textTheme.bodyMedium,),
    );
    /*
      Row(
      children: [
        SizedBox.fromSize(
          size: const Size.fromRadius(32),
            child: ClipRRect(
            borderRadius: BorderRadius.circular(16), // Image border
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(account.image != null
                    ? account.image as String
                    : '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: const Icon(Icons.camera_alt, size: 50,),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('${user.name} ${user.surname}',
              style: Theme.of(context).textTheme.bodyLarge,),
            subtitle: Text(user.role == AccessLevel.admin
                ? 'Администратор' : 'Экскурсант',
              style: Theme.of(context).textTheme.bodyMedium,),
          ),
        ),
      ],
    );*/
  }
}
