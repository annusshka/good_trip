import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/strings.dart';

import '../../theme/theme.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          scale: 1,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          goodTrip,
          style: TextStyle(
            fontSize: MediaQuery.sizeOf(context).width * 0.15,
            fontWeight: FontWeight.w600,
            color: colors.white,
          ),
        ),
      ],
    );
    /*
      Container(
        color: colors.pink_,
        alignment: Alignment.center,
        padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', scale: 1,),
            const SizedBox(height: 20,),
            Text(goodTrip,
              style: TextStyle(
                fontSize: MediaQuery.sizeOf(context).width * 0.15,
                fontWeight: FontWeight.w600,
                color: colors.white,
              ),
            ),
          ],
        ),
    );*/
  }
}
