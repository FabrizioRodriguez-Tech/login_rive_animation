import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:async'; //3.1 Importar el timer
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Control para mostrar/Ocultar contraseña
  bool _isObscure = true;

  // 1.1 Máquina estados / Cerebro de la animación
  StateMachineController? _controller;

  // StateMachineInputss ()
  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  SMITrigger? _trigSuccess;
  SMITrigger? _trigFail;
  SMINumber? _numLook;

  //3.2 Timer para detener el recorrido de la mirada
  Timer? _typingDebounce;
  

  //2.1 Crear Variables para FocusNode
  final _emailFocus = FocusNode();
  final _passwordFocus= FocusNode();

//2.2 Crear los oyentes (listener)
  @override
  void initState(){
    super.initState();
    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus){
        if (_isHandsUp != null){
          _isHandsUp?.change(false);

        //3.3 Mirada neutral
        _numLook?.value=50.0; 
        }
      }
    });

    _passwordFocus.addListener(() {
      //Manos arriba en password
      _isHandsUp?.change(_passwordFocus.hasFocus);
    });
    
  }

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

                  //2.3 Asignar el focus al textfield
                  focusNode: _emailFocus,
                  // 1.5 Vincular a campo de texto
                  onChanged: (value) {
                    if (_isHandsUp != null) {
                      // No tapes los ojos al ver el email
                      //_isHandsUp!.change(false);
                    }

                    if (_isChecking != null) {
                      //Activa modo chismoso
                      _isChecking!.change(true);
                      //3.4 Implementar recorrido con la mirada
                      //Ajuste de límites del 0 al 100
                      //80 medida de calibración. Clamp es un rango
                      final look = (value.length/80.0*100.0).clamp(
                        0.0,
                        100.0
                        );
                        _numLook?.value=look;

                        //3.5 Debounce: Si vuelve a teclear, reinicia el contador
                        _typingDebounce?.cancel();
                        //Crear el nuevo timer
                        _typingDebounce = Timer(const Duration(seconds: 3), (){
                          //Si se cierra la pantalla, termina la ejecución.
                          if (!mounted) return;
                          //Mirada neutra
                          _isChecking?.change(false);
                        });
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
                  //2.3 Asignar el focus al textfield
                  focusNode: _passwordFocus,
                  //1.5 Vincular a campo de texto
                  onChanged: (value) {
                    if (_isChecking != null) {
                      // No actives el modo chismoso en contraseña
                      //_isChecking!.change(false);
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
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    //2.4 Liberar memoria o recursos en los FocusNode
    _emailFocus.dispose();
    _passwordFocus.dispose();
    //3.5 Liberar
    _typingDebounce?.cancel();
    super.dispose();
  }


}