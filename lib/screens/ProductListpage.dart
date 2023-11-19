import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<String>> _categories;
  final List<String> _favoriteItems = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _categories = ApiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<String> categories = snapshot.data ?? [];
            return _currentIndex == 0
                ? _buildListTab(categories)
                : _buildFavoritesTab();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  Widget _buildListTab(List<String> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            categories[index],
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              _favoriteItems.contains(categories[index])
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              _toggleFavorite(categories[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildFavoritesTab() {
    return ListView.builder(
      itemCount: _favoriteItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_favoriteItems[index],
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              )),
        );
      },
    );
  }

  void _toggleFavorite(String item) {
    setState(() {
      if (_favoriteItems.contains(item)) {
        _favoriteItems.remove(item);
      } else {
        _favoriteItems.add(item);
      }
    });
  }
}
