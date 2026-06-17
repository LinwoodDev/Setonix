import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import java.util.Properties
import java.io.FileInputStream

val androidHostTag = when {
    System.getProperty("os.name").startsWith("Windows", ignoreCase = true) -> "windows-x86_64"
    System.getProperty("os.name").startsWith("Mac", ignoreCase = true) -> "darwin-x86_64"
    else -> "linux-x86_64"
}

val androidLibcxxAbis = mapOf(
    "arm64-v8a" to "aarch64-linux-android",
    "armeabi-v7a" to "arm-linux-androideabi",
    "x86" to "i686-linux-android",
    "x86_64" to "x86_64-linux-android",
)

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "dev.linwood.setonix"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // Flutter-friendly toggles:
    // - Env: USE_LEGACY_PACKAGING=true
    val useLegacy = (System.getenv("USE_LEGACY_PACKAGING") ?: "false").toBoolean()

    packaging {
        jniLibs {
            useLegacyPackaging = useLegacy
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    flavorDimensions += "default"
    productFlavors {
        create("production") {
            dimension = "default"
            applicationIdSuffix = ""
            manifestPlaceholders["appName"] = "Setonix"
        }
        create("development") {
            dimension = "default"
            applicationIdSuffix = ""
            manifestPlaceholders["appName"] = "Setonix Nightly"
        }
        create("nightly") {
            dimension = "default"
            applicationIdSuffix = ".nightly"
            manifestPlaceholders["appName"] = "Setonix Nightly"
        }
    }

    sourceSets {
        getByName("main") {
            jniLibs.srcDir(layout.buildDirectory.dir("generated/libcxxShared"))
        }
        getByName("nightly") {
            setRoot("src/development")
        }
    }

    defaultConfig {
        applicationId = "dev.linwood.setonix"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        release {
            // Use your release keystore if available, fall back to debug key
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
    dependenciesInfo {
        // Disables dependency metadata when building APKs.
        includeInApk = false
        // Disables dependency metadata when building Android App Bundles.
        includeInBundle = false
    }
}

kotlin {
    compilerOptions {
        jvmTarget = JvmTarget.fromTarget("17")
    }
}

flutter {
    source = "../.."
}

val copyAndroidLibcxxShared by tasks.registering(Copy::class) {
    val ndkSysrootLib = providers.provider {
        android.ndkDirectory.resolve(
            "toolchains/llvm/prebuilt/$androidHostTag/sysroot/usr/lib",
        )
    }

    for ((abi, triple) in androidLibcxxAbis) {
        from(ndkSysrootLib.map { it.resolve("$triple/libc++_shared.so") }) {
            into(abi)
        }
    }
    into(layout.buildDirectory.dir("generated/libcxxShared"))
}

tasks.configureEach {
    if (name.startsWith("merge") && name.endsWith("JniLibFolders")) {
        dependsOn(copyAndroidLibcxxShared)
    }
}
