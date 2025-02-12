import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ARViewPage extends StatefulWidget {
  @override
  _ARViewPageState createState() => _ARViewPageState();
}

class _ARViewPageState extends State<ARViewPage> {
  ArCoreController? arCoreController;
  ARKitController? arKitController;

  @override
  void dispose() {
    arCoreController?.dispose();
    arKitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Virtual Showroom'),
        backgroundColor: Color(0xFF26547D),
      ),
      body: _buildARView(),
      floatingActionButton: !kIsWeb
          ? FloatingActionButton(
        onPressed: _addObject,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF26547D),
      )
          : null,
    );
  }

  Widget _buildARView() {
    if (kIsWeb) {
      return _buildWebARView();
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      return ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      );
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      return ARKitSceneView(
        onARKitViewCreated: _onARKitViewCreated,
      );
    } else {
      return Center(
        child: Text(
          'AR is not supported on this platform.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
  }

  Widget _buildWebARView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Explore in 3D',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF26547D),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ModelViewer(
                src: 'assets/animations/chair.glb',
                alt: 'A 3D model of a chair',
                ar: true,
                autoRotate: true,
                cameraControls: true,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Use the controls to interact with the 3D model.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addObject();
  }

  void _onARKitViewCreated(ARKitController controller) {
    arKitController = controller;
    _addObject();
  }

  void _addObject() {
    if (arCoreController != null) {
      final node = ArCoreNode(
        shape: ArCoreSphere(
          materials: [
            ArCoreMaterial(
              color: Colors.blue,
            ),
          ],
          radius: 0.1,
        ),
        position: vector.Vector3(0, 0, -1),
      );
      arCoreController!.addArCoreNode(node);
    } else if (arKitController != null) {
      final node = ARKitNode(
        geometry: ARKitSphere(
          radius: 0.1,
          materials: [
            ARKitMaterial(
              diffuse: ARKitMaterialProperty.color(Colors.blue),
            ),
          ],
        ),
        position: vector.Vector3(0, 0, -1),
      );
      arKitController!.add(node);
    }
  }
}