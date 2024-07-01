import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/presentation/widgets/separator_widget.dart';
import 'package:books_app/src/presentation/widgets/typography.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard(
      {super.key,
      required this.resultIndex,
      required this.isLiked,
      required this.onTapLikeUpdate,
      required this.onTap});
  final Result resultIndex;
  final bool isLiked;
  final Function() onTapLikeUpdate;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(
          color: ConstColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      filterQuality: FilterQuality.low,
                      imageUrl: resultIndex.formats?.imageJpeg ?? '',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return const SizedBox();
                      },
                      imageBuilder: (context, imageProvider) {
                        return Image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            opacity: const AlwaysStoppedAnimation(.2),
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Icon(
                                Icons.image,
                                size: 60,
                                color: ConstColors.gray,
                              ));
                            });
                      },
                    ),
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: CachedNetworkImage(
                    filterQuality: FilterQuality.low,
                    imageUrl: resultIndex.formats?.imageJpeg ?? '',
                    errorWidget: (context, url, error) {
                      return const Center(
                          child: Icon(
                        Icons.image,
                        size: 60,
                        color: ConstColors.gray,
                      ));
                    },
                    imageBuilder: (context, imageProvider) {
                      return Image(
                          image: imageProvider,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Icon(
                              Icons.image,
                              size: 60,
                              color: ConstColors.gray,
                            ));
                          });
                    },
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: onTapLikeUpdate,
                      child: Icon(
                        isLiked == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 40,
                        color: isLiked == true
                            ? ConstColors.red
                            : ConstColors.gray,
                      )),
                )
              ],
            )),
            SeparatorWidget.height4(),
            BodyText.smallBold(
              resultIndex.title ?? '',
              overflow: TextOverflow.ellipsis,
            ),
            SeparatorWidget.height2(),
            BodyText.xSmall(
              (resultIndex.authors ?? []).isEmpty
                  ? 'Author : Unknown'
                  : "Author : ${(resultIndex.authors ?? [])[0].name} (${(resultIndex.authors ?? [])[0].birthYear} - ${(resultIndex.authors ?? [])[0].deathYear})",
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
