// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'page_camera.dart';

// class ResultadoScreen extends StatelessWidget {
//   final int resultadoUltimaPredicao;
//   final double resultadoTotal;
//   final VoidCallback onFinalizar;
//   //final int? existingNoteId;
//   //final List<CameraDescription> cameras;

//   ResultadoScreen({
//     super.key,
//     required this.resultadoUltimaPredicao,
//     required this.resultadoTotal,
//     required this.onFinalizar,
//     //required this.existingNoteId,
//     //required this.cameras,
//   });

//   @override
//   Widget build(BuildContext context) {
//     //int? hasNote = existingNoteId;
//     return WillPopScope(
//       onWillPop: () async => false, // Desabilita o botão de voltar
//       child: Scaffold(
//         backgroundColor: const Color(0xFF2457C5), // Fundo azul
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Resultado da última predição
//             Text(
//               '$resultadoUltimaPredicao',
//               style: const TextStyle(
//                 fontSize: 80,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Texto "Resultado total"
//             const Text(
//               'Resultado total',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Valor do resultado total
//             Text(
//               '$resultadoTotal',
//               style: const TextStyle(
//                 fontSize: 60,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Spacer(),
//             // Botões na parte inferior
//             Container(
//               color: Colors.white,
//               padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Botão de adicionar imagem (voltar para a câmera)
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => PageCamera(
//                       //         cameras: cameras, existingNoteId: hasNote),
//                       //   ),
//                       // );
//                     },
//                     icon: const Icon(
//                       Icons.add_photo_alternate,
//                       size: 40,
//                       color: Color(0xFF2457C5),
//                     ),
//                   ),
//                   // Botão de finalizar
//                   ElevatedButton(
//                     onPressed: () {
//                       onFinalizar();
//                       Navigator.popUntil(context, (route) => route.isFirst);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF2457C5),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12, horizontal: 24),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       'Finalizar',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//>>>>>>>>>>>>>>>>>>>>>>>

// import 'package:flutter/material.dart';
// import '../database/database_helper.dart';

// class PageResultado extends StatelessWidget {
//   const PageResultado({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Obtém o argumento passado para a rota
//     final int noteId = ModalRoute.of(context)!.settings.arguments as int;

//     return FutureBuilder<Map<String, dynamic>?>(
//       future: DatabaseHelper().getNota(noteId),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (!snapshot.hasData || snapshot.data == null) {
//           return Scaffold(
//             appBar: AppBar(title: const Text('Resultado')),
//             body: const Center(child: Text('Nenhuma nota encontrada.')),
//           );
//         }

//         final nota = snapshot.data!;
//         return Scaffold(
//           appBar: AppBar(title: const Text('Resultado')),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'ID da Nota: ${nota['id']}',
//                   style: const TextStyle(fontSize: 20),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Valor da Nota: ${nota['valor'].toStringAsFixed(2)}',
//                   style: const TextStyle(
//                       fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'page_camera.dart';
import 'app_state.dart';

// class ResultadoScreen extends StatelessWidget {
//   final int resultadoUltimaPredicao;
//   final double resultadoTotal;

//   const ResultadoScreen({
//     super.key,
//     required this.resultadoUltimaPredicao,
//     required this.resultadoTotal,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);

//     return WillPopScope(
//       onWillPop: () async => false, // Desabilita o botão de voltar
//       child: Scaffold(
//         backgroundColor: const Color(0xFF2457C5), // Fundo azul
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Resultado da última predição
//             Text(
//               '$resultadoUltimaPredicao',
//               style: const TextStyle(
//                 fontSize: 80,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Texto "Resultado total"
//             const Text(
//               'Resultado total',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Valor do resultado total
//             Text(
//               '$resultadoTotal',
//               style: const TextStyle(
//                 fontSize: 60,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Spacer(),
//             // Botões na parte inferior
//             Container(
//               color: Colors.white,
//               padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Botão de adicionar imagem (voltar para a câmera)
//                   IconButton(
//                     onPressed: () async {
//                       final cameras = await availableCameras();
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PageCamera(
//                             cameras: cameras,
//                             existingNoteId: appState.existingNoteId,
//                           ),
//                         ),
//                       );
//                     },
//                     icon: const Icon(
//                       Icons.add_photo_alternate,
//                       size: 40,
//                       color: Color(0xFF2457C5),
//                     ),
//                   ),
//                   // Botão de finalizar
//                   ElevatedButton(
//                     onPressed: () {
//                       Future.microtask(() {
//                         Provider.of<AppState>(context, listen: false)
//                             .resetAppState();
//                         Navigator.popUntil(context, (route) => route.isFirst);
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF2457C5),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12, horizontal: 24),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       'Finalizar',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'page_camera.dart';
import 'app_state.dart';

class ResultadoScreen extends StatelessWidget {
  final int resultadoUltimaPredicao;
  final double resultadoTotal;

  const ResultadoScreen({
    super.key,
    required this.resultadoUltimaPredicao,
    required this.resultadoTotal,
  });

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return WillPopScope(
      onWillPop: () async => false, // Desabilita o botão de voltar
      child: Scaffold(
        backgroundColor: const Color(0xFF2457C5), // Fundo azul
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2), // Adiciona espaço no topo
            // Resultado da última predição
            Text(
              '$resultadoUltimaPredicao',
              style: const TextStyle(
                fontSize: 80,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Texto "Resultado total"
            const Text(
              'Resultado total',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Valor do resultado total
            Text(
              '$resultadoTotal',
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(flex: 3), // Adiciona espaço no meio
            // Botões na parte inferior
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão de adicionar imagem (voltar para a câmera)
                  IconButton(
                    onPressed: () async {
                      final cameras = await availableCameras();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageCamera(
                            cameras: cameras,
                            existingNoteId: appState.existingNoteId,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add_photo_alternate,
                      size: 40,
                      color: Color(0xFF2457C5),
                    ),
                  ),
                  // Botão de finalizar
                  ElevatedButton(
                    onPressed: () {
                      Future.microtask(() {
                        Provider.of<AppState>(context, listen: false)
                            .resetAppState();
                        Navigator.popUntil(context, (route) => route.isFirst);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2457C5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Finalizar',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
