import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'confirm_photo.dart';
import 'package:provider/provider.dart';

// class PageCamera extends StatefulWidget {
//   final List<CameraDescription> cameras;
//   //const PageCamera({super.key, required this.cameras});
//   const PageCamera({Key? key, required this.cameras}) : super(key: key);

//   @override
//   State<PageCamera> createState() => _PageCameraState();
// }

// class _PageCameraState extends State<PageCamera> {
//   late CameraController cameraController;
//   late Future<void> cameraValue;
//   int? hasNote;

//   void startCamera(int camera) {
//     cameraController = CameraController(
//         //widget.cameras[camera],
//         widget.cameras.first,
//         ResolutionPreset.high,
//         enableAudio: false);
//     cameraValue = cameraController.initialize();

//   }

//   @override
//   void initState() {
//     startCamera(0);
//     super.initState();
//   }

//   Future<void> captureImage() async {
//     try {
//       final image = await cameraController.takePicture();
//       // Navega para a tela de confirmação, passando o caminho da imagem e o estado de `hasNote`
//       await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ConfirmPhoto(
//             imagePath: image.path,
//             hasNote: hasNote,
//             cameras: cameras,
//             onConfirmed: (int newNoteId) {
//               setState(() {
//                 hasNote = newNoteId;
//               });
//             },
//             //cameras: const [],
//           ),
//         ),
//       );
//     } catch (e) {
//       print("Erro ao capturar imagem: $e");
//     }
//   }

//   void finalizar() {
//     setState(() {
//       hasNote = null;
//     });
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'CAMERA',
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
//           FutureBuilder(
//             future: cameraValue,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return CameraPreview(cameraController);
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               color: Colors.white,
//               height: 100,
//               padding: const EdgeInsets.symmetric(horizontal: 32),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Botão de "Cancelar"
//                   IconButton(
//                     onPressed: finalizar,
//                     icon: const Text(
//                       'Finalizar',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ),
//                   // Botão de "Capturar"
//                   Container(
//                     decoration: const BoxDecoration(
//                       color: Color(0x452457C5), // Azul com transparência
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       onPressed: captureImage,
//                       icon: const Icon(Icons.camera_alt,
//                           size: 40, color: Colors.blue),
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

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'confirm_photo.dart';

// class PageCamera extends StatefulWidget {
//   final List<CameraDescription> cameras;
//   final int? existingNoteId; // Adiciona a nota existente, se houver

//   const PageCamera({Key? key, required this.cameras, this.existingNoteId})
//       : super(key: key);
//   //const PageCamera({Key? key, required this.cameras}) : super(key: key);

//   @override
//   State<PageCamera> createState() => _PageCameraState();
// }

// class _PageCameraState extends State<PageCamera> {
//   late CameraController cameraController;
//   late Future<void> cameraValue;
//   int? hasNote; // Variável para armazenar a nota atual

//   @override
//   void initState() {
//     super.initState();
//     hasNote = widget.existingNoteId;
//     startCamera(); // Inicializa a câmera na primeira execução
//   }

//   /// Inicializa a câmera com a primeira câmera disponível
//   void startCamera() async{
//     // cameraController = CameraController(
//     //   widget.cameras.first,
//     //   ResolutionPreset.high,
//     //   enableAudio: false,
//     // );
//     // cameraValue = cameraController.initialize();
//     if (!cameraController.value.isInitialized) {
//     cameraController = CameraController(
//       widget.cameras.first,
//       ResolutionPreset.high,
//       enableAudio: false,
//     );
//     await cameraController.initialize();
//     if (mounted) {
//       setState(() {}); // Update the UI if the widget is still mounted
//     }
//   }
//   }

//   /// Função para capturar a imagem e navegar para a tela de confirmação
//   Future<void> captureImage() async {
//     try {
//       final image = await cameraController.takePicture();

//       //await cameraController.dispose();
//       // Navega para a tela de confirmação
//       await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ConfirmPhoto(
//             imagePath: image.path,
//             hasNote: hasNote,
//             onFinalizar: finalizar,
//             //cameras: widget.cameras, // Passa as câmeras para a próxima tela
//             onConfirmed: (int newNoteId) {
//               setState(() {
//                 hasNote = newNoteId; // Atualiza o estado da nota
//               });
//             },
//           ),
//         ),
//       );
//       await startCamera();
//     } catch (e) {
//       print("Erro ao capturar imagem: $e");
//     }
//   }

