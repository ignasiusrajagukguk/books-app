import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/constants/empty_widget.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/widgets/separator_widget.dart';
import 'package:books_app/src/common/widgets/typography.dart';
import 'package:books_app/src/data/models/book_detail_model.dart';
import 'package:books_app/src/presentation/screens/book_detail/bloc/book_detail_bloc.dart';
import 'package:books_app/src/presentation/screens/book_detail/widgets/button.dart';
import 'package:books_app/src/presentation/screens/book_detail/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailArguments {
  String id;

  BookDetailArguments({required this.id});
}

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key, required this.arguments});
  final BookDetailArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookDetailBloc(),
      child: _BookDetailScreen(
        id: arguments.id,
      ),
    );
  }
}

class _BookDetailScreen extends StatefulWidget {
  const _BookDetailScreen({required this.id});
  final String id;

  @override
  State<_BookDetailScreen> createState() => __BookDetailScreenState();
}

class __BookDetailScreenState extends State<_BookDetailScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData(widget.id);
  }

  _fetchData(String id) {
    context.read<BookDetailBloc>().add(GetBookDetail(id: id));
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
    BookDetailModel bookDetailModel = state.bookDetailModel;
    switch (state.requestState) {
      case RequestState.loading:
        return BookDetailShimmer.loadingShimmer(context);
      case RequestState.success:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    bookDetailModel.formats?.imageJpeg ?? '',
                    width: MediaQuery.of(context).size.width,
                    height: 280,
                    opacity: const AlwaysStoppedAnimation(.2),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 280,
                      );
                    },
                  ),
                ),
                Image.network(
                  bookDetailModel.formats?.imageJpeg ?? '',
                  height: 260,
                  width: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                        child: Icon(
                      Icons.image,
                      size: 100,
                    ));
                  },
                ),
              ],
            ),
            SeparatorWidget.height16(),
            Heading.h5Small(bookDetailModel.title ?? ''),
            SeparatorWidget.height10(),
            const BodyText.dflt('Author :'),
            SeparatorWidget.height8(),
            ...(bookDetailModel.authors ?? []).map(
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
            BodyText.largeBold(bookDetailModel.downloadCount.toString()),
            SeparatorWidget.height16(),
            const BodyText.dflt(
              'Subjects :',
              color: ConstColors.gray,
            ),
            SeparatorWidget.height10(),
            Wrap(
              children: [
                ...(bookDetailModel.subjects ?? []).map((e) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
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
                  child: ButtonWidget.defaultButton(context,
                      title: 'Download ePub', onPressed: () {
                    _launchUrl(
                        bookDetailModel.formats?.applicationEpubZip ?? '');
                  }),
                ),
                SeparatorWidget.width10(),
                Expanded(
                  child: ButtonWidget.defaultButton(context, title: 'Read Book',
                      onPressed: () {
                    _launchUrl(bookDetailModel.formats?.textHtml ?? '');
                  }),
                )
              ],
            )
          ]),
        );
      default:
        return const EmptyWidget();
    }
  }

  _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
