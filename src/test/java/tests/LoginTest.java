package test.java.tests;

import test.java.tests.BaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;
import org.openqa.selenium.By;

public class LoginTest extends BaseTest {

    @Test
    public void verifyGoogleTitle() {
        //String appUrl = System.getProperty("app.url","http://flask-app-service");

        //driver.get(appUrl);
        driver.get("https://www.google.com");

        String title = driver.getTitle();

        System.out.println("Page title: " + title);

        Assert.assertTrue(
                title.toLowerCase().contains("google"),
                "Google title was not found"
        );
    }

    @Test
    public void verifyFlaskApp() {
        String appUrl = System.getProperty("app.url","http://flask-app-service");

        driver.get(appUrl);

        String title = driver.getTitle();
        System.out.println("Page title: " + title);
        System.out.println("Page Url: " + appUrl);

        String bodyText = driver.findElement(By.tagName("body")).getText();
        System.out.println(bodyText);
        
        Assert.assertTrue(bodyText.toLowerCase().contains("fask"),
                "Flask in Body Text was not found"
        );
    }
}
