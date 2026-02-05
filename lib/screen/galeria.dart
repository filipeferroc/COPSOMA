// import 'package:flutter/material.dart';
// import '../database/database_helper.dart';
// import 'dart:io';

// class GaleriaPage extends StatefulWidget {
//   const GaleriaPage({super.key});

//   @override
//   State<GaleriaPage> createState() => _GaleriaPageState();
// }

// class _GaleriaPageState extends State<GaleriaPage> {
//   final dbHelper = DatabaseHelper();

//   Future<List<Map<String, dynamic>>> _loadNotas() async {
//     return await dbHelper.getNotas();
//   }

//   Future<List<Map<String, dynamic>>> _loadImagens(int notaId) async {
//     return await dbHelper.getImagensByNota(notaId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Galeria de Notas')),
//       body: FutureBuilder(
//         future: _loadNotas(),
//         builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final notas = snapshot.data!;
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3),
//             itemCount: notas.length,
//             itemBuilder: (context, index) {
//               final nota = notas[index];
//               return GestureDetector(
//                 onTap: () async {
//                   final imagens = await _loadImagens(nota['id']);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ImagensPage(imagens: imagens),
//                     ),
//                   );
//                 },
//                 child: Card(
//                   child: Center(child: Text('Nota ID: ${nota['id']}')),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class ImagensPage extends StatelessWidget {
//   final List<Map<String, dynamic>> imagens;
//   const ImagensPage({super.key, required this.imagens});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Imagens')),
//       body: GridView.builder(
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//         itemCount: imagens.length,
//         itemBuilder: (context, index) {
//           final imagem = imagens[index];
//           return Image.file(File(imagem['srcPath']));
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'dart:io';

// class GaleriaPage extends StatefulWidget {
//   const GaleriaPage({super.key});

//   @override
//   State<GaleriaPage> createState() => _GaleriaPageState();
// }

// class _GaleriaPageState extends State<GaleriaPage> {
//   final dbHelper = DatabaseHelper();

//   // Controle do modo de exclusão
//   bool isDeleting = false;
//   Set<int> selectedNotas = {};

//   Future<List<Map<String, dynamic>>> _loadNotas() async {
//     return await dbHelper.getNotas();
//   }

//   Future<List<Map<String, dynamic>>> _loadImagens(int notaId) async {
//     return await dbHelper.getImagensByNota(notaId);
//   }

//   Future<void> _deleteSelectedNotas() async {
//     for (int notaId in selectedNotas) {
//       // Excluir imagens vinculadas
//       final imagens = await _loadImagens(notaId);
//       for (var imagem in imagens) {
//         final file = File(imagem['srcPath']);
//         if (file.existsSync()) {
//           file.deleteSync();
//         }
//       }
//       // Excluir nota
//       await dbHelper.deleteNota(notaId);
//     }

//     // Resetar o modo de exclusão
//     setState(() {
//       isDeleting = false;
//       selectedNotas.clear();
//     });
//   }

//   void _toggleSelectionMode(int notaId) {
//     setState(() {
//       if (selectedNotas.contains(notaId)) {
//         selectedNotas.remove(notaId);
//         if (selectedNotas.isEmpty) {
//           isDeleting = false;
//         }
//       } else {
//         selectedNotas.add(notaId);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Galeria de Notas')),
//       body: FutureBuilder(
//         future: _loadNotas(),
//         builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final notas = snapshot.data!;
//           return Stack(
//             children: [
//               GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3),
//                 itemCount: notas.length,
//                 itemBuilder: (context, index) {
//                   final nota = notas[index];
//                   final notaId = nota['id'];
//                   final isSelected = selectedNotas.contains(notaId);

