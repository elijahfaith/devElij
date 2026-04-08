//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//
//val newBuildDir: Directory =
//    rootProject.layout.buildDirectory
//        .dir("../../build")
//        .get()
//rootProject.layout.buildDirectory.value(newBuildDir)
//
//subprojects {
//    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//    project.layout.buildDirectory.value(newSubprojectBuildDir)
//}
//subprojects {
//    project.evaluationDependsOn(":app")
//}
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.4.2")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }

    subprojects {
        configurations.all {
            resolutionStrategy {
                // Optional — only if needed to avoid version conflict
                force("com.google.android.play:core:1.10.3")
                force("com.google.android.play:core-ktx:1.8.1")
                force("com.google.android.play:core-common:1.10.3")
            }
        }
    }
}

rootProject.buildDir = file("../build")

subprojects {
    buildDir = file("${rootProject.buildDir}/${name}")
    evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
