import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.pinkAccent, // Mengubah warna AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink[100]!, Colors.pink[300]!], // Gradasi latar belakang
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.pink[800], // Warna teks lebih gelap
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Di Aplikasi Galeri Sekolah',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54, // Warna teks lebih lembut
              ),
            ),
            SizedBox(height: 32),

            // Kartu untuk navigasi ke tampilan lain
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildCard(context, 'Agenda', Icons.event, Colors.orange, () {
                    Navigator.pushNamed(context, '/agenda');
                  }),
                  _buildCard(context, 'Info', Icons.info, Color.fromARGB(255, 33, 89, 243), () {
                    Navigator.pushNamed(context, '/info');
                  }),
                  _buildCard(context, 'Gallery', Icons.photo, const Color.fromARGB(255, 175, 76, 173), () {
                    Navigator.pushNamed(context, '/gallery');
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8, // Meningkatkan bayangan untuk efek 3D
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color, // Menggunakan warna yang ditentukan
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48, // Ukuran ikon lebih besar
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20, // Ukuran teks lebih besar
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