//                   return GestureDetector(
//                     onTap: () async {
//                       if (isDeleting) {
//                         _toggleSelectionMode(notaId);
//                       } else {
//                         final imagens = await _loadImagens(notaId);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ImagensPage(imagens: imagens),
//                           ),
//                         );
//                       }
//                     },
//                     onLongPress: () {
//                       setState(() {
//                         isDeleting = true;
//                         selectedNotas.add(notaId); // Seleciona a nota inicial
//                       });
//                     },
//                     child: Stack(
//                       children: [
//                         Card(
//                           child: Center(child: Text('Nota ID: $notaId')),
//                         ),
//                         if (isDeleting)
//                           Positioned(
//                             top: 5,
//                             left: 5,
//                             child: Checkbox(
//                               value: isSelected,
//                               onChanged: (_) => _toggleSelectionMode(notaId),
//                             ),
//                           ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               if (isDeleting)
//                 Positioned(
//                   bottom: 20,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: ElevatedButton.icon(
//                       onPressed: _deleteSelectedNotas,
//                       icon: const Icon(Icons.delete),
//                       label: const Text('Excluir Selecionados'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             const Color(0xFF2457C5).withOpacity(0.85),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class ImagensPage extends StatelessWidget {
//   final List<Map<String, dynamic>> imagens;
//   const ImagensPage({super.key, required this.imagens});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Imagens')),
//       body: GridView.builder(
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//         itemCount: imagens.length,
//         itemBuilder: (context, index) {
//           final imagem = imagens[index];
//           return Image.file(File(imagem['srcPath']));
//         },
//       ),
//     );
//   }
// }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>

// class GaleriaPage extends StatefulWidget {
//   const GaleriaPage({super.key});

//   @override
//   State<GaleriaPage> createState() => _GaleriaPageState();
// }

// class _GaleriaPageState extends State<GaleriaPage> {
//   final dbHelper = DatabaseHelper();

//   // Controle do modo de exclusão
//   bool isDeleting = false;
//   Set<int> selectedNotas = {};

//   Future<List<Map<String, dynamic>>> _loadNotas() async {
//     return await dbHelper.getNotas();
//   }

//   Future<List<Map<String, dynamic>>> _loadImagens(int notaId) async {
//     return await dbHelper.getImagensByNota(notaId);
//   }

//   Future<void> _deleteSelectedNotas() async {
//     for (int notaId in selectedNotas) {
//       // Excluir imagens vinculadas
//       final imagens = await _loadImagens(notaId);
//       for (var imagem in imagens) {
//         final file = File(imagem['srcPath']);
//         if (file.existsSync()) {
//           file.deleteSync();
//         }
//       }
//       // Excluir nota
//       await dbHelper.deleteNota(notaId);
//     }

//     // Resetar o modo de exclusão
//     setState(() {
//       isDeleting = false;
//       selectedNotas.clear();
//     });
//   }

//   void _toggleSelectionMode(int notaId) {
//     setState(() {
//       if (selectedNotas.contains(notaId)) {
//         selectedNotas.remove(notaId);
//         if (selectedNotas.isEmpty) {
//           isDeleting = false;
//         }
//       } else {
//         selectedNotas.add(notaId);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'NOTAS',
//           style: TextStyle(
//               fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2457C5),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           Padding(
//             padding:
//                 const EdgeInsets.only(right: 16.0), // Espaço à direita do logo
//             child: Image.asset(
//               'lib/images/logo_branco_sem_fundo.png', // Caminho do logo
//               height: 40, // Altura do logo
//               width: 40, // Largura do logo
//               fit: BoxFit.contain, // Ajusta a imagem para não distorcer
//             ),
//           ),
//         ],
//       ),
//       body: FutureBuilder(
//         future: _loadNotas(),
//         builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final notas = snapshot.data!;
//           return Stack(
//             children: [
//               // Grade de notas
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 36,
//                     mainAxisSpacing: 36,
//                   ),
//                   itemCount: notas.length,
//                   itemBuilder: (context, index) {
//                     final nota = notas[index];
//                     final notaId = nota['id'];
//                     final valorNota = nota['id'].toString(); // Mostra o ID
//                     final isSelected = selectedNotas.contains(notaId);

