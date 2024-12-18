import 'dart:io';
import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class ConfirmPhoto extends StatelessWidget {
  final String imagePath;
  final int? hasNote;
  final Function(int) onConfirmed;

  const ConfirmPhoto({
    super.key,
    required this.imagePath,
    required this.hasNote,
    required this.onConfirmed,
  });

  Future<void> confirm(BuildContext context) async {
    final db = DatabaseHelper();
    int noteId = hasNote ?? await db.insertNota({'valor': 0.0});

    await db.insertImagem({
      'srcPath': imagePath,
      'id_nota': noteId,
    });

    onConfirmed(noteId);
    Navigator.pop(context);
  }

  void deny(BuildContext context) {
    Navigator.pop(context);
  }

  void returnToCamera(BuildContext context) {
    Navigator.pop(context);
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
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
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
          // Exibição da imagem
          Positioned.fill(
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          // Área de botões na parte inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Botão de negar (X)
                  IconButton(
                    onPressed: () => deny(context),
                    icon: const Icon(
                      Icons.close,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  // Botão de retorno à câmera (Seta de retorno)
                  IconButton(
                    onPressed: () => returnToCamera(context),
                    icon: const Icon(
                      Icons.refresh,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  // Botão de confirmar (✔)
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Confirme a Foto")),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.file(File(imagePath)),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => confirm(context),
//                   child: const Text("Confirmar"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => deny(context),
//                   child: const Text("Negar"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
