import 'package:flutter/material.dart';
import '../../Model/offer/Category.dart';


class SearchBarApp extends StatefulWidget {
  void Function(String) setCategoryCallBack;
  SearchBarApp({required this.setCategoryCallBack});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool _isLoading = true;
  bool isDark = false;
  List<Category> categories = [];
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    fetchCategories().then((List<Category> result) {
      setState(() {
        categories = result;
        _isLoading = false;
      });
    }).onError((error, stackTrace) {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            trailing: <Widget>[

            ],
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          return categories.map((Category item) {
            return ListTile(
              title: Text(
                item.name!,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                setState(() {
                  selectedCategory = item.name!;
                  controller.closeView(item.name!);
                  widget.setCategoryCallBack(item.name!);
                });
              },
            );
          }).toList();
        },
      ),
    );
  }

}
