import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        theme: ThemeData(
            hintColor: Colors.redAccent,
            primaryColor: Colors.white,
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent)),
              hintStyle: TextStyle(color: Colors.redAccent),
            )),
        debugShowCheckedModeBanner: false,
        title: 'STOPnow | Pare de Fumar',
        //home: MyApp(),
        // ROTAS
        initialRoute: '/pagina1',
        routes: {
          '/pagina1': (context) => MyApp(), //login
          '/pagina2': (context) => SegundaPagina(), //painel principal
          '/pagina3': (context) => TerceiraPagina(), //informações pessoais
          '/pagina4': (context) => QuartaPagina(), //saude
          '/pagina5': (context) => QuintaPagina(), //comunidade
          '/pagina6': (context) => SextaPagina() //sobre o app
        }),
  );
}

// PRIMEIRA PÁGINA = login
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  String msg = "Informe email e senha para logar";

  void _limpar() {
    emailController.text = "";
    senhaController.text = "";
    setState(() {
      msg = "Informe email e senha para logar";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  iconSize: 25,
                  color: Colors.white,
                  icon: Icon(Icons.refresh),
                  onPressed: _limpar)
            ]),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/icone.png",
                        height: 100,
                      ),
                    ),
                    Text(
                      "STOPnow",
                      style: TextStyle(fontSize: 25, color: Colors.redAccent),
                    ),
                  ]),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                ),
              ),
              Divider(),
              TextFormField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                ),
              ),
              Divider(),
              Text(
                msg,
                style: TextStyle(color: Colors.redAccent, fontSize: 15),
              ),
              Divider(),
              Center(
                  child: Builder(
                      builder: (context) => RaisedButton(
                          color: Colors.redAccent,
                          child: Text("Entrar"),
                          textColor: Colors.white,
                          onPressed: () {
                            if ((emailController.text == "1") &&
                                (senhaController.text == "1")) {
                              Navigator.pushNamed(context, '/pagina2',
                                  arguments: Mensagem("", "", ""));
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                      Text("Usuário ou senha incorretos")));
                            }
                          }))),
            ],
          ),
        ));
  }
}

//CLASSE PARA TROCA DE DADOS ENTRE AS TELAS
class Mensagem {
  final String _diassemfumar;
  final String _cigarrosnaofumados;
  final String _valorEconomizado;

  Mensagem(
      this._diassemfumar, this._cigarrosnaofumados, this._valorEconomizado);
}

// SEGUNDA PÁGINA = painel principal
class SegundaPagina extends StatefulWidget {
  @override
  _SegundaPaginaState createState() => _SegundaPaginaState();
}

