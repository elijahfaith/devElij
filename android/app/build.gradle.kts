plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.link_go"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"
//    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.link_go"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Use debug signing for testing
            signingConfig = signingConfigs.getByName("debug") // Removed semicolon and used '='

            // Disable minification/shrinking to avoid R8 errors
            isMinifyEnabled = false // Changed 'minifyEnabled false;' to 'isMinifyEnabled = false'
            isShrinkResources = false // Changed 'shrinkResources false;' to 'isShrinkResources = false'

            // Optional: keep proguard rules if you want later
            // proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.8.22")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    implementation("com.google.android.play:core:1.10.3") {
        exclude(group = "com.google.android.play", module = "core-common")
    }
}
