// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:marketing_dentista/core/core.dart';
import 'package:marketing_dentista/core/theme/app_colors.dart';

import 'package:marketing_dentista/core/service/secure_storage_service.dart';
import 'package:searchfield/searchfield.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
    required this.action,
    this.query,
  });
  final Function(String) action;
  final String? query;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 65);
}

class _SearchAppBarState extends State<SearchAppBar> {
  final secureStorage = SecureStorageService();
  final suggestions = <String>[];
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.query ?? '';
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    final value = await secureStorage.read('suggestions');
    if (value != null) {
      setState(() {
        suggestions.addAll(value.split(','));
      });
    }
  }

  Future<void> _search(String value) async {
    widget.action(value);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      toolbarHeight: 80,
      title: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(left: 24, right: 16),
        child: Row(
          children: [
            Flexible(
              child: SearchField(
                controller: _textController,
                searchInputDecoration: const InputDecoration(
                  hintText: 'Buscar',
                  border: InputBorder.none,
                ),
                onSubmit: _search,
                suggestions: suggestions.map((suggestion) => SearchFieldListItem(suggestion)).toList(),
                suggestionItemDecoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () => _search(_textController.text),
              icon: Icon(Icons.search, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
