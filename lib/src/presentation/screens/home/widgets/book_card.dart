import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/constants/routes.dart';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/common/widgets/separator_widget.dart';
import 'package:books_app/src/common/widgets/typography.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/presentation/screens/book_detail/book_detail_screen.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.resultIndex});
  final Result resultIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.bookDetailScreen, arguments: BookDetailArguments(id: resultIndex.id.toString()));
      },
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
                    child: Image.network(
                      resultIndex.formats?.imageJpeg ?? '',
                      fit: BoxFit.cover,
                      opacity: const AlwaysStoppedAnimation(.2),
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                            child: Icon(
                          Icons.image,
                          size: 60,
                          color: ConstColors.gray,
                        ));
                      },
                    ),
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.network(
                    resultIndex.formats?.imageJpeg ?? '',
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox();
                    },
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Log.info('Book Liked');
                      },
                      child: const Icon(
                        Icons.favorite_border,
                        size: 25,
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
              "Author : ${(resultIndex.authors ?? [])[0].name} (${(resultIndex.authors ?? [])[0].birthYear} - ${(resultIndex.authors ?? [])[0].deathYear})",
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
