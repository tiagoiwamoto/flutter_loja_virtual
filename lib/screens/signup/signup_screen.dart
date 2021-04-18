/*
    Author: Tiago Henrique Iwamoto
    email: tiago.iwamoto@gmail.com
    github: https://tiagoiwamoto.github.io
    linkedin: https://www.linkedin.com/in/tiago-iwamoto/
    Created at: 18/04/2021 - 07:17
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';
import 'file:///W:/Workspace/flutter/loja_virtual/lib/managers/user_manager.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Criar conta'),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __){
                return ListView(
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Nome completo'),
                      enabled: !userManager.loading,
                      validator: (name){
                        if(name.isEmpty){
                          return 'Campo obrigatório';
                        }else if(name.trim().split(' ').length <= 1){
                          return 'Preencha seu nome completo';
                        }else{
                          return null;
                        }
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'E-mail'),
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email){
                        if(email.isEmpty){
                          return 'Campo obrigatório';
                        }else if(!emailValid(email)){
                          return 'E-mail inválido';
                        }else{
                          return null;
                        }
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (password){
                        if(password.isEmpty){
                          return 'Campo obrigatório';
                        }else if(password.length < 6){
                          return 'Senha muito curta';
                        }else{
                          return null;
                        }
                      },
                      onSaved: (password) => user.password = password,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Repita a senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (password){
                        if(password.isEmpty){
                          return 'Campo obrigatório';
                        }else if(password.length < 6){
                          return 'Senha muito curta';
                        }else{
                          return null;
                        }
                      },
                      onSaved: (password) => user.confirmPassword = password,
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: userManager.loading ? null : (){
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();

                            if(user.password != user.confirmPassword){
                              scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text('Senhas não coincidem!', style: TextStyle(color: Colors.white)),
                                    backgroundColor: Colors.deepOrangeAccent,
                                  )
                              );
                              return;
                            }
                            userManager.signUp(
                                user: user,
                                onSuccess: (){
                                  Navigator.of(context).pop();
                                },
                                onFail: (e){
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text('Falha ao cadastrar'),
                                        backgroundColor: Colors.redAccent,
                                      )
                                  );
                                }
                            );
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: userManager.loading
                            ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
                            : Text('CRIAR CONTA', style: TextStyle(fontSize: 18)),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
