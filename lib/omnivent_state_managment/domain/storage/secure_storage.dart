
  import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{


    // Create storage
    FlutterSecureStorage crearAlmacenamiento(){
      return FlutterSecureStorage();
    }

    Future<String> leerValorAlmacenamiento(FlutterSecureStorage storage, String clave) async {
      return await storage.read(key: clave);
    }

    Future<Map<String, String>> leerTodoAlmacenamiento(FlutterSecureStorage storage) async {
      return await storage.readAll();
    }

    Future<void> eliminarValorAlmacenamiento(FlutterSecureStorage storage, String clave) async {
      await storage.delete(key: clave);
    }

    Future<void> eliminarTodoAlmacenamiento(FlutterSecureStorage storage, String clave) async {
      await storage.deleteAll();
    }
    
    Future<void> escribirValorAlmacenamiento(FlutterSecureStorage storage, String clave, String nuevoValor) async {
      await storage.write(key: clave, value: nuevoValor);
    }


}