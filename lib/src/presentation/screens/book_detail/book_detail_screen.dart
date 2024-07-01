import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/presentation/widgets/separator_widget.dart';
import 'package:books_app/src/presentation/widgets/shimmer.dart';
import 'package:books_app/src/presentation/widgets/typography.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/presentation/screens/book_detail/bloc/book_detail_bloc.dart';
import 'package:books_app/src/presentation/screens/book_detail/widgets/button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

final _getIt = GetIt.instance;
class BookDetailArguments {
  final Result result;

  BookDetailArguments({required this.result});
}

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key, required this.arguments});
  final BookDetailArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getIt<BookDetailBloc>(),
      child: _BookDetailScreen(
        result: arguments.result,
      ),
    );
  }
}

class _BookDetailScreen extends StatefulWidget {
  const _BookDetailScreen({required this.result});
  final Result result;

  @override
  State<_BookDetailScreen> createState() => __BookDetailScreenState();
}

class __BookDetailScreenState extends State<_BookDetailScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
    _getlikedBooks();
  }

  _fetchData() {
    context
        .read<BookDetailBloc>()
        .add(GetBookDetail(id: widget.result.id.toString()));
  }

  _getlikedBooks() {
    context.read<BookDetailBloc>().add(const LikedBookDetail());
  }

  _updateLikedBooks() {
    context
        .read<BookDetailBloc>()
        .add(UpdateLikedBookDetail(book: widget.result));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: ConstColors.grayBasic,
        appBar: AppBar(
          backgroundColor: ConstColors.lightBlue,
          centerTitle: true,
          elevation: 0,
          leadingWidth: 60,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ConstColors.white,
            ),
          ),
          actions: const [
            SizedBox(
              width: 60,
            )
          ],
          title: const Center(
            child: Heading.h4Bold(
              'Book Detail',
              color: ConstColors.white,
            ),
          ),
        ),
        body: bodyWidget(state),
      );
    });
  }

  Widget bodyWidget(BookDetailState state) {
    Result result = state.bookDetailModel;
    switch (state.requestState) {
      case RequestState.loading:
        return ShimmerWidgets.detailShimmer(context);
      case RequestState.success:
        return detailWidget(result, state);
      default:
        return detailWidget(widget.result, state);
    }
  }

  Widget detailWidget(Result result, BookDetailState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 280,
                child: CachedNetworkImage(
                  filterQuality: FilterQuality.low,
                  imageUrl: result.formats?.imageJpeg ?? '',
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
            CachedNetworkImage(
              height: 260,
              width: 200,
              filterQuality: FilterQuality.low,
              imageUrl: result.formats?.imageJpeg ?? '',
              errorWidget: (context, url, error) {
                return const Center(
                    child: Icon(
                  Icons.image,
                  size: 100,
                ));
              },
              imageBuilder: (context, imageProvider) {
                return Image(
                    image: imageProvider,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                          child: Icon(
                        Icons.image,
                        size: 100,
                      ));
                    });
              },
            ),
          ],
        ),
        SeparatorWidget.height16(),
        Row(
          children: [
            Expanded(child: Heading.h5Small(result.title ?? '')),
            SeparatorWidget.width8(),
            GestureDetector(
                onTap: () {
                  _updateLikedBooks();
                },
                child: Icon(state.likedBooks
                          .map((item) => item.id)
                          .contains(widget.result.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 40,
                  color: state.likedBooks
                          .map((item) => item.id)
                          .contains(widget.result.id)
                      ? ConstColors.red:ConstColors.gray,
                ))
          ],
        ),
        SeparatorWidget.height10(),
        const BodyText.dflt('Author :'),
        SeparatorWidget.height8(),
        ...(result.authors ?? []).map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: BodyText.large(
              '${e.name} (${e.birthYear} - ${e.deathYear})',
              color: ConstColors.gray,
            ),
          ),
        ),
        SeparatorWidget.height16(),
        const BodyText.dflt("Downlad Count :"),
        SeparatorWidget.height8(),
        BodyText.largeBold(result.downloadCount.toString()),
        SeparatorWidget.height16(),
        const BodyText.dflt(
          'Subjects :',
          color: ConstColors.gray,
        ),
        SeparatorWidget.height10(),
        Wrap(
          children: [
            ...(result.subjects ?? []).map((e) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                  decoration: BoxDecoration(
                      color: ConstColors.lightBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: BodyText.dfltBold(
                    e,
                    color: ConstColors.white,
                  ),
                ))
          ],
        ),
        SeparatorWidget.height10(),
        Row(
          children: [
            Expanded(
              child: ButtonWidget.defaultButton(context, title: 'Download ePub',
                  onPressed: () {
                _launchUrl(result.formats?.applicationEpubZip ?? '');
              }),
            ),
            SeparatorWidget.width10(),
            Expanded(
              child: ButtonWidget.defaultButton(context, title: 'Read Book',
                  onPressed: () {
                _launchUrl(result.formats?.textHtml ?? '');
              }),
            )
          ],
        )
      ]),
    );
  }

  _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
