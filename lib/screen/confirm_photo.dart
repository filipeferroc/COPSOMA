// import 'dart:io';
// import 'package:flutter/material.dart';
// import '../database/database_helper.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart' show rootBundle;

// class ConfirmPhoto extends StatelessWidget {
//   final String imagePath;
//   final int? hasNote;
//   final Function(int) onConfirmed;

//   const ConfirmPhoto({
//     super.key,
//     required this.imagePath,
//     required this.hasNote,
//     required this.onConfirmed,
//   });

//   Future<void> confirm(BuildContext context) async {
//     final db = DatabaseHelper();
//     int noteId = hasNote ?? await db.insertNota({'valor': 0.0});

//     // Enviar a imagem para o servidor local
//     int? checkCount = await enviarImagemParaServidor(imagePath);

//     if (checkCount != null) {
//       print('Número de checks detectados: $checkCount');
//       await db.updateNota(noteId, {
//         'valor': checkCount.toDouble()
//       }); // Atualiza a nota com o valor detectado
//     } else {
//       print('Erro ao detectar checks');
//     }

//     await db.insertImagem({
//       'srcPath': imagePath,
//       'id_nota': noteId,
//     });

//     onConfirmed(noteId);
//     Navigator.pop(context);
//   }

//   void deny(BuildContext context) {
//     Navigator.pop(context);
//   }

//   void returnToCamera(BuildContext context) {
//     Navigator.pop(context);
//   }

//   // Future<int?> enviarImagemParaServidor(String imagePath) async {
//   //   imagePath = 'assets/images/010.jpg';
//   //   final url =
//   //       Uri.parse('http://10.0.2.2:5000/predict'); // URL do servidor local

//   //   try {
//   //     // Leia a imagem como base64
//   //     final bytes = File(imagePath).readAsBytesSync();
//   //     final base64Image = base64Encode(bytes);

//   //     // Enviar a imagem para o servidor
//   //     final response = await http.post(
//   //       url,
//   //       headers: {'Content-Type': 'application/json'},
//   //       body: jsonEncode({"image": base64Image}),
//   //     );

//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);
//   //       return data['check_count']; // Retorna a contagem de checks
//   //     } else {
//   //       print('Erro no servidor: ${response.body}');
//   //       return null;
//   //     }
//   //   } catch (e) {
//   //     print('Erro ao conectar com o servidor: $e');
//   //     return null;
//   //   }
//   // }

//   Future<int?> enviarImagemParaServidor(String imagePath) async {
//     imagePath = 'assets/images/010.jpg';
//     final url = Uri.parse('http://192.168.100.111:5000/predict');

//     try {
//       // Leia a imagem dos assets
//       final bytes = await rootBundle.load('assets/images/010.jpg');
//       final base64Image = base64Encode(bytes.buffer.asUint8List());

//       // Enviar a imagem para o servidor
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"image": base64Image}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['check_count'];
//       } else {
//         print('Erro no servidor: ${response.body}');
//         return null;
//       }
//     } catch (e) {
//       print('Erro ao conectar com o servidor: $e');
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'CONFIRMAÇÃO',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2457C5),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.close,
//             color: Colors.white,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: Image.asset(
//               'lib/images/logo_branco_sem_fundo.png',
//               height: 40,
//               width: 40,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Exibição da imagem
//           Positioned.fill(
//             child: Image.file(
//               File(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Área de botões na parte inferior
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               color: Colors.white,
//               height: 100,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   // Botão de negar (X)
//                   IconButton(
//                     onPressed: () => deny(context),
//                     icon: const Icon(
//                       Icons.close,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   // Botão de retorno à câmera (Seta de retorno)
//                   IconButton(
//                     onPressed: () => returnToCamera(context),
//                     icon: const Icon(
//                       Icons.refresh,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   // Botão de confirmar (✔)
//                   IconButton(
//                     onPressed: () => confirm(context),
//                     icon: const Icon(
//                       Icons.check,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import '../database/database_helper.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ConfirmPhoto extends StatelessWidget {
//   final String imagePath;
//   final int? hasNote;
//   final Function(int) onConfirmed;

//   const ConfirmPhoto({
//     super.key,
//     required this.imagePath,
//     required this.hasNote,
//     required this.onConfirmed,
//   });

//   Future<void> confirm(BuildContext context) async {
//     final db = DatabaseHelper();

//     // Cria uma nota se ainda não existir
//     int noteId = hasNote ?? await db.insertNota({'valor': 0.0});

//     // Envia a imagem para o servidor e recebe a contagem de checks
//     int? checkCount = await enviarImagemParaServidor(imagePath);

//     if (checkCount != null) {
//       print('Número de checks detectados: $checkCount');

