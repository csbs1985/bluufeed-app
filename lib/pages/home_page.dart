import 'package:flutter/material.dart';
import 'package:universe_history_app/widget/bottom_navigation_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const SingleChildScrollView(
                child: Text(
                    "Mussum Ipsum, cacilds vidis litro abertis. Mais vale um bebadis conhecidiss, que um alcoolatra anonimis.Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis!Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus.Mé faiz elementum girarzis, nisi eros vermeio. Mais vale um bebadis conhecidiss, que um alcoolatra anonimis.Quem manda na minha terra sou euzis!Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis!Copo furadis é disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulitá.Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.In elementis mé pra quem é amistosis quis leo.Praesent vel viverra nisi. Mauris aliquet nunc non turpis scelerisque, eget. Interessantiss quisso pudia ce receita de bolis, mais bolis eu num gostis.Leite de capivaris, leite de mula manquis sem cabeça.Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.Per aumento de cachacis, eu reclamis. Paisis, filhis, espiritis santis.Todo mundo vê os porris que eu tomo, mas ninguém vê os tombis que eu levo!Interagi no mé, cursus quis, vehicula ac nisi.Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis."),
              ),
            ),
          ),
          const BottomNavigationWidget(),
        ],
      ),
    );
  }
}
