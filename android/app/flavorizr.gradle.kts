import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("api")

    productFlavors {
        create("development") {
            dimension = "api"
            applicationId = "com.codenour.travel_guide.dev"
            resValue(type = "string", name = "app_name", value = "Travel Guide Dev")
        }
        create("production") {
            dimension = "api"
            applicationId = "com.codenour.travel_guide"
            resValue(type = "string", name = "app_name", value = "Travel Guide")
        }
    }
}