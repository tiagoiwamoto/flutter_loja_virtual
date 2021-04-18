/*
    Author: Tiago Henrique Iwamoto
    email: tiago.iwamoto@gmail.com
    github: https://tiagoiwamoto.github.io
    linkedin: https://www.linkedin.com/in/tiago-iwamoto/
    Created at: 17/04/2021 - 10:55
*/

import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';
import 'file:///W:/Workspace/flutter/loja_virtual/lib/managers/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            textColor: Colors.white,
            child: Text(
              'CRIAR CONTA',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __){
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.loading,
                        decoration: InputDecoration(hintText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email){
                          if(!emailValid(email)){
                            return 'E-mail inválido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        enabled: !userManager.loading,
                        decoration: InputDecoration(hintText: 'Senha'),
                        autocorrect: false,
                        obscureText: true,
                        validator: (password){
                          if(password.isEmpty || password.length < 6){
                            return 'Senha inválida';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          child: Text('Esqueci minha senha'),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          onPressed: userManager.loading ? null : (){
                            if(formKey.currentState.validate()){
                              userManager.signIn(
                                  user: User(email: emailController.text, password: passwordController.text),
                                  onFail: (e){
                                    scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text(e),
                                          backgroundColor: Colors.redAccent,
                                        )
                                    );
                                  },
                                  onSuccess: (){
                                    Navigator.of(context).pop();
                                  }
                              );
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          child: userManager.loading ?
                          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)) :
                          Text('Entrar', style: TextStyle(fontSize: 18)),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