//   /// Finaliza o processo, limpando a nota e retornando à tela anterior
//   void finalizar() {
//     setState(() {
//       hasNote = null;
//     });
//     //Navigator.pop(context);
//     Navigator.popUntil(context, (route) => route.isFirst);
//   }

//   @override
//   void dispose() {
//     cameraController.dispose(); // Libera os recursos da câmera ao sair
//     // super.dispose();
//     // if (cameraController.value.isInitialized) {
//     //   cameraController.dispose();
//     // }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'CÂMERA',
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
//           onPressed: finalizar, // Finaliza ao clicar no botão "Fechar"
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
//           FutureBuilder(
//             future: cameraValue,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return CameraPreview(
//                     cameraController); // Mostra o preview da câmera
//               } else {
//                 return const Center(
//                     child:
//                         CircularProgressIndicator()); // Exibe o loading enquanto a câmera inicializa
//               }
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               color: Colors.white,
//               height: 100,
//               padding: const EdgeInsets.symmetric(horizontal: 32),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Botão "Finalizar"
//                   TextButton(
//                     onPressed: finalizar,
//                     child: const Text(
//                       'Finalizar',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ),
//                   // Botão "Capturar"
//                   Container(
//                     decoration: const BoxDecoration(
//                       color: Color(0x452457C5), // Azul com transparência
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       onPressed: captureImage,
//                       icon: const Icon(
//                         Icons.camera_alt,
//                         size: 40,
//                         color: Colors.blue,
//                       ),
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

//>>>>>>>>>>>>>>>>>>>

// class PageCamera extends StatefulWidget {
//   final List<CameraDescription> cameras;
//   final int? existingNoteId;

//   const PageCamera({Key? key, required this.cameras, this.existingNoteId})
//       : super(key: key);

//   @override
//   State<PageCamera> createState() => _PageCameraState();
// }

// class _PageCameraState extends State<PageCamera> {
//   CameraController? cameraController; // Make it nullable
//   Future<void>? cameraValue; // Make it nullable
//   int? hasNote;

//   @override
//   void initState() {
//     super.initState();
//     hasNote = widget.existingNoteId;
//     initializeCamera(); // Initialize the camera
//   }

//   Future<void> initializeCamera() async {
//     try {
//       cameraController = CameraController(
//         widget.cameras.first,
//         ResolutionPreset.high,
//         enableAudio: false,
//       );
//       cameraValue = cameraController!.initialize(); // Initialize the camera
//       await cameraValue; // Wait for initialization to complete
//       if (mounted) {
//         setState(() {}); // Update the UI
//       }
//     } catch (e) {
//       print("Erro ao inicializar a câmera: $e");
//     }
//   }

//   Future<void> captureImage() async {
//     if (cameraController == null || !cameraController!.value.isInitialized) {
//       print("Câmera não inicializada");
//       return;
//     }

//     try {
//       final image = await cameraController!.takePicture();
//       await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ConfirmPhoto(
//             imagePath: image.path,
//             hasNote: hasNote,
//             onFinalizar: finalizar,
//             onConfirmed: (int newNoteId) {
//               setState(() {
//                 hasNote = newNoteId;
//               });
//             },
//           ),
//         ),
//       );
//       // Re-initialize the camera after returning from ConfirmPhoto
//       await initializeCamera();
//     } catch (e) {
//       print("Erro ao capturar imagem: $e");
//     }
//   }

//   void finalizar() {
//     setState(() {
//       hasNote = null;
//     });
//     Navigator.popUntil(context, (route) => route.isFirst);
//   }

//   @override
//   void dispose() {
//     cameraController
//         ?.dispose(); // Dispose of the camera controller if it exists
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'CÂMERA',
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
//           onPressed: finalizar,
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
//           FutureBuilder(
//             future: cameraValue,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (cameraController != null &&
//                     cameraController!.value.isInitialized) {
//                   return CameraPreview(cameraController!);
//                 } else {
//                   return const Center(child: Text("Câmera não inicializada"));
//                 }
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               color: Colors.white,
//               height: 100,
//               padding: const EdgeInsets.symmetric(horizontal: 32),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: finalizar,
//                     child: const Text(
//                       'Finalizar',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                       color: Color(0x452457C5),
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       onPressed: captureImage,
//                       icon: const Icon(
//                         Icons.camera_alt,
//                         size: 40,
//                         color: Colors.blue,
//                       ),
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

// class PageCamera extends StatelessWidget {
//   final List<CameraDescription> cameras;
//   final int? existingNoteId;

//   const PageCamera({Key? key, required this.cameras, this.existingNoteId})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);

