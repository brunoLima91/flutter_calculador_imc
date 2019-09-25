import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home(), debugShowCheckedModeBanner: false ,));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _hightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _mensage = "Informe seus dados";
  void _resetFields() {
    _weightController.text = "";
    _hightController.text = "";
    setState(() {
      _mensage = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }


  void _calculate() {
    setState(() {
      double weight = double.parse(_weightController.text);
      double hight = double.parse(_hightController.text) / 100;
      double imc = weight / (hight * hight);
      print(imc);
      if (imc < 18.6) {
        _mensage = "Abaixo do peso, seu IMC é (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _mensage = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc <= 29.9) {
        _mensage = "Levemente Acima do Peso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _mensage = "Obesidade Grau I(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc <= 39.9) {
        _mensage = "Obesidade Grau II(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _mensage = "Obesidade Grau III(${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.blue,
                  ),
                  TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso(kg)",
                        labelStyle: TextStyle(color: Colors.blue)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso";
                      }
                    },
                  ),
                  TextFormField(
                    controller: _hightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura(cm)",
                        labelStyle: TextStyle(color: Colors.blue)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira sua Altura";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if(_formKey.currentState.validate()){
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Text(
                    _mensage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  )
                ],
              )),
        ));
  }
}