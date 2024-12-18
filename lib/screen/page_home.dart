import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:projeto_tcc/screen/galeria.dart';
import 'package:projeto_tcc/screen/page_camera.dart';

class HomePage extends StatelessWidget {
  final List<CameraDescription> cameras;
  const HomePage({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIconButton(
              context: context,
              icon: Icons.camera_alt,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageCamera(cameras: cameras),
                ),
              ),
              label: "Abrir Câmera",
            ),
            const SizedBox(width: 20),
            _buildIconButton(
              context: context,
              icon: Icons.photo_library,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GaleriaPage(),
                ),
              ),
              label: "Abrir Galeria",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
    required String label,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF2457C5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
