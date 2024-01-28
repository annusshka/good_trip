import 'package:flutter/material.dart';
import '../../data/models/models.dart';

class Geolocation extends StatefulWidget {
  final Weather weather;
  const Geolocation({super.key, required this.weather});

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
        Text(widget.weather.cityName,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Row(
          children: [
            SizedBox.fromSize(
              size: const Size.square(24),
              child: Image.network(
                "http://openweathermap.org/img/wn/${widget.weather.iconCode}@2x.png",
                scale: 2,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/temperature_512.png',
                    color: const Color.fromARGB(100, 105, 105, 116),);
                  },
              ),
            ),
            Text('${widget.weather.temperature.toString()}°C',
              style: Theme.of(context).textTheme.bodySmall,),
          ],
        ),
      ],
    );
  }
}
