import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController etanolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = "Informe os valores";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _reset() {
    etanolController.text = "";
    gasolinaController.text = "";
    setState(() {
      _resultado = "Informe os valores";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculaCombustivelIdeal() {
    setState(() {
      double vEtanol = double.parse(etanolController.text.replaceAll(',', '.'));
      double vGasolina =
          double.parse(gasolinaController.text.replaceAll(',', '.'));
      double proporcao = vEtanol / vGasolina;

      _resultado =
          (proporcao < 0.7) ? "Abasteça com Álcool" : "Abasteça com Gasolina!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Álcool ou Gasolina?",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[900],
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  _reset();
                })
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.local_gas_station,
                  size: 150.0,
                  color: Colors.lightBlue[900],
                ),
                TextFormField(
                  controller: etanolController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe o valor do Álcool!";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Valor do Álcool",
                    labelStyle: TextStyle(color: Colors.lightBlue[900]),
                  ),
                  style:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
                ),
                TextFormField(
                  controller: gasolinaController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe o valor da gasolina!";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Valor da Gasolina",
                      labelStyle: TextStyle(color: Colors.lightBlue[900])),
                  style:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          textStyle: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w400)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calculaCombustivelIdeal();
                        }
                      },
                      child: const Text(
                        "Verificar",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  _resultado,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
                )
              ],
            ),
          ),
        ));
  }
}
