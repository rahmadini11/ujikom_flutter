import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Future<List<dynamic>> fetchInfos() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/infos'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Gagal memuat informasi');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Gagal terhubung ke server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi'),
        backgroundColor: Colors.pinkAccent, // Mengubah AppBar menjadi merah muda
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchInfos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final infos = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: infos.length,
            itemBuilder: (context, index) {
              final info = infos[index];

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                color: Colors.pink[50], // Mengubah latar belakang card menjadi merah muda muda
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent, // Mengubah warna judul menjadi merah muda
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.pink[100], // Warna latar belakang konten menjadi lebih cerah
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          info['content'],
                          style: TextStyle(
                            color: Colors.pink[800], // Warna teks lebih gelap
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Dibuat: ${_formatDate(info['created_at'])}',
                      style: TextStyle(
                        color: Colors.pink[600], // Warna tanggal dibuat menggunakan merah muda lebih gelap
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return '${date.day}-${date.month}-${date.year}';
  }
}
