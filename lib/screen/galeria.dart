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
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 36,
                    mainAxisSpacing: 36,
                  ),
                  itemCount: notas.length,
                  itemBuilder: (context, index) {
                    final nota = notas[index];
                    final notaId = nota['id'];
                    final valorNota = nota['id'].toString(); // Mostra o ID
                    final isSelected = selectedNotas.contains(notaId);

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
                          selectedNotas.add(notaId); // Seleciona a nota inicial
                        });
                      },
                      child: Stack(
                        children: [
                          // Botão da nota
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF2457C5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                valorNota,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Checkbox de seleção no modo de exclusão
                          if (isDeleting)
                            Positioned(
                              top: -5,
                              right:
                                  -5, // Posicionado no canto superior direito
                              child: Checkbox(
                                value: isSelected,
                                onChanged: (_) => _toggleSelectionMode(notaId),
                              ),
                            ),
                        ],
                      ),
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
          crossAxisCount: 2, // Duas imagens por linha
          crossAxisSpacing: 8.0, // Espaçamento horizontal
          mainAxisSpacing: 8.0, // Espaçamento vertical
          childAspectRatio: 1, // Proporção de aspecto 1:1 (quadrado)
        ),
        padding: const EdgeInsets.all(8.0), // Margem do grid
        itemCount: imagens.length,
        itemBuilder: (context, index) {
          final imagem = imagens[index];
          return Stack(
            children: [
              // Imagem
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), // Borda arredondada
                  color: Colors.grey.shade300, // Cor de fundo (placeholder)
                  image: DecorationImage(
                    image: FileImage(File(imagem['srcPath'])),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Número azul no canto inferior direito
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    imagem['id_nota']
                        .toString(), // Substitua depois pelo valor calculado
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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
