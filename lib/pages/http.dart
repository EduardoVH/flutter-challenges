import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpApi extends StatefulWidget {
  const HttpApi({super.key});

  @override
  State<HttpApi> createState() => _HttpApiState();
}

class _HttpApiState extends State<HttpApi> {
  // Método para hacer la solicitud HTTP
  Future<List<dynamic>> fetchData() async {
    final url = Uri.parse(
        'https://api.sampleapis.com/movies/horror'); // Example endpoint
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
        title: const Text('Películas de Terror'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.orange,
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final List<dynamic> movies = snapshot.data ?? [];

              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return ListTile(
                    leading: movie['posterURL'] != null
                        ? SizedBox(
                            width: 50,
                            height: 75,
                            child: Image.network(
                              movie['posterURL'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons
                                    .movie); // Placeholder for broken image
                              },
                            ),
                          )
                        : const Icon(Icons.movie),

                    title: Text(movie['title']), // Movie title
                    subtitle: Text('IMDB ID: ${movie['imdbId']}'), // IMDB ID
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
