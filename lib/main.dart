
import 'package:flutter/material.dart'; // 1 importar pacote

void main() {
  // inicia o meto main
  runApp(MaterialApp(
    //run app

    home: HOME(), //metodo home
  ));
}

//cria uma stful

class HOME extends StatefulWidget {
  //metodo home
  @override
  _HOMEState createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {

  // controlador dos campos
    TextEditingController pesoControle = TextEditingController();
    TextEditingController alturaControle = TextEditingController();

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _infoText ='Informe seus dados!';

      void _limpaCampos(){
        setState(() {
          pesoControle.text="";
          alturaControle.text="";
          _infoText='Informe seus dados!';
          _formKey=GlobalKey<FormState>();
        });

      }

      void calcular(){
        setState(() {
          double peso = double.parse(pesoControle.text);
          double altura=double.parse(alturaControle.text)/100;
          double imc = peso/ (altura * altura);

           if (imc < 18.6)                {_infoText='Abaixo do Peso            IMC (${imc.toStringAsPrecision(3 )})';}
           if (imc >= 18.6 && imc < 24.9) {_infoText='Peso Ideal                IMC (${imc.toStringAsPrecision(3 )})';}
           if (imc >= 24.9 && imc < 29.9){_infoText='Levemente acima do peso    IMC (${imc.toStringAsPrecision(3 )})';}
           if (imc >= 29.9 && imc < 34.9){_infoText='Obesidade Grau I           IMC (${imc.toStringAsPrecision(3 )})';}
           if (imc >=34.9 && imc < 39.9){_infoText='Obesidade Grau II           IMC (${imc.toStringAsPrecision(3 )})';}
           if (imc >= 40){_infoText='Obesidade Grau III                         IMC (${imc.toStringAsPrecision(3 )})';}
        });

      }


  @override
  Widget build(BuildContext context) {
    //corpo do app
    return Scaffold(
      // inicia uma appbar
      appBar: AppBar(
        title: Text("Calculadora de IMC"), // texto da appbar
        centerTitle: true, //centraliza o texto
        backgroundColor: Colors.green, //cor da appbar
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: _limpaCampos,
          )
        ],
      ),
      // Inicio do corpo
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 300.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (KG)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 25.0,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: pesoControle,
                validator: (value){
                  if(value.isEmpty){
                    return 'Informe seu Peso';
                  }
                }, // validator
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (Cm)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 25.0,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: alturaControle,
                validator: (value){
                  if(value.isEmpty){
                    return 'Insira a sua altura';
                  }
                },//validator
              ),
              Padding(
                padding: EdgeInsets.only(top:10.0,bottom: 10.0),
                child:    Container(
                  height: 50.0,
                  child:  RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        calcular();
                      }
                    },
                    child:Text('Calcular',
                      style:TextStyle(color: Colors.white,fontSize: 25.0),
                    ),

                    color: Colors.green,

                  ),
                ),
              ),
              Text(_infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green,fontSize: 25.0),),

            ],
          ),
        )

      )
    );
  }
}
