import 'package:bodyapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:boxicons/boxicons.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:validators/validators.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => null,
        ), 
        centerTitle: true,
        title: Text(
          'Sing Up',
          style: GoogleFonts.roboto(
            fontSize: 30 * 568 / MediaQuery.of(context).size.height,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            RegisterFormWidget(),
          ],
        ),
      ),
    );
  }
}

class RedesSociais extends StatelessWidget{
  const RedesSociais({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const IconButton(
          icon: Icon(
            Icons.facebook,
            size: 42.0,
            color: Colors.blue,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(
            Boxicons.bxl_twitter,
            size: 42.0,
            color: Colors.cyan,                
          ),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(
            Boxicons.bxl_google,
            size: 42.0,
            color: Colors.red,
          ),
          onPressed: null,
        ),
      ]
    );
  }
}

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final _formKey = GlobalKey<FormState>();

  RegExp _upper = RegExp(r'[A-Z]');
  RegExp _lower = RegExp(r'[a-z]');
  RegExp _numeric = RegExp(r'[0-9]');
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 120,
              vertical: 20,
            ),
            child: CircleAvatar(
              child: const Icon(
                Boxicons.bx_camera,
                color: Colors.white,
                size: 30,
              ),
              radius: 40, 
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InputWidget(
              hintText: 'Nome',
              prefixIcon: Boxicons.bx_user,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InputWidget(
              hintText: 'Email',
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value != null && !isEmail(value)) {
                  return 'Preencha um e-mail válido.';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InputWidget(
              hintText: 'Senha',
              prefixIcon: Icons.lock,
              sufixIcon:
                  isPasswordObscured ? Icons.visibility_off : Icons.visibility,
              obscureText: isPasswordObscured,
              suffixIconOnPressed: () {
                setState(() {
                  isPasswordObscured = !isPasswordObscured;
                });
              },
              validator: (value) {
                if (value != null && value.length < 6) {
                  return 'A senha deve conter no mínimo 6 caracteres';
                }
                if (value != null && !value.contains(_upper)) {
                  return 'A senha deve conter no mínimo 1 caractere maiúsculo';
                }
                if (value != null && !value.contains(_lower)) {
                  return 'A senha deve conter no mínimo 1 caractere minúsculo';
                }
                if (value != null && !value.contains(_numeric)) {
                  return 'A senha deve conter no mínimo 1 número';
                }
                return null;
              },

              onChanged: (value) {
                setState((){
                  _password = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InputWidget(
              hintText: 'Confirmar Senha',
              prefixIcon: Icons.lock,
              sufixIcon:
                  isConfirmPasswordObscured ? Icons.visibility_off : Icons.visibility,
              obscureText: isConfirmPasswordObscured,
              suffixIconOnPressed: () {
                setState(() {
                  isConfirmPasswordObscured = !isConfirmPasswordObscured;
                });
              },
              validator: (value) {
                if (value != null && value.length < 6) {
                  return 'A senha deve conter no mínimo 6 caracteres';
                }
                if (value != null && !value.contains(_upper)) {
                  return 'A senha deve conter no mínimo 1 caractere maiúsculo';
                }
                if (value != null && !value.contains(_lower)) {
                  return 'A senha deve conter no mínimo 1 caractere minúsculo';
                }
                if (value != null && !value.contains(_numeric)) {
                  return 'A senha deve conter no mínimo 1 número';
                }
                if (value != _password){
                  return 'A senha inserida não bate com a anterior';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Center(
                child: Text(
                  'Registrar',
                  style: GoogleFonts.rokkitt(
                    fontSize: 25 * 568 / MediaQuery.of(context).size.height,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.teal[100],
            padding: EdgeInsets.all(2.0),
            margin: EdgeInsets.all(5.0),
          ),
          RedesSociais(),
        ],
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  String? hintText;
  IconData? prefixIcon;
  IconData? sufixIcon;
  bool obscureText;
  VoidCallback? suffixIconOnPressed;
  String? Function(String?)? validator;
  void Function(String)? onChanged;

  InputWidget({
    this.hintText,
    this.prefixIcon,
    this.sufixIcon,
    this.obscureText = false,
    this.suffixIconOnPressed,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.grey[300],
        filled: true,
        focusColor: Colors.grey[300],
        hoverColor: Colors.grey[300],
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[800]),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.teal,
        ),
        suffixIcon: IconButton(
          icon: Icon(sufixIcon),
          color: AppColors.teal,
          onPressed: suffixIconOnPressed,
        ),
      ),
      validator: validator,
    );
  }
}