//                     return GestureDetector(
//                       onTap: () async {
//                         if (isDeleting) {
//                           _toggleSelectionMode(notaId);
//                         } else {
//                           final imagens = await _loadImagens(notaId);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   ImagensPage(imagens: imagens),
//                             ),
//                           );
//                         }
//                       },
//                       onLongPress: () {
//                         setState(() {
//                           isDeleting = true;
//                           selectedNotas.add(notaId); // Seleciona a nota inicial
//                         });
//                       },
//                       child: Stack(
//                         children: [
//                           // Botão da nota
//                           Container(
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF2457C5),
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 valorNota,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // Checkbox de seleção no modo de exclusão
//                           if (isDeleting)
//                             Positioned(
//                               top: -5,
//                               right:
//                                   -5, // Posicionado no canto superior direito
//                               child: Checkbox(
//                                 value: isSelected,
//                                 onChanged: (_) => _toggleSelectionMode(notaId),
//                               ),
//                             ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               // Botão de exclusão no modo de exclusão
//               if (isDeleting)
//                 Positioned(
//                   bottom: 20,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: ElevatedButton.icon(
//                       onPressed: _deleteSelectedNotas,
//                       icon: const Icon(Icons.delete),
//                       label: const Text(
//                         'Excluir',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             const Color(0xFF2457C5).withOpacity(0.85),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class ImagensPage extends StatelessWidget {
//   final List<Map<String, dynamic>> imagens;
//   const ImagensPage({super.key, required this.imagens});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'IMAGENS',
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
//             Icons.arrow_back,
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
//       body: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // Duas imagens por linha
//           crossAxisSpacing: 8.0, // Espaçamento horizontal
//           mainAxisSpacing: 8.0, // Espaçamento vertical
//           childAspectRatio: 1, // Proporção de aspecto 1:1 (quadrado)
//         ),
//         padding: const EdgeInsets.all(8.0), // Margem do grid
//         itemCount: imagens.length,
//         itemBuilder: (context, index) {
//           final imagem = imagens[index];
//           return Stack(
//             children: [
//               // Imagem
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0), // Borda arredondada
//                   color: Colors.grey.shade300, // Cor de fundo (placeholder)
//                   image: DecorationImage(
//                     image: FileImage(File(imagem['srcPath'])),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               // Número azul no canto inferior direito
//               Positioned(
//                 bottom: 5,
//                 right: 5,
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(4.0),
//                   ),
//                   child: Text(
//                     imagem['id_nota']
//                         .toString(), // Substitua depois pelo valor calculado
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// class GaleriaPage extends StatefulWidget {
//   const GaleriaPage({super.key});

//   @override
//   State<GaleriaPage> createState() => _GaleriaPageState();
// }

// class _GaleriaPageState extends State<GaleriaPage> {
//   final dbHelper = DatabaseHelper();

//   // Controle do modo de exclusão
//   bool isDeleting = false;
//   Set<int> selectedNotas = {};

//   Future<List<Map<String, dynamic>>> _loadNotas() async {
//     return await dbHelper.getNotas();
//   }

//   Future<List<Map<String, dynamic>>> _loadImagens(int notaId) async {
//     return await dbHelper.getImagensByNota(notaId);
//   }

//   Future<void> _deleteSelectedNotas() async {
//     for (int notaId in selectedNotas) {
//       // Excluir imagens vinculadas
//       final imagens = await _loadImagens(notaId);
//       for (var imagem in imagens) {
//         final file = File(imagem['srcPath']);
//         if (file.existsSync()) {
//           file.deleteSync();
//         }
//       }
//       // Excluir nota
//       await dbHelper.deleteNota(notaId);
//     }

//     // Resetar o modo de exclusão
//     setState(() {
//       isDeleting = false;
//       selectedNotas.clear();
//     });
//   }

//   void _toggleSelectionMode(int notaId) {
//     setState(() {
//       if (selectedNotas.contains(notaId)) {
//         selectedNotas.remove(notaId);
//         if (selectedNotas.isEmpty) {
//           isDeleting = false;
//         }
//       } else {
//         selectedNotas.add(notaId);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'NOTAS',
//           style: TextStyle(
//               fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2457C5),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           Padding(
//             padding:
//                 const EdgeInsets.only(right: 16.0), // Espaço à direita do logo
//             child: Image.asset(
//               'lib/images/logo_branco_sem_fundo.png', // Caminho do logo
//               height: 40, // Altura do logo
//               width: 40, // Largura do logo
//               fit: BoxFit.contain, // Ajusta a imagem para não distorcer
//             ),
//           ),
//         ],
//       ),
//       body: FutureBuilder(
//         future: _loadNotas(),
//         builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final notas = snapshot.data!;
//           return Stack(
//             children: [
//               // Grade de notas
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 36,
//                     mainAxisSpacing: 36,
//                   ),
//                   itemCount: notas.length,
//                   itemBuilder: (context, index) {
//                     final nota = notas[index];
//                     final notaId = nota['id'];
//                     final valorNota =
//                         nota['valor'].toString(); // Mostra o valor da nota
//                     final isSelected = selectedNotas.contains(notaId);

