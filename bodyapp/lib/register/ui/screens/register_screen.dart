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
      body: Column(
        children: <Widget>[
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
          RegisterFormWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        selectedItemColor: Colors.black,

        unselectedFontSize: 14,
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.facebook,
              size: 32.0,
              color: Colors.blue,
            ),
            label: 'FaceBook',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Boxicons.bxl_twitter,
              size: 32.0,
              color: Colors.cyan,                
            ),
            label: 'Twitter',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Boxicons.bxl_google,
              size: 32.0,
              color: Colors.red,
            ),
            label: 'Google',
          ),
        ],
        onTap: null,
      ),
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

  bool isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InputWidget(
              hintText: 'Confirmar Senha',
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
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
