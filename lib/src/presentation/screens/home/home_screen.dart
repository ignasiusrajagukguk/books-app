import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/common/widgets/separator_widget.dart';
import 'package:books_app/src/common/widgets/text_form_field.dart';
import 'package:books_app/src/common/widgets/typography.dart';
import 'package:books_app/src/data/models/books_list_model/books_list_model.dart';
import 'package:books_app/src/data/models/books_list_model/result.dart';
import 'package:books_app/src/presentation/screens/home/bloc/home_bloc.dart';
import 'package:books_app/src/presentation/screens/home/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen();

  @override
  State<_HomeScreen> createState() => __HomeScreenState();
}

class __HomeScreenState extends State<_HomeScreen> {
  final TextEditingController searchC = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _fetchData(1);
  }

  @override
  void dispose() {
    super.dispose();
    searchC.dispose();
    focusNode.dispose();
  }

  _fetchData(int page, {String? keywords}) {
    context.read<HomeBloc>().add(GetBooksList(page: page, keywords: keywords));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 0,
          backgroundColor: ConstColors.grayBasic,
          title: const Center(
              child: Heading.h3Large(
            'Books App',
            color: ConstColors.lightBlue,
          )),
          elevation: 0,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              (state.requestState == RequestState.loading)
                  ? HomeShimmer.listShimmer()
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      padding: const EdgeInsets.fromLTRB(15, 75, 15, 0),
                      itemCount: (state.booksListModel.results ?? []).length,
                      itemBuilder: (context, index) {
                        BooksListModel booksListModel = state.booksListModel;
                        List<Result> listResult = booksListModel.results ?? [];
                        Result resultIndex = listResult[index];
                        return Container(
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
                                        opacity:
                                            const AlwaysStoppedAnimation(.2),
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                      errorBuilder:
                                          (context, error, stackTrace) {
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
                        );
                      },
                    ),
              Container(
                padding: const EdgeInsets.all(15),
                color: ConstColors.grayBasic.withOpacity(.8),
                child: TextFormFieldWidget.search(
                  'Search books..',
                  controller: searchC,
                  focusNode: focusNode,
                  backgroundColor: ConstColors.white.withOpacity(.8),
                  onEditingComplete: () {
                    _fetchData(1, keywords: searchC.text);
                    focusNode.unfocus();
                  },
                ),
              ),
            ],
          );
        }));
  }
}
