import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold()(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Registrar Estudante'),
        backgroundColor: Colors.indigoAccent,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 29,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}