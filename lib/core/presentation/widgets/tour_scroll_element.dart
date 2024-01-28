import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';


class TourScrollElement extends StatefulWidget {
  const TourScrollElement({
    super.key,
    required this.tour, required this.icon,
  });

  final Tour tour;
  final IconData icon;

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
      width: 150,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/event',
              arguments: widget.tour,
            );
          },
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
              SizedBox.fromSize(
                size: const Size.fromRadius(75),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(widget.tour.image as String,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            alignment: Alignment.center,
                            child: Icon(widget.icon, size: 50,),
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
                      )
                    ],
                  ),
                ),
              ),
               const SizedBox(height: 6,),
               Expanded(
                   child: Column(
                     //padding: const EdgeInsets.all(6),
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         widget.tour.kinds[0],
                         style: Theme.of(context).textTheme.labelSmall,
                       ),
                       Expanded(
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