//     // Initialize the camera when the screen is built
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       appState.initializeCamera(cameras, existingNoteId);
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CÂMERA'),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2457C5),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.white),
//           onPressed: () {
//             appState.resetAppState();
//             Navigator.popUntil(context, (route) => route.isFirst);
//           },
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
//       body: Consumer<AppState>(
//         builder: (context, appState, child) {
//           if (appState.cameraController == null ||
//               !appState.cameraController!.value.isInitialized) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return Stack(
//             children: [
//               CameraPreview(appState.cameraController!),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   color: Colors.white,
//                   height: 100,
//                   padding: const EdgeInsets.symmetric(horizontal: 32),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           appState.resetAppState();
//                           Navigator.popUntil(context, (route) => route.isFirst);
//                         },
//                         child: const Text(
//                           'Finalizar',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         decoration: const BoxDecoration(
//                           color: Color(0x452457C5),
//                           shape: BoxShape.circle,
//                         ),
//                         child: IconButton(
//                           onPressed: () async {
//                             final image =
//                                 await appState.cameraController!.takePicture();
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ConfirmPhoto(
//                                   imagePath: image.path,
//                                   hasNote: appState.existingNoteId,
//                                   onFinalizar: () {
//                                     appState.resetAppState();
//                                     Navigator.popUntil(
//                                         context, (route) => route.isFirst);
//                                   },
//                                   onConfirmed: (int newNoteId) {
//                                     appState.existingNoteId = newNoteId;
//                                   },
//                                 ),
//                               ),
//                             );
//                           },
//                           icon: const Icon(
//                             Icons.camera_alt,
//                             size: 40,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                     ],
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
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'app_state.dart'; // Import the AppState class
import 'confirm_photo.dart'; // Import the ConfirmPhoto screen

// class PageCamera extends StatelessWidget {
//   final List<CameraDescription> cameras;

//   const PageCamera({super.key, required this.cameras});

//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);

//     // Initialize the camera when the screen is built
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       appState.initializeCamera(cameras, null);
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CÂMERA'),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2457C5),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.white),
//           onPressed: () {
//             appState.resetAppState();
//             Navigator.popUntil(context, (route) => route.isFirst);
//           },
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
//       body: Consumer<AppState>(
//         builder: (context, appState, child) {
//           if (appState.cameraController == null ||
//               !appState.cameraController!.value.isInitialized) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return Stack(
//             children: [
//               CameraPreview(appState.cameraController!),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   color: Colors.white,
//                   height: 100,
//                   padding: const EdgeInsets.symmetric(horizontal: 32),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           appState.resetAppState();
//                           Navigator.popUntil(context, (route) => route.isFirst);
//                         },
//                         child: const Text(
//                           'Finalizar',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         decoration: const BoxDecoration(
//                           color: Color(0x452457C5),
//                           shape: BoxShape.circle,
//                         ),
//                         child: IconButton(
//                           onPressed: () async {
//                             final image =
//                                 await appState.cameraController!.takePicture();
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ConfirmPhoto(
//                                   imagePath: image.path,
//                                   onFinalizar: () {
//                                     appState.resetAppState();
//                                     Navigator.popUntil(
//                                         context, (route) => route.isFirst);
//                                   },
//                                 ),
//                               ),
//                             );
//                           },
//                           icon: const Icon(
//                             Icons.camera_alt,
//                             size: 40,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                     ],
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

// class PageCamera extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const PageCamera({super.key, required this.cameras});

//   @override
//   State<PageCamera> createState() => _PageCameraState();
// }

// class _PageCameraState extends State<PageCamera> {
//   CameraController? _cameraController;
//   Future<void>? _cameraValue;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     try {
//       _cameraController = CameraController(
//         widget.cameras.first,
//         ResolutionPreset.high,
//         enableAudio: false,
//       );
//       _cameraValue = _cameraController!.initialize();
//       await _cameraValue;
//       if (mounted) {
//         setState(() {});
//       }
//     } catch (e) {
//       print("Erro ao inicializar a câmera: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _cameraController?.dispose(); // Dispose of the camera controller
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CÂMERA'),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2457C5),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.white),
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
//       body: FutureBuilder(
//         future: _cameraValue,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (_cameraController != null && _cameraController!.value.isInitialized) {
//               return CameraPreview(_cameraController!);
//             } else {
//               return const Center(child: Text("Câmera não inicializada"));
//             }
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

//>>>>>>>>>>>>>>>>>>
// class PageCamera extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const PageCamera({super.key, required this.cameras});

//   @override
//   State<PageCamera> createState() => _PageCameraState();
// }

// class _PageCameraState extends State<PageCamera> {
//   @override
//   void initState() {
//     super.initState();
//     final appState = Provider.of<AppState>(context, listen: false);
//     appState.initializeCamera(widget.cameras);
//   }

//   @override
//   void dispose() {
//     final appState = Provider.of<AppState>(context, listen: false);
//     appState.disposeCamera(); // Dispose of the camera
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CÂMERA'),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2457C5),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.white),
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
//       body: FutureBuilder(
//         future: appState.cameraValue,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (appState.cameraController != null &&
//                 appState.cameraController!.value.isInitialized) {
//               return CameraPreview(appState.cameraController!);
//             } else {
//               return const Center(child: Text("Câmera não inicializada"));
//             }
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

// class PageCamera extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const PageCamera({super.key, required this.cameras});

//   @override
//   State<PageCamera> createState() => _PageCameraState();
// }

// class _PageCameraState extends State<PageCamera> {
//   @override
//   void initState() {
//     super.initState();
//     final appState = Provider.of<AppState>(context, listen: false);
//     appState.initializeCamera(widget.cameras);
//   }

//   @override
//   void dispose() {
//     final appState = Provider.of<AppState>(context, listen: false);
//     appState.disposeCamera();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CÂMERA'),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2457C5),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.white),
//           onPressed: () {
//             appState.resetAppState();
//             Navigator.popUntil(context, (route) => route.isFirst);
//           },
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
//       body: FutureBuilder(
//         future: appState.cameraValue,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (appState.cameraController != null &&
//                 appState.cameraController!.value.isInitialized) {
//               return Stack(
//                 children: [
//                   CameraPreview(appState.cameraController!),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       color: Colors.white,
//                       height: 100,
//                       padding: const EdgeInsets.symmetric(horizontal: 32),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           TextButton(
//                             onPressed: () {
//                               appState.resetAppState();
//                               Navigator.popUntil(
//                                   context, (route) => route.isFirst);
//                             },
//                             child: const Text(
//                               'Finalizar',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             decoration: const BoxDecoration(
//                               color: Color(0x452457C5),
//                               shape: BoxShape.circle,
//                             ),
//                             child: IconButton(
//                               onPressed: () async {
//                                 final image = await appState.cameraController!
//                                     .takePicture();
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ConfirmPhoto(
//                                       imagePath: image.path,
//                                       onFinalizar: () {
//                                         appState.resetAppState();
//                                         Navigator.popUntil(
//                                             context, (route) => route.isFirst);
//                                       },
//                                       hasNote: hasNote,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               icon: const Icon(
//                                 Icons.camera_alt,
//                                 size: 40,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             } else {
//               return const Center(child: Text("Câmera não inicializada"));
//             }
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

class PageCamera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final int? existingNoteId;

  const PageCamera({super.key, required this.cameras, this.existingNoteId});

  @override
  State<PageCamera> createState() => _PageCameraState();
}

class _PageCameraState extends State<PageCamera> {
  int? hasNote;

  @override
  void initState() {
    super.initState();
    hasNote = widget.existingNoteId;
    final appState = Provider.of<AppState>(context, listen: false);
    appState.initializeCamera(widget.cameras);
  }

  //Algumas vezes não permite clicar nos botões da home
  @override
  void dispose() {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.disposeCamera();
    super.dispose();
  }

  void finalizar() {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.resetAppState();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  Future<void> captureImage() async {
    final appState = Provider.of<AppState>(context, listen: false);
    if (appState.cameraController == null ||
        !appState.cameraController!.value.isInitialized) {
      print("Câmera não inicializada");
      return;
    }

    try {
      final image = await appState.cameraController!.takePicture();
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPhoto(
            imagePath: image.path,
            hasNote: hasNote,
            onFinalizar: finalizar,
            onConfirmed: (int newNoteId) {
              setState(() {
                hasNote = newNoteId;
              });
              appState.setExistingNoteId(newNoteId);
            },
          ),
        ),
      );
    } catch (e) {
      print("Erro ao capturar imagem: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CÂMERA',
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
          onPressed: finalizar,
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
      body: FutureBuilder(
        future: appState.cameraValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (appState.cameraController != null &&
                appState.cameraController!.value.isInitialized) {
              return Stack(
                children: [
                  CameraPreview(appState.cameraController!),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      height: 100,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: finalizar,
                            child: const Text(
                              'Finalizar',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0x452457C5),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: captureImage,
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text("Câmera não inicializada"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
