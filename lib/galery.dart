import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GaleryScreen extends StatelessWidget {
  Future<List<dynamic>> fetchGallery() async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/api/galleries')); // Use the correct API URL

    if (response.statusCode == 200) {
      // Parse the response body to get the gallery data
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load gallery');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink[50]!,
              Colors.pink[100]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: fetchGallery(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              final galleryItems = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: galleryItems.length,
                itemBuilder: (context, index) {
                  final gallery = galleryItems[index];
                  final title = gallery['title'];
                  final photos = gallery['photos'];

                  // Display gallery title and photos in a grid
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                      // Display photos as a horizontal list
                      Container(
                        height: 200.0, // Height of the photo carousel
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: photos.length,
                          itemBuilder: (context, photoIndex) {
                            final photo = photos[photoIndex];
                            final imageUrl = photo['image_url'];
                            final photoTitle = photo['title'];

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                elevation: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16.0),
                                      ),
                                      child: Image.network(
                                        imageUrl,
                                        height: 150, // Image height
                                        width: 150,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                      loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            height: 150,
                                            color: Colors.grey[300],
                                            child: Center(
                                              child: Text('Image not available'),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        photoTitle,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.pinkAccent,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
