import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../res/app_default.dart';
import '../animations/loading_widget.dart';
import '../animations/nullable_hero.dart';

class SUserAvatar extends StatelessWidget {
  SUserAvatar(
      {super.key, this.size = 50.0, this.url, this.heroTag, this.onTap});

  final double size;
  final String? url;
  final String? heroTag;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: FittedBox(
        child: SizedBox(
          width: size,
          height: size,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: url != null
                ? NullHero(
                    tag: heroTag,
                    child: CachedNetworkImage(
                      imageUrl: url!,
                      placeholder: (context, url) => LoadingWidget(
                        size: size / 4,
                      ),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: url != ""
                            ? imageProvider
                            : Image.asset(SResourses.userDefaultPhoto).image,
                      ),
                    ),
                  )
                : NullHero(
                    tag: heroTag,
                    child: CircleAvatar(
                      backgroundImage:
                          Image.asset(SResourses.userDefaultPhoto).image,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class SUserAvatarAppbar extends StatelessWidget {
  const SUserAvatarAppbar({
    super.key,
    required this.url,
    this.onTap,
  });

  final String url;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SUserAvatar(
      url: url,
      size: 48.0,
      heroTag: SResourses.userAvatarHero,
      onTap: onTap,
    );
  }
}
