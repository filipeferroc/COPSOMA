import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class AppState extends ChangeNotifier {
  CameraController? _cameraController;
  Future<void>? _cameraValue;
  List<CameraDescription>? _cameras;
  int? _existingNoteId;

  CameraController? get cameraController => _cameraController;
  Future<void>? get cameraValue => _cameraValue;
  int? get existingNoteId => _existingNoteId;

  Future<void> initializeCamera(List<CameraDescription> cameras) async {
    if (_cameraController != null) return; // Avoid reinitialization

    _cameras = cameras;
    try {
      _cameraController = CameraController(
        _cameras!.first,
        ResolutionPreset.high,
        enableAudio: false,
      );
      _cameraValue = _cameraController!.initialize();
      await _cameraValue;
      notifyListeners();
    } catch (e) {
      print("Erro ao inicializar a câmera: $e");
    }
  }

  void disposeCamera() {
    _cameraController?.dispose();
    _cameraController = null;
    _cameraValue = null;
    notifyListeners();
  }

  // Reset the app state
  void resetAppState() {
    disposeCamera();
    _existingNoteId = null;
    notifyListeners();
  }

  void setExistingNoteId(int noteId) {
    _existingNoteId = noteId;
    notifyListeners();
  }
}

//>>>>>>>>>>>>>

// class AppState extends ChangeNotifier {
//   CameraController? _cameraController;
//   List<CameraDescription>? _cameras;
//   int? _existingNoteId;

//   CameraController? get cameraController => _cameraController;
//   List<CameraDescription>? get cameras => _cameras;
//   int? get existingNoteId => _existingNoteId;

//   // Initialize the camera
//   Future<void> initializeCamera(
//       List<CameraDescription> cameras, int? existingNoteId) async {
//     _cameras = cameras;
//     _existingNoteId = existingNoteId;

//     if (_cameras != null && _cameras!.isNotEmpty) {
//       _cameraController = CameraController(
//         _cameras!.first,
//         ResolutionPreset.high,
//         enableAudio: false,
//       );
//       await _cameraController!.initialize();
//       notifyListeners();
//     }
//   }

//   // Dispose of the camera
//   void disposeCamera() {
//     _cameraController?.dispose();
//     _cameraController = null;
//     notifyListeners();
//   }

//   // Reset the app state
//   void resetAppState() {
//     disposeCamera();
//     _existingNoteId = null;
//     notifyListeners();
//   }
// }
