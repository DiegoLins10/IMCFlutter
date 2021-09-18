import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
//const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";
  String dropdownvalue = 'Masculino';
  var items = ['Masculino', 'Feminino'];
  void _limpaCampos() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (dropdownvalue == items[0]) {
        if (imc < 20.0) {
          _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 20.0 && imc < 24.9) {
          _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 25.0 && imc < 29.9) {
          _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 30.0 && imc < 39.9) {
          _infoText = "Obesidade moderada (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 40) {
          _infoText = "Obesidade morbida (${imc.toStringAsPrecision(4)})";
        }
      } else {
        if (imc < 19.0) {
          _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 19.0 && imc < 23.9) {
          _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 24.0 && imc < 28.9) {
          _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 29.0 && imc < 38.9) {
          _infoText = "Obesidade moderada (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 39) {
          _infoText = "Obesidade morbida (${imc.toStringAsPrecision(4)})";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Cálculadora IMC - Fatec Ferraz",
          ),
          centerTitle: true,
          backgroundColor: Colors.grey,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _limpaCampos();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.yellow,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 35,
                    ),
                    controller: pesoController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira seu Peso!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 35,
                    ),
                    controller: alturaController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Texto vazio!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: dropdownvalue,
                    decoration: InputDecoration(
                        labelText: "Sexo",
                        labelStyle: TextStyle(color: Colors.black, fontSize: 35)
                        //hintText: "Masculino",
                        ),
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                    ),
                    items: items
                        .map((sexo) =>
                            DropdownMenuItem(value: sexo, child: Text("$sexo")))
                        .toList(),
                    onChanged: (var newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),

                  /*  DropdownButton<String>(
                    value: dropdownvalue,
                    items: items.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (var newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),*/
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calcularIMC();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                    ),
                  )
                ],
              ),
            )));
  }
}