//                     return GestureDetector(
//                       onTap: () async {
//                         if (isDeleting) {
//                           _toggleSelectionMode(notaId);
//                         } else {
//                           final imagens = await _loadImagens(notaId);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   ImagensPage(imagens: imagens),
//                             ),
//                           );
//                         }
//                       },
//                       onLongPress: () {
//                         setState(() {
//                           isDeleting = true;
//                           selectedNotas.add(notaId); // Seleciona a nota inicial
//                         });
//                       },
//                       child: Stack(
//                         children: [
//                           // Botão da nota
//                           Container(
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF2457C5),
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 valorNota,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // Checkbox de seleção no modo de exclusão
//                           if (isDeleting)
//                             Positioned(
//                               top: -5,
//                               right:
//                                   -5, // Posicionado no canto superior direito
//                               child: Checkbox(
//                                 value: isSelected,
//                                 onChanged: (_) => _toggleSelectionMode(notaId),
//                               ),
//                             ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               // Botão de exclusão no modo de exclusão
//               if (isDeleting)
//                 Positioned(
//                   bottom: 20,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: ElevatedButton.icon(
//                       onPressed: _deleteSelectedNotas,
//                       icon: const Icon(Icons.delete),
//                       label: const Text(
//                         'Excluir',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             const Color(0xFF2457C5).withOpacity(0.85),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class ImagensPage extends StatelessWidget {
//   final List<Map<String, dynamic>> imagens;
//   const ImagensPage({super.key, required this.imagens});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'IMAGENS',
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
//             Icons.arrow_back,
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
//       body: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // Duas imagens por linha
//           crossAxisSpacing: 8.0, // Espaçamento horizontal
//           mainAxisSpacing: 8.0, // Espaçamento vertical
//           childAspectRatio: 1, // Proporção de aspecto 1:1 (quadrado)
//         ),
//         padding: const EdgeInsets.all(8.0), // Margem do grid
//         itemCount: imagens.length,
//         itemBuilder: (context, index) {
//           final imagem = imagens[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FullScreenImagePage(
//                     imagePath: imagem['srcPath'],
//                   ),
//                 ),
//               );
//             },
//             child: Stack(
//               children: [
//                 // Imagem
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius:
//                         BorderRadius.circular(8.0), // Borda arredondada
//                     color: Colors.grey.shade300, // Cor de fundo (placeholder)
//                     image: DecorationImage(
//                       image: FileImage(File(imagem['srcPath'])),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 // Número azul no canto inferior direito
//                 Positioned(
//                   bottom: 5,
//                   right: 5,
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(4.0),
//                     ),
//                     child: Text(
//                       imagem['id_nota'].toString(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class FullScreenImagePage extends StatelessWidget {
//   final String imagePath;

//   const FullScreenImagePage({super.key, required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'IMAGEM',
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
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Center(
//         child: Image.file(
//           File(imagePath),
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }

class GaleriaPage extends StatefulWidget {
  const GaleriaPage({super.key});

  @override
  State<GaleriaPage> createState() => _GaleriaPageState();
}

class _GaleriaPageState extends State<GaleriaPage> {
  final dbHelper = DatabaseHelper();

  // Controle do modo de exclusão
  bool isDeleting = false;
  Set<int> selectedNotas = {};

  Future<List<Map<String, dynamic>>> _loadNotas() async {
    return await dbHelper.getNotas();
  }

  Future<List<Map<String, dynamic>>> _loadImagens(int notaId) async {
    return await dbHelper.getImagensByNota(notaId);
  }

  Future<void> _deleteSelectedNotas() async {
    for (int notaId in selectedNotas) {
      // Excluir imagens vinculadas
      final imagens = await _loadImagens(notaId);
      for (var imagem in imagens) {
        final file = File(imagem['srcPath']);
        if (file.existsSync()) {
          file.deleteSync();
        }
      }
      // Excluir nota
      await dbHelper.deleteNota(notaId);
    }

    // Resetar o modo de exclusão
    setState(() {
      isDeleting = false;
      selectedNotas.clear();
    });
  }

