// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:tcc_copsoma/screen/page_home.dart'; // Importa a tela inicial
// import 'package:tcc_copsoma/database/database_helper.dart';

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
//       home: SplashScreen(cameras: cameras), // Inicia com a Splash Screen
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   final List<CameraDescription> cameras;
//   const SplashScreen({super.key, required this.cameras});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Timer para navegar para a tela principal após 2 segundos
//     Timer(const Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               HomePage(cameras: widget.cameras), // Redireciona à HomePage
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2457C5), // Cor de fundo
//       body: Center(
//         child: Image.asset(
//           'lib/images/logo_CopSoma.png', // Caminho da logo
//           width: 150,
//           height: 150,
//         ),
//       ),
//     );
//   }
// }

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:tcc_copsoma/screen/page_home.dart'; // Tela inicial
// import 'package:tcc_copsoma/screen/page_resultado.dart'; // Tela de resultado
// import 'package:tcc_copsoma/screen/confirm_photo.dart'; // Tela de confirmação
// import 'package:tcc_copsoma/database/database_helper.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Obtém a lista de câmeras disponíveis
//   final cameras = await availableCameras();

//   // Apenas para depuração: imprime o caminho do banco de dados
//   await DatabaseHelper().printDatabasePath();

//   runApp(MyApp(cameras: cameras));
// }

// class MyApp extends StatelessWidget {
//   final List<CameraDescription> cameras;

//   const MyApp({super.key, required this.cameras});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CopSoma',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       // Define a tela inicial como a SplashScreen
//       initialRoute: '/',
//       routes: {
//         '/': (context) =>
//             SplashScreen(cameras: cameras), // Tela inicial (Splash)
//         '/home': (context) => HomePage(cameras: cameras), // Página principal
//         '/resultado': (context) => const PageResultado(), // Tela de resultado
//         // Adicione outras rotas, se necessário
//       },
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const SplashScreen({super.key, required this.cameras});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     // Timer para navegar para a HomePage após 2 segundos
//     Timer(const Duration(seconds: 2), () {
//       Navigator.pushReplacementNamed(context, '/home');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2457C5), // Fundo azul
//       body: Center(
//         child: Image.asset(
//           'lib/images/logo_CopSoma.png', // Caminho do logo
//           width: 150,
//           height: 150,
//         ),
//       ),
//     );
//   }
// }

// >>>>>>>>>>>>>>>>>>>>>>>>>

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:tcc_copsoma/screen/page_home.dart'; // Tela inicial
// import 'package:tcc_copsoma/screen/page_resultado.dart'; // Tela de resultado
// import 'package:tcc_copsoma/database/database_helper.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Obtém a lista de câmeras disponíveis
//   final cameras = await availableCameras();

//   // Apenas para depuração: imprime o caminho do banco de dados
//   await DatabaseHelper().printDatabasePath();

//   runApp(MyApp(cameras: cameras));
// }

// class MyApp extends StatelessWidget {
//   final List<CameraDescription> cameras;

//   const MyApp({super.key, required this.cameras});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CopSoma',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: SplashScreen(cameras: cameras), // Começa na Splash Screen
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const SplashScreen({super.key, required this.cameras});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     // Timer para navegar para a HomePage após 2 segundos
//     Timer(const Duration(seconds: 2), () {
//       // Usa pushReplacement para evitar que o usuário volte à SplashScreen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(cameras: widget.cameras),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2457C5), // Fundo azul
//       body: Center(
//         child: Image.asset(
//           'lib/images/logo_CopSoma.png', // Caminho do logo
//           width: 150,
//           height: 150,
//         ),
//       ),
//     );
//   }
// }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'screen/app_state.dart';
import 'screen/page_home.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the list of available cameras
  final cameras = await availableCameras();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MyApp(cameras: cameras),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CopSoma',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(cameras: cameras), // Start with the Splash Screen
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

    // Timer to navigate to the HomePage after 2 seconds
    Timer(const Duration(seconds: 2), () {
      // Use pushReplacement to prevent going back to the SplashScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(cameras: widget.cameras),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2457C5), // Blue background
      body: Center(
        child: Image.asset(
          'lib/images/logo_CopSoma.png', // Path to the logo
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
