import 'package:flutter/material.dart';
import 'package:eventify/config/app_colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 2,
          color: AppColors.darkOrange,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 2,
          color: AppColors.softOrange,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 120),
        
              Image.asset(
                'assets/images/eventify-logo.png',
                width: 220,
                height: 220,
              ),
        
              const SizedBox(height: 30),
        
              Container(
                padding: const EdgeInsets.all(20),
                width: 350,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    const Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'User',
                          style: TextStyle(
                            color: AppColors.burntOrange,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
        
                    TextField(
                      decoration: inputDecoration,
                    ),
        
                    const SizedBox(height: 20),
        
                    const Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Password',
                          style: TextStyle(
                            color: AppColors.burntOrange,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
        
                    TextField(
                      decoration: inputDecoration,
                    ),
                  ],
                ),
              ),

              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.darkOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                onPressed: () {},
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 90,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account yet?'),

                  const SizedBox(width: 10,),

                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.darkOrange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
