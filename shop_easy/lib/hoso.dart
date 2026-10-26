import 'package:flutter/material.dart';

class HoSo extends StatelessWidget {
  const HoSo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // M�u n?n x�m nh?t hi?n d?i
      appBar: AppBar(
        title: const Text(
          'H? so c� nh�n',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            block1(),
            const SizedBox(height: 16),
            block2(),
            const SizedBox(height: 24),
            block3(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Kh?i 1: ?nh b�a, ?nh d?i di?n, T�n v� S? di?n tho?i
  Widget block1() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // ?nh b�a
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQnAN7ZiCfLDDw0A-dpm3TsHc69Puk6mevZQ-wfYkEBzysb_73Hke9Bz6w&s=10',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
              // ?nh d?i di?n d?t d� l�n ?nh b�a
              Positioned(
                bottom: -50,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnMs_Vdlr5a87M0XDsoZHIC6cam_yjB7zuvRuNr21zqQ&s=10',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          // T�n ngu?i d�ng
          const Text(
            'Nguy?n Qu?c �?t',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          // S? di?n tho?i
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.phone, size: 16, color: Colors.grey),
              SizedBox(width: 6),
              Text(
                '0123 456 789',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Kh?i 2: C�c th�ng s? (B�i vi?t, Ngu?i theo d�i...) b?c trong Card
  Widget block2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('8', 'B�i vi?t'),
              _buildDividerVertical(),
              _buildStatItem('4', 'Ngu?i theo d�i'),
              _buildDividerVertical(),
              _buildStatItem('2', '�ang theo d�i'),
            ],
          ),
        ),
      ),
    );
  }

  // Widget con h? tr? t?o t?ng m?c th?ng k�
  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  // D�ng k? d?c ngan c�ch gi?a c�c s? li?u
  Widget _buildDividerVertical() {
    return Container(height: 24, width: 1, color: Colors.grey.withOpacity(0.3));
  }

  // Kh?i 3: C�c n�t h�nh d?ng (Theo d�i, Nh?n tin)
  Widget block3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // N�t Theo d�i (Expanded d? t? d?ng gi�n d?u)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.person_add, size: 18),
              label: const Text(
                'Theo d�i',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // N�t Nh?n tin
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.message, size: 18),
              label: const Text(
                'Nh?n tin',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
