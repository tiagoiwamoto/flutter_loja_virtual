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
import 'package:loja_virtual/models/user_manager.dart';
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
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    controller: emailController,
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
                      onPressed: (){
                        if(formKey.currentState.validate()){
                          context.read<UserManager>().signIn(
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
                              // TODO: Fechar tela de login
                              print('sucesso');
                            }
                          );
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text('Entrar', style: TextStyle(fontSize: 18)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
