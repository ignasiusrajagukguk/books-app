import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/widgets/text_form_field.dart';
import 'package:books_app/src/common/widgets/typography.dart';
import 'package:books_app/src/data/models/books_list_model.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/presentation/screens/home/bloc/home_bloc.dart';
import 'package:books_app/src/presentation/screens/home/widgets/book_card.dart';
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
                        return BookCard(resultIndex: resultIndex);
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
