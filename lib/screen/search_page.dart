import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SearchResult {
  final String fnameLa;
  final String lnameLa;
  final String imageUrl;

  SearchResult({
    required this.fnameLa,
    required this.lnameLa,
    required this.imageUrl,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      fnameLa: json['fname_la'],
      lnameLa: json['lname_la'],
      imageUrl: json['image_url'],
    );
  }
}

class SearchPage extends StatefulWidget {
  final String searchQuery;

  const SearchPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Dio _dio = Dio();
  List<SearchResult> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _search();
  }

  Future<void> _search() async {
    try {
      final response = await _dio.get('http://192.168.43.127:8000/student/search?q=${widget.searchQuery}');
      final data = response.data;
      setState(() {
        _searchResults = List<SearchResult>.from(data.map((x) => SearchResult.fromJson(x)));
      });
    } catch (e) {
      print('Error searching: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for ${widget.searchQuery}'),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final result = _searchResults[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(result.imageUrl),
            ),
            title: Text('${result.fnameLa} ${result.lnameLa}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to edit page with result details
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Perform delete action
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
