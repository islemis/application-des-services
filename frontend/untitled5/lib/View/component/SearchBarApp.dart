import 'package:flutter/material.dart';
import '../../Model/offer/Category.dart';
import '../../Model/offer/offer.dart';
import '../../Services/Offer/OfferService.dart';
import 'SearchResultPage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity, // Adjust the width constraint as needed
          height: double.infinity, // Adjust the height constraint as needed
          child: SearchBarApp(),
        ),
      ),
    );
  }
}

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}
class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;
  List<Category> categories = [];
  List<String> list = [];
  String selectedCategory = ''; // Add this line to store the selected category

  @override
  void initState() {
    super.initState();
    // Call an asynchronous function to fetch categories
    fetchCategories().then((List<Category> result) {
      // Update the state when the data is available
      setState(() {
        categories = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    for (Category c in categories) {
      list.add(c.name.toString());
    }

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(title: const Text('Search Bar Sample')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
                leading: const Icon(Icons.search),
                trailing: <Widget>[
                  Tooltip(
                    message: 'Change brightness mode',
                    child: IconButton(
                      isSelected: isDark,
                      onPressed: () {
                        setState(() {
                          isDark = !isDark;
                        });
                      },
                      icon: const Icon(Icons.wb_sunny_outlined),
                      selectedIcon: const Icon(Icons.brightness_2_outlined),
                    ),
                  )
                ],
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              return list.map((String item) {
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      selectedCategory = item; // Update the selected category
                      controller.closeView(item);
                    });
                  },
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  // Update buildResults to fetch offers based on the selected category
  @override
  Widget buildResults(BuildContext context) {
    Future<List<Offer>> fetchSearchResults() async {
      try {
        if (selectedCategory.isNotEmpty) {
          return getOffersByCategory(selectedCategory);
        } else {
          // Handle the case when no category is selected
          return [];
        }
      } catch (error) {
        print('Error fetching search results: $error');
        throw Exception('Failed to load search results');
      }
    }

    return FutureBuilder(
      future: fetchSearchResults(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<Offer> searchResults = snapshot.data as List<Offer>;

          return SearchResultPage(searchResults: searchResults);
        }
      },
    );
  }
}
