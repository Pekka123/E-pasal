import 'package:epasal/provider/product.dart';
import 'package:epasal/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeId = '/edit_product_screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusedNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imgUrlFocusNode = FocusNode();
  final _imgUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageURL: '',
  );
  bool isInit = true;
  var initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageURL': '',
  };
  bool _isLoading = false;
  //---to clean off the unwanted widgets
  @override
  void dispose() {
    _descFocusNode.dispose();
    _priceFocusedNode.dispose();
    _imgUrlController.dispose();
    _imgUrlFocusNode.dispose();
    super.dispose();
  }

  //---the function called when our screen is created--
  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  //--the first function for initializating values
  @override
  void didChangeDependencies() {
    if (isInit) {
      final String productId = ModalRoute.of(context).settings.arguments;
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context).findById(productId);
        initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageURL': '',
        };
        _imgUrlController.text = _editedProduct.imageURL;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  //--
  void _updateImageUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      if ((!_imgUrlController.text.startsWith('http') &&
              !_imgUrlController.text.startsWith('https')) ||
          (!_imgUrlController.text.endsWith('.png') &&
              !_imgUrlController.text.endsWith('.PNG') &&
              !_imgUrlController.text.endsWith('.jpg') &&
              !_imgUrlController.text.endsWith('.JPG'))) {
        return;
      }
      setState(() {});
    }
  }

//----to save product===
  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((error) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Error occured'),
                  content:
                      Text('Something has occured! Product could not be added'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ));
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusedNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'title must not be empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: value,
                          description: _editedProduct.description,
                          id: _editedProduct.id,
                          imageURL: _editedProduct.imageURL,
                          price: _editedProduct.price,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusedNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'title must not be empty';
                        }
                        if (double.tryParse(value) == null) {
                          return 'The price should be in number format';
                        }
                        if (double.parse(value) <= 0) {
                          return 'The price should not be less tha zero';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          id: _editedProduct.id,
                          imageURL: _editedProduct.imageURL,
                          price: double.parse(value),
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      focusNode: _descFocusNode,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'description must not be empty';
                        }
                        if (value.length < 10) {
                          return 'The decription must not be less than 10 characters.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: value,
                          id: _editedProduct.id,
                          imageURL: _editedProduct.imageURL,
                          price: _editedProduct.price,
                        );
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: _imgUrlController.text.isEmpty
                                ? Text("Enter a url")
                                : FittedBox(
                                    child:
                                        Image.network(_imgUrlController.text),
                                    fit: BoxFit.cover,
                                  )),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image Url'),
                            focusNode: _imgUrlFocusNode,
                            controller: _imgUrlController,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'imageUrl must not be empty';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'The image url is not valid';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.PNG') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.JPG')) {
                                return 'The imageUrl Is not Valid';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                id: _editedProduct.id,
                                imageURL: value,
                                price: _editedProduct.price,
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
