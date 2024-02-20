import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';


class TourScrollElement extends StatefulWidget {
  const TourScrollElement({
    super.key,
    required this.tour, this.imageIcon = Icons.photo_camera,
  });

  final Tour tour;
  final IconData imageIcon;

  @override
  State<TourScrollElement> createState() => _TourScrollElementState();
}

class _TourScrollElementState extends State<TourScrollElement> {

  void _tapLike() {
    widget.tour.isLiked = !widget.tour.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //size: const Size(150, 248),
      //padding: const EdgeInsets.all(5),
      height: 248,
      width: 150,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/tour_details',
            arguments: widget.tour,
          );
          },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 3,
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(75),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(widget.tour.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey,
                              alignment: Alignment.center,
                              child: Icon(widget.imageIcon, size: 50,),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(
                              widget.tour.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 24,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _tapLike();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6,),
              Expanded(
                flex: 2,
                child: Column(
                  //padding: const EdgeInsets.only(top: 6),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        widget.tour.kinds[0],
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        widget.tour.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ]
         ),
      ),
    );
  }
}