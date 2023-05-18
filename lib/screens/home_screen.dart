import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  List<Map<String, dynamic>> countries = [];
  List<Map<String, dynamic>> foundCountries = [];
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    fetchData();

    super.initState();
  }

  void filter(String keyword) {
    List<Map<String, dynamic>> results = [];
    if (keyword.isEmpty) {
      results = countries;
    } else {
      results = countries
          .where((element) =>
              '${element['name']['common']}'
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) ||
              '${element['capital']}'
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) ||
              '${element['languages']}'
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) ||
              '${element['currencies']}'
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundCountries = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text("WorldyGeek"),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) => filter(value),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(),
                  )),
            ),
          ),
          Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: foundCountries.length,
                      itemBuilder: (context, index) {
                        final country = foundCountries[index];
                        final name = country['name']['common'];
                        final capital = country['capital'] != null
                            ? country['capital'][0]
                            : "N/A";
                        final image = country['flags']['png'];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              'detail',
                              arguments: country,
                            );
                          },
                          child: Card(
                            elevation: 2,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 44,
                                    minHeight: 44,
                                    maxWidth: 64,
                                    maxHeight: 64,
                                  ),
                                  child:
                                      Image.network(image, fit: BoxFit.cover),
                                ),
                              ),
                              title: Text(name),
                              subtitle: Row(
                                children: [
                                  Text('Capital: '),
                                  Text(capital),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    const url = 'https://restcountries.com/v3.1/all';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    setState(() {
      _isLoading = false;
      countries = json;
      foundCountries = countries;
    });
  }
}
