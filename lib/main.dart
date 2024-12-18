// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:projeto_tcc/database/database_helper.dart';
// import 'package:projeto_tcc/screen/galeria.dart';
// import 'screen/page_camera.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   await DatabaseHelper().printDatabasePath();
//   runApp(MyApp(cameras: cameras));
// }

// class MyApp extends StatelessWidget {
//   final List<CameraDescription> cameras;
//   const MyApp({super.key, required this.cameras});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: HomePage(cameras: cameras),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   final List<CameraDescription> cameras;
//   const HomePage({super.key, required this.cameras});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Tela Principal')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PageCamera(cameras: cameras),
//                 ),
//               ),
//               child: const Text("Abrir Câmera"),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const GaleriaPage(),
//                 ),
//               ),
//               child: const Text('Abrir Galeria'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:projeto_tcc/database/database_helper.dart';
// import 'package:projeto_tcc/screen/galeria.dart';
// import 'screen/page_camera.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   await DatabaseHelper().printDatabasePath();
//   runApp(MyApp(cameras: cameras));
// }

// class MyApp extends StatelessWidget {
//   final List<CameraDescription> cameras;
//   const MyApp({super.key, required this.cameras});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: HomePage(cameras: cameras),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   final List<CameraDescription> cameras;
//   const HomePage({super.key, required this.cameras});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildIconButton(
//               context: context,
//               icon: Icons.camera_alt,
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PageCamera(cameras: cameras),
//                 ),
//               ),
//               label: "Abrir Câmera",
//             ),
//             const SizedBox(width: 20),
//             _buildIconButton(
//               context: context,
//               icon: Icons.photo_library,
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const GaleriaPage(),
//                 ),
//               ),
//               label: "Abrir Galeria",
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildIconButton({
//     required BuildContext context,
//     required IconData icon,
//     required VoidCallback onPressed,
//     required String label,
//   }) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         width: 100,
//         height: 100,
//         decoration: BoxDecoration(
//           color: const Color(0xFF2457C5).withOpacity(0.85),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Icon(
//           icon,
//           size: 50,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:projeto_tcc/screen/page_home.dart'; // Importa a tela inicial
import 'package:projeto_tcc/database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  await DatabaseHelper().printDatabasePath();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(cameras: cameras), // Inicia com a Splash Screen
    );
  }
}

class SplashScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const SplashScreen({super.key, required this.cameras});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer para navegar para a tela principal após 2 segundos
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomePage(cameras: widget.cameras), // Redireciona à HomePage
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2457C5), // Cor de fundo
      body: Center(
        child: Image.asset(
          'lib/images/logo_CopSoma.png', // Caminho da logo
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
