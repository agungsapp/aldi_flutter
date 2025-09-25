plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // ✅ gunakan plugin resmi kotlin-android
    id("dev.flutter.flutter-gradle-plugin")
    // id("com.google.gms.google-services") // aktifkan jika nanti pakai Firebase
}

android {
    namespace = "com.example.notifikasi"
    compileSdk = 36 // ✅ ganti ke 34 (36 belum resmi stabil di Flutter)

    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17 // ✅ naikkan ke 17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17" // ✅ sesuaikan dengan compileOptions
    }

    defaultConfig {
        applicationId = "com.example.notifikasi"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.22") // ✅ pakai stdlib biasa, versi terbaru
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    implementation("androidx.multidex:multidex:2.0.1")
}
