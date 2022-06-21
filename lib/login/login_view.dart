import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SignInScreen(
actions: [



   AuthStateChangeAction<SignedIn>((context, signedIn) async {
                    // await Get.find<LoginControler>().addUserFirestore(signedIn);
                   
                    // Get.to(()=>HomeView());
                  }),
],
                        
                                      subtitleBuilder: (context, action) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            action == AuthAction.signIn
                       ? 'Welcome to Baby Tracker app! Please sign in to continue.'
                       : 'Welcome to Baby Tracker app! Please create an account to continue',
                                          ),
                                        );
                                      },
                                      // footerBuilder: (context, _) {
                                      //   return const Padding(
                                      //     padding: EdgeInsets.only(top: 16),
                                      //     child: Text(
                                      //       'By signing in, you agree to our terms and conditions.',
                                      //       style: TextStyle(color: Colors.grey),
                                      //     ),
                                      //   );
                                      // },
                                      sideBuilder: (context, constraints) {
                                        return Image.asset("assets/images/portfolio_desktop_ss.png");
                                      },
                                      headerBuilder: (context, constraints, _) {
                                        return Image.asset("assets/images/portfolio_desktop_ss.png");
                                      },
                                      providerConfigs: [
                                      EmailProviderConfiguration()
                                      ]
                                      );
               
          
  }
}