import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final country =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final currencies = country['currencies'] != null
        ? country['currencies']
            .values
            .map((currency) => currency['name'])
            .toList()
        : ['N/A'];
    final languages = country['languages'] != null
        ? country['languages'].values.toList()
        : ['N/A'];
    final population = country['population'];
    return Scaffold(
      appBar: AppBar(
        title: Text(country['name']['common']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.network(
                country['flags'] == null ? '' : country['flags']['png'],
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Common Name: ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Flexible(
                  child: Text(
                    country['name']['common'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Official Name: ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Flexible(
                  child: Text(
                    country['name']['official'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Currency: ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  currencies.toString().replaceAll('[', '').replaceAll(']', ''),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Region: ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  country['region'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Languages: ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  languages.toString().replaceAll('[', '').replaceAll(']', ''),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Population: ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${population}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