//       // Atualiza o valor da imagem no banco
//       int imageId = await db.insertImagem({
//         'srcPath': imagePath,
//         'id_nota': noteId,
//         'valor': checkCount, // Novo valor inserido
//       });

//       print('Imagem criada com ID: $imageId');

//       // Recupera o valor atual da nota
//       List<Map<String, dynamic>> nota = await db.getNotas();
//       double notaAtual = nota.firstWhere((n) => n['id'] == noteId)['valor'];

//       // Incrementa o valor da nota com o valor da nova imagem
//       double novoValorNota = notaAtual + checkCount.toDouble();
//       await db.updateNota(noteId, {'valor': novoValorNota});
//       print('Nota atualizada com valor total: $novoValorNota');
//     } else {
//       print('Erro ao detectar checks');
//     }

//     onConfirmed(noteId);
//     Navigator.pop(context);
//   }

//   void deny(BuildContext context) {
//     Navigator.pop(context);
//   }

//   void returnToCamera(BuildContext context) {
//     Navigator.pop(context);
//   }

//   Future<int?> enviarImagemParaServidor(String imagePath) async {
//     imagePath = 'assets/images/010.jpg';
//     final url =
//         Uri.parse('http://127.0.0.1:5000/predict'); // URL do servidor local

//     try {
//       // Leia a imagem como base64
//       final bytes = File(imagePath).readAsBytesSync();
//       final base64Image = base64Encode(bytes);

//       // Enviar a imagem para o servidor
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"image": base64Image}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['check_count']; // Retorna a contagem de checks
//       } else {
//         print('Erro no servidor: ${response.body}');
//         return null;
//       }
//     } catch (e) {
//       print('Erro ao conectar com o servidor: $e');
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'CONFIRMAÇÃO',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2457C5),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.close,
//             color: Colors.white,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: Image.asset(
//               'lib/images/logo_branco_sem_fundo.png',
//               height: 40,
//               width: 40,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Exibição da imagem
//           Positioned.fill(
//             child: Image.file(
//               File(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Área de botões na parte inferior
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               color: Colors.white,
//               height: 100,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   // Botão de negar (X)
//                   IconButton(
//                     onPressed: () => deny(context),
//                     icon: const Icon(
//                       Icons.close,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   // Botão de retorno à câmera (Seta de retorno)
//                   IconButton(
//                     onPressed: () => returnToCamera(context),
//                     icon: const Icon(
//                       Icons.refresh,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   // Botão de confirmar (✔)
//                   IconButton(
//                     onPressed: () => confirm(context),
//                     icon: const Icon(
//                       Icons.check,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// import 'dart:io';
// import 'package:flutter/material.dart';
// import '../database/database_helper.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart' show rootBundle;

// class ConfirmPhoto extends StatelessWidget {
//   final String imagePath;
//   final int? hasNote;
//   final Function(int) onConfirmed;

//   const ConfirmPhoto({
//     super.key,
//     required this.imagePath,
//     required this.hasNote,
//     required this.onConfirmed,
//   });

//   Future<void> confirm(BuildContext context) async {
//     final db = DatabaseHelper();
//     int noteId = hasNote ?? await db.insertNota({'valor': 0.0});

//     // Enviar a imagem para o servidor local
//     int? checkCount = await enviarImagemParaServidor(imagePath);

//     if (checkCount != null) {
//       print('Número de checks detectados: $checkCount');
//       await db.updateNota(noteId, {
//         'valor': checkCount.toDouble()
//       }); // Atualiza a nota com o valor detectado
//     } else {
//       print('Erro ao detectar checks');
//     }

//     await db.insertImagem({
//       'srcPath': imagePath,
//       'id_nota': noteId,
//     });

//     onConfirmed(noteId);
//     Navigator.pop(context);
//   }

//   void deny(BuildContext context) {
//     Navigator.pop(context);
//   }

//   void returnToCamera(BuildContext context) {
//     Navigator.pop(context);
//   }

//   Future<int?> enviarImagemParaServidor(String imagePath) async {

//     final url = Uri.parse('http://192.168.100.111:5000/predict');

//     try {
//       // Verifica se o caminho da imagem é um asset ou um arquivo local
//       String base64Image;
//       if (imagePath.startsWith('assets/')) {
//         // Leia a imagem dos assets
//         final bytes = await rootBundle.load(imagePath);
//         base64Image = base64Encode(bytes.buffer.asUint8List());
//       } else {
//         // Leia a imagem de um arquivo local
//         final bytes = await File(imagePath).readAsBytes();
//         base64Image = base64Encode(bytes);
//       }

