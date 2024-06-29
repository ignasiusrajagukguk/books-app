import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/constants/empty_widget.dart';
import 'package:books_app/src/common/constants/routes.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/widgets/shimmer.dart';
import 'package:books_app/src/common/widgets/typography.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/presentation/screens/book_detail/book_detail_screen.dart';
import 'package:books_app/src/presentation/screens/home/widgets/book_card.dart';
import 'package:books_app/src/presentation/screens/liked/bloc/liked_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikedBloc(),
      child: const _LikedScreen(),
    );
  }
}

class _LikedScreen extends StatefulWidget {
  const _LikedScreen();

  @override
  State<_LikedScreen> createState() => __LikedScreenState();
}

class __LikedScreenState extends State<_LikedScreen> {
  @override
  void initState() {
    super.initState();
    _getlikedBooks();
  }

  _getlikedBooks() {
    context.read<LikedBloc>().add(const GetLikedBooks());
  }

  _updateLikedBooks(Result result) {
    context.read<LikedBloc>().add(UpdateLikedBooks(book: result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.grayBasic,
      appBar: AppBar(
        backgroundColor: ConstColors.lightBlue,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        leading: const SizedBox(),
        title: const Center(
          child: Heading.h4Bold(
            'Liked Books',
            color: ConstColors.white,
          ),
        ),
      ),
      body: _bodyWidget(),
    );
  }

  _bodyWidget() {
    return BlocBuilder<LikedBloc, LikedState>(builder: (context, state) {
      switch (state.requestState) {
        case RequestState.loading:
          return ShimmerWidgets.listShimmer(padding: const EdgeInsets.all(15));
        case RequestState.success:
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            padding: const EdgeInsets.all(15),
            itemCount: state.likedBooks.length,
            itemBuilder: (context, index) {
              List<Result> listResult = state.likedBooks;
              Result resultIndex = listResult[index];
              return BookCard(
                onTapLikeUpdate: () => _updateLikedBooks(resultIndex),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(Routes.bookDetailScreen,
                          arguments: BookDetailArguments(
                            result: resultIndex,
                          ))
                      .then((value) => _getlikedBooks());
                },
                resultIndex: resultIndex,
                isLiked: true,
              );
            },
          );
        default:
          return const EmptyWidget();
      }
    });
  }
}
