import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:image/image.dart' as image;

// image.Image imageFromBase64String(String base64String) {
//   return Image.memory(base64Decode(base64String));
// }

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

String base64ListToString(Int64List list) {
  return base64Encode(list);
}

Future<ui.Image> getUiImage(image.Image myImage, int height, int width) async {
  image.Image resizeImage =
      image.copyResize(myImage, height: height, width: width);

  ui.Codec codec =
      await ui.instantiateImageCodec(image.encodePng(resizeImage) as Uint8List);
  ui.FrameInfo frameInfo = await codec.getNextFrame();
  return frameInfo.image;
}
