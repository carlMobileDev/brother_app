import 'dart:io';

import 'package:brother_app/db/db.dart';
import 'package:brother_app/util/custom_theme.dart';
import 'package:brother_app/util/image_helper.dart' as imageHelper;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CreateItemPage extends StatefulWidget {
  @override
  _CreateItemPageState createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  String PLACEHOLDER_IMAGE = 'assets/images/placeholder_product_image.png';
  ThemeData _themeData = myTheme();
  final _formKey = GlobalKey<FormBuilderState>();
  bool _inventoryAmountHasError = false;
  bool _priceHasError = false;
  bool _nameHasError = false;
  File? _productImage;
  late String _placeholderImage;

  void initState() {
    super.initState();
    loadPlaceholderImage();
  }

  void loadPlaceholderImage() async {
    ByteData image =
        await rootBundle.load('assets/images/placeholder_product_image.png');
    _placeholderImage = imageHelper.base64String(image.buffer.asUint8List());
  }

  void _getImage(BuildContext context, ImageSource source) async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: source, maxWidth: 400, maxHeight: 400);
    if (pickedFile != null)
      setState(() {
        _productImage = File(pickedFile.path);
      });
  }

  _cameraPermissionRequest(ImageSource source) async {
    if (await Permission.camera.request().isGranted) {
      _getImage(context, source);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _themeData.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: _themeData.appBarTheme.backgroundColor,
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Image Picker
                          (_productImage != null)
                              ? Image.file(_productImage!)
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                      MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            _getImage(
                                                context, ImageSource.gallery);
                                          });
                                        },
                                        child: Text("Upload from Gallery",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: myTheme().accentColor,
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            _cameraPermissionRequest(
                                                ImageSource.camera);
                                          });
                                        },
                                        child: Text("Upload new Photo",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: myTheme().accentColor,
                                      )
                                    ]),
                          SizedBox(height: 35),

                          FormBuilderTextField(
                            initialValue: "",
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            name: 'name',
                            decoration: InputDecoration(
                                labelText: 'Product Name',
                                prefixIcon:
                                    Icon(Icons.drive_file_rename_outline),
                                suffixIcon: _nameHasError
                                    ? Icon(Icons.error, color: Colors.red)
                                    : Icon(Icons.check, color: Colors.green)),
                            onChanged: (val) {
                              setState(() {
                                if (_formKey.currentState?.fields['name']?.value
                                        .length() >
                                    1) {
                                  _nameHasError = !(_formKey
                                          .currentState?.fields['name']
                                          ?.validate() ??
                                      false);
                                }
                              });
                            },
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required(context)]),
                            textInputAction: TextInputAction.next,
                          ),

                          SizedBox(height: 10),
                          FormBuilderTextField(
                            name: 'inventoryAmount',
                            autovalidateMode: AutovalidateMode.always,
                            decoration: InputDecoration(
                              labelText: 'Amount in Inventory',
                              prefixIcon: Icon(Icons.folder_outlined),
                              suffixIcon: _inventoryAmountHasError
                                  ? Icon(Icons.error, color: Colors.red)
                                  : Icon(Icons.check, color: Colors.green),
                            ),
                            onChanged: (val) {
                              setState(() {
                                _inventoryAmountHasError = !(_formKey
                                        .currentState?.fields['inventoryAmount']
                                        ?.validate() ??
                                    false);
                              });
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.numeric(context),
                            ]),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            name: 'price',
                            decoration: InputDecoration(
                                labelText: 'Item Price',
                                prefixIcon:
                                    Icon(Icons.monetization_on_outlined),
                                suffixIcon: _priceHasError
                                    ? Icon(Icons.error, color: Colors.red)
                                    : Icon(Icons.check, color: Colors.green)),
                            onChanged: (val) {
                              setState(() {
                                _priceHasError = !(_formKey
                                        .currentState?.fields['price']
                                        ?.validate() ??
                                    false);
                              });
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.numeric(context),
                            ]),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(height: 10),
                          MaterialButton(
                              color: myTheme().accentColor,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  late String imageString = "";
                                  if (_productImage == null) {
                                    imageString = _placeholderImage;
                                  } else {
                                    imageString = imageHelper.base64String(
                                        _productImage!.readAsBytesSync());
                                  }
                                  print('Saving!!');

                                  Provider.of<MyDatabase>(context, listen: false)
                                      .createProduct(ProductCompanion(
                                          name: moor.Value(_formKey
                                              .currentState!
                                              .fields['name']
                                              ?.value),
                                          inventoryAmount: moor.Value(int.parse(
                                              _formKey
                                                  .currentState!
                                                  .fields['inventoryAmount']
                                                  ?.value)),
                                          price: moor.Value(double.parse(
                                              _formKey.currentState!
                                                  .fields['price']?.value)),
                                          image: moor.Value(imageString)));
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title:
                                              Text('Item added to inventory.'),
                                        );
                                      });
                                  setState(() {
                                    _formKey.currentState?.reset();
                                    _productImage = null;
                                  });
                                }
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )))),
        ));
  }
}
