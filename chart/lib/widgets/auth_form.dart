

import 'dart:io';

import 'package:chart/models/auth_data.dart';
import 'package:chart/widgets/user_imagem.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthDATA authDATA) oneSubmit;

  AuthForm(this.oneSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final AuthDATA _authDATA = AuthDATA();

  void _submit(){
    bool isvalidate =  _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(_authDATA.email == null && _authDATA.isSignup){
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("è necessario imagem para cadastro"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    
    if(isvalidate){
        widget.oneSubmit(_authDATA);
    }

  }

  void _handlePickerImage(File image){
     _authDATA.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if(_authDATA.isSignup)
                    UserImagem(_handlePickerImage),
                  if(_authDATA.isSignup)
                  TextFormField(
                    key: ValueKey("name"),
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                    initialValue: _authDATA.name,
                    onChanged: (value) => _authDATA.name = value,
                    validator: (value) {
                      if(value.trim() == null){
                        return 'Digite um nome valido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey("email"),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    onChanged: (value) => _authDATA.email = value,
                    validator: (value) {
                      if(value.trim() == null  || !value.contains('@')  ){
                        return 'Digite um e-mail valido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey("password"),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                    onChanged: (value) => _authDATA.password = value,
                     validator: (value) {
                      if(value.trim() == null  || value.length < 7){
                        return 'Digite uma senha  valida maior que 7';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RaisedButton(
                    child: Text(_authDATA.isLogin ? 'Entrar': 'Cadastrar'),
                    onPressed:_submit,
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_authDATA.isLogin ?'Criar um nova Conta?': 'Já possui uma conta?'),
                    onPressed: () {
                      setState(() {
                        
                        _authDATA.toggleMode();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
