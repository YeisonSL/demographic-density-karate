plugins {
    id("java")
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    testImplementation("com.intuit.karate:karate-junit5:1.2.0")

}

tasks.test {
    useJUnitPlatform()
}