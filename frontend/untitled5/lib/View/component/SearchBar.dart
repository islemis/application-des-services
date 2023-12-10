import 'package:flutter/material.dart';
import '../../Model/offer/Category.dart';
import '../../Model/offer/offer.dart';
import '../../Services/Offer/OfferService.dart';

class Search extends StatelessWidget {
  final Function(String, String) onSearch; // Change the parameter type

  Search( {required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.grey,
              onPressed: () async {
                // Fetch categories from your API or use the existing list
                List<Category> categories = await fetchCategories();

                // Show a dropdown for category selection
                showSearch(
                  context: context,
                  delegate: SearchOffer(
                    onSearch: onSearch,
                    categories: categories,
                  ),
                );
              },
            ),
            Expanded(
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchOffer extends SearchDelegate<String> {
  final Function(String, String) onSearch;
  final List<Category> categories;

  SearchOffer({required this.onSearch, required this.categories});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.grey),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.grey),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query, categories[0].name.toString());
    return Container(
      // Display the search results here based on the category
      child: FutureBuilder<List<Offer>>(
        future: getOffersByCategory(query), // Use your getOffersByCategory method
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
            List<Offer> searchResults = snapshot.data ?? [];

            // Display the search results using the searchResults list
            // You can use a ListView, GridView, or any other widget based on your UI design
            return ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index].titre ?? ''),
                  // Add more details or customize as needed
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: Implement suggestions if needed
    return Container();
  }
}
