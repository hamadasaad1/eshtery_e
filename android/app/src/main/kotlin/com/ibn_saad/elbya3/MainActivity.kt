package com.ibn_saad.elbya3

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen

class MainActivity : FlutterActivity() {
    //this to open splash 
    override fun provideSplashScreen(): SplashScreen? = SplashView()
}