  void _toggleSelectionMode(int notaId) {
    setState(() {
      if (selectedNotas.contains(notaId)) {
        selectedNotas.remove(notaId);
        if (selectedNotas.isEmpty) {
          isDeleting = false;
        }
      } else {
        selectedNotas.add(notaId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NOTAS',
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2457C5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: 16.0), // Espaço à direita do logo
            child: Image.asset(
              'lib/images/logo_branco_sem_fundo.png', // Caminho do logo
              height: 40, // Altura do logo
              width: 40, // Largura do logo
              fit: BoxFit.contain, // Ajusta a imagem para não distorcer
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadNotas(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final notas = snapshot.data!;
          return Stack(
            children: [
              // Grade de notas
              Padding(
                padding: const EdgeInsets.all(8.0), // Margem menor
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Duas colunas
                    crossAxisSpacing: 8.0, // Espaçamento horizontal
                    mainAxisSpacing: 8.0, // Espaçamento vertical
                    childAspectRatio: 0.7, // Proporção de aspecto (portrait)
                  ),
                  itemCount: notas.length,
                  itemBuilder: (context, index) {
                    final nota = notas[index];
                    final notaId = nota['id'];
                    final valorNota = nota['valor'].toString(); // Valor da nota
                    final isSelected = selectedNotas.contains(notaId);

                    return FutureBuilder(
                      future: _loadImagens(notaId),
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Container(); // Retorna um container vazio se não houver imagens
                        }
                        final primeiraImagem = snapshot.data!.first;

                        return GestureDetector(
                          onTap: () async {
                            if (isDeleting) {
                              _toggleSelectionMode(notaId);
                            } else {
                              final imagens = await _loadImagens(notaId);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ImagensPage(imagens: imagens),
                                ),
                              );
                            }
                          },
                          onLongPress: () {
                            setState(() {
                              isDeleting = true;
                              selectedNotas
                                  .add(notaId); // Seleciona a nota inicial
                            });
                          },
                          child: Stack(
                            children: [
                              // Widget da nota
                              Container(
                                margin:
                                    const EdgeInsets.all(4.0), // Margem pequena
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300, // Cor de fundo
                                  image: DecorationImage(
                                    image: FileImage(
                                        File(primeiraImagem['srcPath'])),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Valor da nota no canto inferior direito
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    valorNota,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              // Checkbox de seleção no modo de exclusão
                              if (isDeleting)
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Checkbox(
                                    value: isSelected,
                                    onChanged: (_) =>
                                        _toggleSelectionMode(notaId),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // Botão de exclusão no modo de exclusão
              if (isDeleting)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: _deleteSelectedNotas,
                      icon: const Icon(Icons.delete),
                      label: const Text(
                        'Excluir',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF2457C5).withOpacity(0.85),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class ImagensPage extends StatelessWidget {
  final List<Map<String, dynamic>> imagens;
  const ImagensPage({super.key, required this.imagens});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IMAGENS',
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
            Icons.arrow_back,
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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Duas colunas
          crossAxisSpacing: 8.0, // Espaçamento horizontal
          mainAxisSpacing: 8.0, // Espaçamento vertical
          childAspectRatio: 0.7, // Proporção de aspecto (portrait)
        ),
        padding: const EdgeInsets.all(8.0), // Margem do grid
        itemCount: imagens.length,
        itemBuilder: (context, index) {
          final imagem = imagens[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImagePage(
                    imagePath: imagem['srcPath'],
                    valorImagem: imagem['valor'].toString(),
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                // Imagem
                Container(
                  margin: const EdgeInsets.all(4.0), // Margem pequena
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300, // Cor de fundo
                    image: DecorationImage(
                      image: FileImage(File(imagem['srcPath'])),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Valor da imagem no canto superior direito
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      imagem['valor'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final String imagePath;
  final String valorImagem;

  const FullScreenImagePage({
    super.key,
    required this.imagePath,
    required this.valorImagem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IMAGEM',
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
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Imagem em tela cheia
          Center(
            child: Image.file(
              File(imagePath),
              fit: BoxFit.contain,
            ),
          ),
          // Valor da imagem no canto superior direito
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                valorImagem,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