//       // Enviar a imagem para o servidor
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"image": base64Image}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['check_count'];
//       } else {
//         print('Erro no servidor: ${response.body}');
//         return null;
//       }
//     } catch (e) {
//       print('Erro ao conectar com o servidor: $e');
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'CONFIRMAÇÃO',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2457C5),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.close,
//             color: Colors.white,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: Image.asset(
//               'lib/images/logo_branco_sem_fundo.png',
//               height: 40,
//               width: 40,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Exibição da imagem
//           Positioned.fill(
//             child: Image.file(
//               File(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Área de botões na parte inferior
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               color: Colors.white,
//               height: 100,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   // Botão de negar (X)
//                   IconButton(
//                     onPressed: () => deny(context),
//                     icon: const Icon(
//                       Icons.close,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   // Botão de retorno à câmera (Seta de retorno)
//                   IconButton(
//                     onPressed: () => returnToCamera(context),
//                     icon: const Icon(
//                       Icons.refresh,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   // Botão de confirmar (✔)
//                   IconButton(
//                     onPressed: () => confirm(context),
//                     icon: const Icon(
//                       Icons.check,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//>>>>>>>>>>>>>>>>>>>>>>>

// import 'dart:io';
// import 'package:flutter/material.dart';
// import '../database/database_helper.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart' show rootBundle;
// import 'page_resultado.dart';
// import 'package:camera/camera.dart';

// class ConfirmPhoto extends StatelessWidget {
//   final String imagePath;
//   final int? hasNote;
//   final VoidCallback onFinalizar;
//   //final List<CameraDescription> cameras;
//   final Function(int) onConfirmed;

//   const ConfirmPhoto({
//     super.key,
//     required this.imagePath,
//     required this.hasNote,
//     required this.onFinalizar,
//     //required this.cameras,
//     required this.onConfirmed,
//   });

//   Future<void> confirm(BuildContext context) async {
//     final db = DatabaseHelper();
//     int noteId = hasNote ?? await db.insertNota({'valor': 0.0});

//     // Enviar a imagem para o servidor local
//     int? checkCount = await enviarImagemParaServidor(imagePath);

//     if (checkCount != null) {
//       print('Número de checks detectados: $checkCount');

//       // Obter o valor atual da nota no banco de dados
//       Map<String, dynamic>? existingNote = await db.getNota(noteId);
//       double currentNoteValue =
//           existingNote != null ? existingNote['valor'] ?? 0.0 : 0.0;

//       // Atualizar a nota somando o valor retornado pela API
//       double updatedValue = currentNoteValue + checkCount.toDouble();
//       await db.updateNota(noteId, {'valor': updatedValue});
//     } else {
//       print('Erro ao detectar checks');
//     }

//     // Inserir a imagem no banco de dados
//     await db.insertImagem({
//       'srcPath': imagePath,
//       'id_nota': noteId,
//       'valor': checkCount?.toDouble()
//     });

//     Map<String, dynamic>? notaAtualizada = await db.getNota(noteId);
//     double resultadoTotal = notaAtualizada?['valor'] ?? 0.0;
//     // Retornar à página de resultado com o ID da nota
//     onConfirmed(noteId);
//     void returnToCamera(BuildContext context) {
//       Navigator.pop(context);
//     }

//     //Navigator.pushNamed(context, '/resultado', arguments: noteId);
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ResultadoScreen(
//           resultadoUltimaPredicao: checkCount ?? 0,
//           resultadoTotal:
//               resultadoTotal, // Agora sem "await" porque já foi buscado antes
//           onFinalizar: () {
//             Navigator.popUntil(context, (route) => route.isFirst);
//           },
//           // existingNoteId: hasNote,
//           // cameras:
//           //     cameras, // Passando a lista de câmeras para a tela de resultados
//         ),
//       ),
//     );
//     Navigator.pop(context);
//   }

//   void deny(BuildContext context) {
//     Navigator.pop(context);
//   }

//   void returnToCamera(BuildContext context) {
//     Navigator.pop(context);
//   }

//   Future<int?> enviarImagemParaServidor(String imagePath) async {
//     imagePath = 'assets/images/010.jpg';
//     final url = Uri.parse('http://192.168.100.111:5000/predict');

//     try {
//       // Verifica se o caminho da imagem é um asset ou um arquivo local
//       String base64Image;
//       if (imagePath.startsWith('assets/')) {
//         // Leia a imagem dos assets
//         final bytes = await rootBundle.load(imagePath);
//         base64Image = base64Encode(bytes.buffer.asUint8List());
//       } else {
//         // Leia a imagem de um arquivo local
//         final bytes = await File(imagePath).readAsBytes();
//         base64Image = base64Encode(bytes);
//       }

//       // Enviar a imagem para o servidor
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"image": base64Image}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['check_count'];
//       } else {
//         print('Erro no servidor: ${response.body}');
//         return null;
//       }
//     } catch (e) {
//       print('Erro ao conectar com o servidor: $e');
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'CONFIRMAÇÃO',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2457C5),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.close,
//             color: Colors.white,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: Image.asset(
//               'lib/images/logo_branco_sem_fundo.png',
//               height: 40,
//               width: 40,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Exibição da imagem
//           Positioned.fill(
//             child: Image.file(
//               File(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Área de botões na parte inferior
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               color: Colors.white,
//               height: 100,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   // Botão de negar (X)
//                   IconButton(
//                     onPressed: () => deny(context),
//                     icon: const Icon(
//                       Icons.close,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   // Botão de retorno à câmera (Seta de retorno)
//                   IconButton(
//                     onPressed: () => returnToCamera(context),
//                     icon: const Icon(
//                       Icons.refresh,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   // Botão de confirmar (✔)
//                   IconButton(
//                     onPressed: () => confirm(context),
//                     icon: const Icon(
//                       Icons.check,
//                       size: 40,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//>>>>>>>>>>>>>>>>>>>>>>>

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart'; // Import the AppState class
import 'page_resultado.dart'; // Import the ResultadoScreen

