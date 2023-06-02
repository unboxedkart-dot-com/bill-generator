import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';
import 'package:unboxedkart/logic/search_page/search_bloc.dart';
import 'package:unboxedkart/presentation/pages/products_page/products.dart';

class SearchBar extends StatefulWidget {
  final String searchTerm;

  const SearchBar({Key key, this.searchTerm}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final String searchTerm;
  _SearchBarState({this.searchTerm});
  TextEditingController searchController = TextEditingController();
  final LocalRepository _localRepo = LocalRepository();
  bool isAuthenticated = false;

  bool searchTermIsNull = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: CupertinoTextField(
        autofocus: false,
        autocorrect: false,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(10),
        ),
        cursorColor: Colors.grey,
        controller: searchController,
        placeholder: 'Search Products',
        prefix: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            CupertinoIcons.search,
            size: 18,
            color: Colors.black,
          ),
        ),
        suffix: !searchTermIsNull
            ? GestureDetector(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.clear_circled_solid,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
                onTap: () {
                  setState(() {
                    searchController.clear();
                    searchTermIsNull = true;
                  });
                },
              )
            : const SizedBox(),
        onChanged: (val) {
          if (val.isNotEmpty) {
            setState(() {
              searchTermIsNull = false;
            });
          } else if (val.isEmpty) {
            setState(() {
              searchTermIsNull = true;
            });
          }
        },
        onEditingComplete: () {
          if (searchController.text.isNotEmpty) {
            _handleAddSearchTerm();
            Navigator.pushNamed(context, '/products',
                arguments: ProductsPage(
                  title: searchController.text,
                  // notByTitle: false,
                ));
          }
        },
      ),
    );
  } 

  _handleAddSearchTerm() {
    BlocProvider.of<SearchPageBloc>(context)
        .add(AddRecentSearchTerm(searchController.text));
  }
}
