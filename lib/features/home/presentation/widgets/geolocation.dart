import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
        Text(
          widget.locationInfo.cityName,
          style: AppTextTheme.semiBold20,
        ),
        Row(
          children: [
            SizedBox.fromSize(
              size: const Size.square(24),
              child: Image.network(
                'http://openweathermap.org/img/wn/${widget.locationInfo.weatherIconCode}@2x.png',
                scale: 2,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/temperature_512.png',
                    color: AppColors.gray,
                  );
                },
              ),
            ),
            if (widget.locationInfo.temperature != null)
              Text(
                '${widget.locationInfo.temperature.toString()}°C',
                style: AppTextTheme.semiBold16.copyWith(
                  color: AppColors.darkGray,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class GeolocationLoading extends StatelessWidget {
  const GeolocationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
            width: 100,
            child: Text(
              'Текущий Город',
              style: AppTextTheme.semiBold20,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Bone.circle(size: 20,),
              const SizedBox(width: 5.0,),
              SizedBox(
                height: 20,
                width: 50,
                child: Text(
                  '15°C',
                  style: AppTextTheme.semiBold16.copyWith(
                    color: AppColors.darkGray,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