import '../database/database_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
// import 'package:camera/camera.dart';

class ConfirmPhoto extends StatelessWidget {
  final String imagePath;
  final VoidCallback onFinalizar;
  final int? hasNote;
  final Function(int) onConfirmed;

  const ConfirmPhoto({
    super.key,
    required this.imagePath,
    required this.onFinalizar,
    required this.hasNote,
    required this.onConfirmed,
  });

  Future<void> confirm(BuildContext context) async {
    final db = DatabaseHelper();
    int noteId = hasNote ?? await db.insertNota({'valor': 0.0});

    // Enviar a imagem para o servidor local
    int? checkCount = await enviarImagemParaServidor(imagePath);

    if (checkCount != null) {
      print('Número de checks detectados: $checkCount');

      // Obter o valor atual da nota no banco de dados
      Map<String, dynamic>? existingNote = await db.getNota(noteId);
      double currentNoteValue =
          existingNote != null ? existingNote['valor'] ?? 0.0 : 0.0;

      // Atualizar a nota somando o valor retornado pela API
      double updatedValue = currentNoteValue + checkCount.toDouble();
      await db.updateNota(noteId, {'valor': updatedValue});
    } else {
      print('Erro ao detectar checks');
    }

    // Inserir a imagem no banco de dados
    await db.insertImagem({
      'srcPath': imagePath,
      'id_nota': noteId,
      'valor': checkCount?.toDouble()
    });

    Map<String, dynamic>? notaAtualizada = await db.getNota(noteId);
    double resultadoTotal = notaAtualizada?['valor'] ?? 0.0;
    // Retornar à página de resultado com o ID da nota
    onConfirmed(noteId);
    void returnToCamera(BuildContext context) {
      Navigator.pop(context);
    }

    if (checkCount != null) {
      // Navigate to the ResultadoScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultadoScreen(
            resultadoUltimaPredicao: checkCount,
            resultadoTotal: resultadoTotal,
          ),
        ),
      );
    } else {
      print('Erro ao detectar checks');
    }
  }

  void deny(BuildContext context) {
    Navigator.pop(context);
  }

  Future<int?> enviarImagemParaServidor(String imagePath) async {
    //final url = Uri.parse('http://18.219.154.222:5000/predict');
    final url = Uri.parse('http://192.168.100.111:5000/predict');

    try {
      // Verifica se o caminho da imagem é um asset ou um arquivo local
      String base64Image;
      if (imagePath.startsWith('assets/')) {
        // Leia a imagem dos assets
        final bytes = await rootBundle.load(imagePath);
        base64Image = base64Encode(bytes.buffer.asUint8List());
      } else {
        // Leia a imagem de um arquivo local
        final bytes = await File(imagePath).readAsBytes();
        base64Image = base64Encode(bytes);
      }

      // Enviar a imagem para o servidor
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"image": base64Image}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['check_count'];
      } else {
        print('Erro no servidor: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro ao conectar com o servidor: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CONFIRMAÇÃO',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2457C5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'lib/images/logo_branco_sem_fundo.png',
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Display the image
          Positioned.fill(
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          // Button area at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Deny button (X)
                  IconButton(
                    onPressed: () => deny(context),
                    icon: const Icon(
                      Icons.close,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  // Confirm button (✔)
                  IconButton(
                    onPressed: () => confirm(context),
                    icon: const Icon(
                      Icons.check,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
