import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'confirm_photo.dart';

class PageCamera extends StatefulWidget {
  final List<CameraDescription> cameras;
  const PageCamera({super.key, required this.cameras});

  @override
  State<PageCamera> createState() => _PageCameraState();
}

class _PageCameraState extends State<PageCamera> {
  late CameraController cameraController;
  late Future<void> cameraValue;
  int? hasNote;

  void startCamera(int camera) {
    cameraController = CameraController(
        widget.cameras[camera], ResolutionPreset.high,
        enableAudio: false);
    cameraValue = cameraController.initialize();
  }

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  Future<void> captureImage() async {
    try {
      final image = await cameraController.takePicture();
      // Navega para a tela de confirmação, passando o caminho da imagem e o estado de `hasNote`
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPhoto(
            imagePath: image.path,
            hasNote: hasNote,
            onConfirmed: (int newNoteId) {
              setState(() {
                hasNote = newNoteId;
              });
            },
          ),
        ),
      );
    } catch (e) {
      print("Erro ao capturar imagem: $e");
    }
  }

  void finalizar() {
    setState(() {
      hasNote = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CAMERA',
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
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(cameraController);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão de "Cancelar"
                  IconButton(
                    onPressed: finalizar,
                    icon: const Text(
                      'Finalizar',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  // Botão de "Capturar"
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0x452457C5), // Azul com transparência
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: captureImage,
                      icon: const Icon(Icons.camera_alt,
                          size: 40, color: Colors.blue),
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
