import 'package:books_app/src/common/constants/asset_path.dart';
import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/constants/empty_widget.dart';
import 'package:books_app/src/common/constants/routes.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/presentation/widgets/text_form_field.dart';
import 'package:books_app/src/presentation/widgets/typography.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/presentation/screens/book_detail/book_detail_screen.dart';
import 'package:books_app/src/presentation/screens/home/bloc/home_bloc.dart';
import 'package:books_app/src/presentation/screens/home/widgets/book_card.dart';
import 'package:books_app/src/presentation/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getIt<HomeBloc>(),
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
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _fetchData();
    _getlikedBooks();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    searchC.dispose();
    focusNode.dispose();
    scrollController
      ..removeListener(_scrollListener)
      ..dispose();
  }

  _fetchData({
    String? keywords,
  }) {
    context.read<HomeBloc>().add(GetBooksList(keywords: keywords));
  }

  _getlikedBooks() {
    context.read<HomeBloc>().add(const HomeLikedBooks());
  }

  _updateLikedBooks(Result result) {
    context.read<HomeBloc>().add(UpdateLikedBooks(book: result));
  }

  _resetPageIndex() {
    context.read<HomeBloc>().add(const ResetPageIndex());
  }

  _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      var state = context.read<HomeBloc>().state;
      if (state.booksListModel.next != null) {
        _fetchData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 130,
          automaticallyImplyLeading: false,
          leadingWidth: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: _topWidget(),
          bottomOpacity: 0,
        ),
        extendBodyBehindAppBar: true,
        body: _bodyWidget());
  }

  Widget _bodyWidget() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      switch (state.requestState) {
        case RequestState.loading:
          return ShimmerWidgets.listShimmer();
        case RequestState.success:
          return GridView.builder(
              controller: scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              padding: const EdgeInsets.fromLTRB(15, 200, 15, 0),
              itemCount: state.booksListModel.next != null
                  ? state.currentBooks.length + 2
                  : state.currentBooks.length,
              itemBuilder: (context, index) {
                List<Result> listResult = state.currentBooks;
                if (index >= state.currentBooks.length) {
                  return ShimmerWidgets.singleCard();
                }
                List<Result> likedBooks = state.likedBooks;
                Result resultIndex = listResult[index];
                return BookCard(
                  onTapLikeUpdate: () {
                    setState(() {
                      _updateLikedBooks(resultIndex);
                    });
                  },
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Routes.bookDetailScreen,
                            arguments: BookDetailArguments(
                              result: resultIndex,
                            ))
                        .then((value) => _getlikedBooks());
                  },
                  resultIndex: resultIndex,
                  isLiked: likedBooks
                      .map((item) => item.id)
                      .contains(resultIndex.id),
                );
              });
        default:
          return const EmptyWidget();
      }
    });
  }

  Widget _topWidget() {
    return FlexibleSpaceBar(
      titlePadding: const EdgeInsets.all(0),
      title: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 160,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 0),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: <Color>[ConstColors.lightBlue, ConstColors.green]),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Heading.h3Large(
                          'Books App',
                          color: ConstColors.white,
                        ),
                        BodyText.small(
                          '"Book is a window to\nthe world"',
                          color: ConstColors.white,
                        ),
                      ],
                    ),
                    Image.asset(
                      ImagePath.home.person,
                      height: 40,
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormFieldWidget.search(
              'Search',
              controller: searchC,
              focusNode: focusNode,
              backgroundColor: ConstColors.white,
              onChanged: (value) {
                if (value == '') {
                  _resetPageIndex();
                  _fetchData(keywords: searchC.text);
                }
              },
              onEditingComplete: () {
                _resetPageIndex();
                _fetchData(keywords: searchC.text);
                focusNode.unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
