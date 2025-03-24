import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/features/feature.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Color? color, colors;
  @override
  void initState() {
    Get.put(LoginController());
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().remember = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    colors = isDarkMode ? Colors.white : Colors.black;
    color = isDarkMode ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: colors,
      body: GetBuilder<LoginController>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Image.asset(
                    'assets/images/backg.png',
                    fit: BoxFit.contain,
                    height: size.height * 0.1,
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    padding: EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    width: size.width,
                    height: size.height * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                      color: color,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        CustomFormField(
                          title1: 'Email',
                          controller: controller.emailController,
                          focusNode: controller.emailFocusNode,
                          nextFocus: controller.passwordFocusNode,
                          onChange: (p0) {},
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                        ),
                        CustomFormField(
                          title1: 'Password',
                          controller: controller.passwordController,
                          focusNode: controller.passwordFocusNode,
                          onChange: (p0) {},
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.multiline,
                          isPassword: true,
                          suffixIcon: true,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 25,
                                width: 25,
                                child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    activeColor: Colors.green,
                                    checkColor: colors,
                                    value: controller.remember,
                                    side: WidgetStateBorderSide.resolveWith(
                                      (state) => BorderSide(
                                        width: 1.0,
                                        color: controller.remember
                                            ? color!
                                            : colors!,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        controller.changeRememberMe();
                                      });
                                    }),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Remember Me')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        SizedBox(
                          width: size.width * 0.7,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.logIn();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class CustomFormField extends StatefulWidget {
  final String title1;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Function(String)? onChange;
  final bool suffixIcon;
  final bool isPassword;

  const CustomFormField({
    super.key,
    required this.title1,
    required this.controller,
    required this.focusNode,
    this.nextFocus,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.onChange,
    this.suffixIcon = false,
    this.isPassword = false,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.title1,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            onFieldSubmitted: (text) {
              if (widget.nextFocus != null) {
                FocusScope.of(context).requestFocus(widget.nextFocus);
              }
            },
            textInputAction: widget.textInputAction,
            keyboardType: widget.textInputType,
            obscureText: widget.isPassword ? obscureText : false,
            onChanged: widget.onChange,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon && widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
