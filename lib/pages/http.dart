import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpApi extends StatefulWidget {
  const HttpApi({super.key});

  @override
  State<HttpApi> createState() => _HttpApiState();
}

class _HttpApiState extends State<HttpApi> {
  // Method to fetch data from the API
  Future<List<dynamic>> fetchData() async {
    final url = Uri.parse(
        'https://api.sampleapis.com/movies/drama'); // Example endpoint
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<dynamic> movies = snapshot.data ?? [];

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.7,
              ),
              padding: const EdgeInsets.all(10.0),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Card(
                  elevation: 5.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      movie['posterURL'] != null
                          ? SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: Image.network(
                                movie['posterURL'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.movie); // Placeholder for broken image
                                },
                              ),
                            )
                          : const SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: Icon(Icons.movie, size: 100),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie['title'] ?? 'No Title',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'IMDB ID: ${movie['imdbId'] ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
