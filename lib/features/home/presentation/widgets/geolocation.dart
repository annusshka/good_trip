import 'package:flutter/material.dart';

import '../../../../core/domain/models/models.dart';
import '../../../../core/theme/theme.dart';

class Geolocation extends StatefulWidget {
  final LocationInfo locationInfo;
  const Geolocation({super.key, required this.locationInfo});

  @override
  State<Geolocation> createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.locationInfo.cityName,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Row(
          children: [
            SizedBox.fromSize(
              size: const Size.square(24),
              child: Image.network(
                "http://openweathermap.org/img/wn/${widget.locationInfo.weatherIconCode}@2x.png",
                scale: 2,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/temperature_512.png',
                    color: colors.gray,);
                  },
              ),
            ),
            Text('${widget.locationInfo.temperature.toString()}°C',
              style: Theme.of(context).textTheme.bodySmall,),
          ],
        ),
      ],
    );
  }
}
