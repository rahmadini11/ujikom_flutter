import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AgendaScreen extends StatelessWidget {
  Future<List<dynamic>> fetchAgenda() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/agendas'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load agenda');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda Tab'),
        backgroundColor: Colors.pinkAccent, // Warna AppBar pink yang mencolok
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink[100]!,
              Colors.pink[300]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<dynamic>>(
          future: fetchAgenda(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              final agendaItems = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: agendaItems.length,
                itemBuilder: (context, index) {
                  final item = agendaItems[index];
                  final title = item['title']; // Menyesuaikan dengan nama key dari API
                  final description = item['description']; // Menyesuaikan dengan nama key dari API
                  final date = item['event_date']; // Menyesuaikan dengan nama key dari API

                  return Card(
                    elevation: 6, // Bayangan untuk kartu
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Sudut melengkung
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.pink[50]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.pinkAccent,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 14, color: Colors.pinkAccent),
                              SizedBox(width: 4),
                              Text(
                                'Tanggal: $date',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color.fromARGB(255, 36, 17, 17),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
