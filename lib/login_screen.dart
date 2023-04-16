import 'package:flutter/material.dart';
import 'package:test/second_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  ValueNotifier<bool> isBtnVisible = ValueNotifier<bool>(false);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void onTextChanged() {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length >= 6) {
      isBtnVisible.value = true;
    } else {
      isBtnVisible.value = false;
    }
  }

  void onBtnSubmit() {
    if (isBtnVisible.value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ThirdScreen()));
    }
  }

  ValueNotifier<Color> shadowColor =
      ValueNotifier<Color>(const Color.fromARGB(255, 201, 201, 201));
  ValueNotifier<bool> isVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  onChanged: (value) {
                    onTextChanged();
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      //  hintText: "Email",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 209, 209, 209),
                              width: 2))),
                ),
                const SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder<Color>(
                  valueListenable: shadowColor,
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: value, width: 1),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 1.5),
                                color: value,
                                blurRadius: 0.0,
                                spreadRadius: 0.5)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: Focus(
                          child: ValueListenableBuilder<bool>(
                            valueListenable: isVisible,
                            builder: (BuildContext context, dynamic value,
                                Widget? child) {
                              return TextFormField(
                                onChanged: (pass) {
                                  onTextChanged();
                                },
                                obscureText: value,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      color: Colors.black,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        if (isVisible.value) {
                                          isVisible.value = false;
                                        } else {
                                          isVisible.value = true;
                                        }
                                      },
                                      icon: isVisible.value
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  border: InputBorder.none,
                                  hintText: "Password",
                                ),
                              );
                            },
                          ),
                          onFocusChange: (value) {
                            if (value) {
                              shadowColor.value = Colors.black;
                            } else {
                              shadowColor.value =
                                  const Color.fromARGB(255, 201, 201, 201);
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: isBtnVisible,
                    builder: (context, value, _) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fixedSize: Size(size.width, 50),
                            backgroundColor:
                                value ? Colors.amber : Colors.grey),
                        onPressed: onBtnSubmit,
                        child: const Text("Submit"),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}