class _SegundaPaginaState extends State<SegundaPagina> {
  @override
  Widget build(BuildContext context) {
    final Mensagem msg = ModalRoute.of(context).settings.arguments;
    String v = msg._valorEconomizado,
        c = msg._cigarrosnaofumados,
        d = msg._diassemfumar;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text(
          "STOPnow",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  "images/icone.png",
                  height: 50,
                ),
              ),
              Text(
                "STOPnow",
                style: TextStyle(fontSize: 25, color: Colors.redAccent),
              ),
            ]),
            Divider(),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                      leading: Icon(
                        Icons.smoke_free,
                        size: 35,
                      ),
                      title: Text(
                        'Parabéns',
                        style: TextStyle(color: Colors.redAccent, fontSize: 25),
                      ),
                      subtitle: Text(
                        "\nVocê tomou o primeiro passo para uma saúde melhor.\nParticipe da Comunidade para receber e dar apoio a outros STOPers\n\n",
                        style: TextStyle(color: Colors.redAccent, fontSize: 15),
                      )),
                ],
              ),
            ),
            Container(
              color: Colors.redAccent,
              child: Column(
                children: <Widget>[
                  Divider(),
                  Text(
                    "Dias sem fumar: ${msg._diassemfumar}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Divider(),
                  Text(
                    "Cigarros não fumados: ${msg._cigarrosnaofumados}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Divider(),
                  Text("Valor Economizado: R\$ ${msg._valorEconomizado}",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Divider()
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: <Widget>[
                  Text(
                    'STOPnow ',
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  Icon(
                    Icons.smoke_free,
                    size: 35,
                    color: Colors.white,
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
            ),
            ListTile(
              title: Text('Informações Pessoais'),
              onTap: () {
                Navigator.pushNamed(context, '/pagina3');
              },
            ),
            ListTile(
              title: Text('Saúde'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Comunidade'),
              onTap: () {
                //Navigator.pop(context);
                Navigator.pushNamed(context, '/pagina5',
                    arguments: Mensagem(d, c, v));
              },
            ),
            ListTile(
              title: Text('Sobre o App'),
              onTap: () {
                Navigator.pushNamed(context, '/pagina6',
                    arguments: Mensagem(d, c, v));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Sair'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// TERCEIRA PÁGINA = informações pessoais
class TerceiraPagina extends StatefulWidget {
  @override
  _TerceiraPaginaState createState() => _TerceiraPaginaState();
}

class _TerceiraPaginaState extends State<TerceiraPagina> {
  final diasController = TextEditingController();
  final cigarrosController = TextEditingController();
  final valorController = TextEditingController();

  double valorEconomizado = 0;
  double cigarrosNaoFumados = 0;
  int diasSemFumar = 0;

  String v = "", c = "", d = "";

  void _calcula(String a) {
    if ((diasController.text.isNotEmpty) &&
        ((cigarrosController.text.isNotEmpty)) &&
        (valorController.text.isNotEmpty)) {
      valorEconomizado = double.parse(cigarrosController.text) /
          20 *
          double.parse(diasController.text) *
          double.parse(valorController.text);

      cigarrosNaoFumados = double.parse(diasController.text) *
          double.parse(cigarrosController.text);

      setState(() {
        v = valorEconomizado.toStringAsFixed(2);
        c = cigarrosNaoFumados.toStringAsFixed(0);
        d = diasController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: Text(
            "STOPnow",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  "images/icone.png",
                  height: 50,
                ),
              ),
              Text(
                "STOPnow",
                style: TextStyle(fontSize: 25, color: Colors.redAccent),
              ),
            ]),
            Divider(),
            TextField(
              onChanged: (text) {
                _calcula(text);
              },
              controller: diasController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Dias sem fumar",
                labelStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
              ),
            ),
            Divider(),
            TextField(
              onChanged: (text) {
                _calcula(text);
              },
              controller: cigarrosController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantos cigarros fumava por dia",
                labelStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
              ),
            ),
            Divider(),
            TextField(
              onChanged: (text) {
                _calcula(text);
              },
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: "R\$ ",
                labelText: "Valor do maço de cigarro",
                labelStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
              ),
            ),
            Divider(),
            Center(
                child: Builder(
              builder: (context) => RaisedButton(
                color: Colors.redAccent,
                child: Text("Salvar"),
                textColor: Colors.white,
                onPressed: () {
                  if ((diasController.text.isNotEmpty) &&
                      ((cigarrosController.text.isNotEmpty)) &&
                      (valorController.text.isNotEmpty)) {
                        Firestore.instance.collection("dadosPessoais").document("dados").setData({"dias": diasController.text, "cigarros": cigarrosController.text, "valor": valorController.text});
                        Firestore.instance.collection("resultados").document("dados").setData({"dias": d, "cigarros": c, "valor": v});
                        //Firestore.instance.collection("data").document("data").setData({"hoje": DateTime.now()});

                        Navigator.pushNamed(context, "/pagina2", arguments: Mensagem(d, c, v));
                  } else {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Informe todos os campos")));
                  }
                },
              ),
            )),
          ]),
        ));
  }
}

//QUARTA PAGINA: saúde
class QuartaPagina extends StatefulWidget {
  @override
  _QuartaPaginaState createState() => _QuartaPaginaState();
}

class _QuartaPaginaState extends State<QuartaPagina> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Item {
  var icone;
  String titulo;
  String subtitulo;

  Item(this.icone, this.titulo, this.subtitulo);
}

class listviewComentarios extends StatefulWidget {
  @override
  _listviewComentariosState createState() => _listviewComentariosState();
}

class _listviewComentariosState extends State<listviewComentarios> {
  List<Item> lista = [];

  TextEditingController txtTitulo = new TextEditingController();
  TextEditingController txtSubtitulo = new TextEditingController();

  //Aparência dos itens do ListView
  Widget _itemLista(context, index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.height * 0.2,
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Card(
        color: Colors.redAccent[100],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            //Image.network("https://picsum.photos/seed/${index + 1}/100/100"),
            SizedBox(
              height: 10,
            ),
            Text(
              "nathaly_kaubatz",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              lista[index].subtitulo,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      //height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: lista.length, // total de itens da lista
              itemBuilder:
                  _itemLista, // especificar a aparência dos itens da lista
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 4,
                child: TextField(
                  controller: txtSubtitulo,
                  decoration: InputDecoration(
                      labelText: "comentário",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.1))),
                ),
              ),
              Flexible(
                flex: 2,
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      lista.add(Item(Icons.person_outline, "nathaly_kaubatz",
                          txtSubtitulo.text));
                      txtSubtitulo.text = "";
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//QUINTA PAGINA: comunidade
class QuintaPagina extends StatefulWidget {
  @override
  _QuintaPaginaState createState() => _QuintaPaginaState();
}

class _QuintaPaginaState extends State<QuintaPagina> {
  @override
  Widget build(BuildContext context) {
    final Mensagem msg = ModalRoute.of(context).settings.arguments;
    String v = msg._valorEconomizado,
        c = msg._cigarrosnaofumados,
        d = msg._diassemfumar;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: Text(
            "STOPnow",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        body: listviewComentarios());
  }
}

//SEXTA PAGINA:  sobre o app
class SextaPagina extends StatefulWidget {
  @override
  _SextaPaginaState createState() => _SextaPaginaState();
}

class _SextaPaginaState extends State<SextaPagina> {
  @override
  Widget build(BuildContext context) {
    final Mensagem msg = ModalRoute.of(context).settings.arguments;
    String v = msg._valorEconomizado,
        c = msg._cigarrosnaofumados,
        d = msg._diassemfumar;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "Sobre o app",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "images/icone.png",
                height: 50,
              ),
            ),
            Text(
              "STOPnow",
              style: TextStyle(fontSize: 25, color: Colors.redAccent),
            ),
          ]),
          Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.smoke_free),
                      title: Text('STOPnow'),
                      subtitle: Text(
                          'App para auxiliar na decisão de parar de fumar.\n\n Acompanhe seu progresso dia a dia, obtendo informações e dicas de saúde'),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text(
                            'VOLTAR',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/pagina2',
                                arguments: Mensagem(d, c, v));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Card(
                  child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Image.asset(
                      "images/foto.png",
                      height: 100,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      "Nathaly Kaubatz | \nADS Noite | \nFATEC Ribeirão Preto | \n2020",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  )
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
