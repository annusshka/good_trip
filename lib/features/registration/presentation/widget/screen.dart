import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.pink_,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height / 2 * 0.2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', scale: 1,),
          const SizedBox(height: 20,),
          Text('Good Trip',
            style: TextStyle(
              fontSize: MediaQuery.sizeOf(context).width * 0.15,
              fontWeight: FontWeight.w600,
              color: colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
