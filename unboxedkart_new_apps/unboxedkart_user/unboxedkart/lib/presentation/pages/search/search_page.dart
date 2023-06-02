import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/logic/search_page/search_bloc.dart';
import 'package:unboxedkart/presentation/models/search_term/search_term.dart';
import 'package:unboxedkart/presentation/pages/search/search_bar.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

class SearchPage extends StatefulWidget {
  bool enableBack;

  SearchPage({Key key, this.enableBack = true}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  final LocalRepository _localRepo = LocalRepository();
  bool searchTermIsNull = true;
  bool isAuthenticated = false;

  getAuthStatus() async {
    isAuthenticated = await _localRepo.getAuthStatus();
  }

  @override
  initState() {
    super.initState();
    getAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    buildAppBar() {
      return AppBar(
        elevation: 0,
        backgroundColor: CustomColors.blue,
        leadingWidth: widget.enableBack ? 25 : 0,
        leading: widget.enableBack
            ? GestureDetector(
                child: const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.arrow_back,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            : const SizedBox(),
        title: const SearchBar(
          searchTerm: "hello",
        ),
      );
    }

    return Scaffold(
        backgroundColor: CustomColors.backgroundGrey,
        appBar: buildAppBar(),
        body: BlocProvider(
          create: (context) => SearchPageBloc()..add(LoadData()),
          child: BlocBuilder<SearchPageBloc, SearchPageState>(
            builder: (context, state) {
              if (state is SearchPageLoadedState) {
                return GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: ListView(
                      children: [
                        isAuthenticated
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    child: CustomSizedTextBox(
                                      textContent: "Recently searched",
                                      isBold: true,
                                    fontSize: 20,
                                      // addPadding: true,
                                      // paddingWidth: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  state.recentSearchTerms.isNotEmpty
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount:
                                              state.recentSearchTerms.length,
                                          itemBuilder: (context, index) {
                                            return SearchTerm(
                                              searchTerm: state
                                                  .recentSearchTerms[index],
                                            );
                                          })
                                      : SearchTerm(
                                          searchTerm: "No recent searches")
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: CustomSizedTextBox(
                            textContent: "Try Searching",
                            isBold: true,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return SearchTerm(
                                  searchTerm: state.popularSearchTerms[index]);
                            })
                      ],
                    ),
                  ),
                );
              } else {
                return const LoadingSpinnerWidget();
              }
            },
          ),
        ));
  }
}
