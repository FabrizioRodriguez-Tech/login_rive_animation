import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
<<<<<<< HEAD
  const LoginScreen({super.key});
=======
  const new({super.key});
>>>>>>> 3f5a15f6d6ffe267af3aa1a027e28eb37342cbc6

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
<<<<<<< HEAD
  // Control para mostrar/Ocultar contraseña
  bool _isObscure = true;

  // 1.1 Máquina estados / Cerebro de la animación
  StateMachineController? _controller;

  // StateMachineInputss
  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  SMITrigger? _trigSuccess;
  SMITrigger? _trigFail;
  SMINumber? _numLook;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  width: screenSize.width,
                  height: 200,
                  child: RiveAnimation.asset(
                    'assets/login_bear.riv',
                    stateMachines: const ['Login Machine'],
                    // 1.2 Vincular la animación
                    onInit: (artboard) {
                      _controller = StateMachineController.fromArtboard(
                        artboard,
                        'Login Machine',
                      );

                      // 1.3 Verificar que inició bien
                      if (_controller == null) return;
                      artboard.addController(_controller!);

                      // 1.4 Vincular las variables
                      _isChecking = _controller!.findSMI('isChecking');
                      _isHandsUp = _controller!.findSMI('isHandsUp');
                      _trigSuccess = _controller!.findSMI('trigSuccess');
                      _trigFail = _controller!.findSMI('trigFail');
                      _numLook = _controller!.findSMI('numLook');
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // Email
                TextField(
                  // 1.5 Vincular a campo de texto
                  onChanged: (value) {
                    if (_isHandsUp != null) {
                      // No tapes los ojos al ver el email
                      _isHandsUp!.change(false);
                    }

                    if (_isChecking != null) {
                      _isChecking!.change(true);
                    }

                    if (_numLook != null) {
                      _numLook!.change(value.length.toDouble());
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Contraseña
                TextField(
                  onChanged: (value) {
                    if (_isChecking != null) {
                      // No actives el modo chismoso en contraseña
                      _isChecking!.change(false);
                    }

                    if (_isHandsUp != null) {
                      _isHandsUp!.change(true);
                    }
                  },
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Refrescar el ícono
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
=======
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context)
        .size; //obtiene el tamaño de la pantalla

    return Scaffold(
      // nos ayuda a cuidar - safe area / rap rignifia envorlver
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                width: screenSize.width,
                height: 200,
                child: RiveAnimation.asset('assets/login-bear-animation.riv'),
              ),
              //SizedBox: para separar elementos
              SizedBox(height: 10),
              //Email
              TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    //Para redondear los bordes
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //Contraseña
              TextField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      //Refrescar el ícono
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                      //If ternario
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  border: OutlineInputBorder(
                    //Para redondear los bordes
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
>>>>>>> 3f5a15f6d6ffe267af3aa1a027e28eb37342cbc6
          ),
        ),
      ),
    );
  }
}