package test.java.tests;

import test.java.tests.BaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;
import org.openqa.selenium.By;

public class RegistrationTest extends BaseTest {

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
    public void verifyFlaskRegistration() {
        String appUrl = System.getProperty("app.url","http://flask-registration-service");

        driver.get(appUrl);

        String title = driver.getTitle();
        System.out.println("Page title: " + title);
        System.out.println("Page Url: " + appUrl);

        driver.findElement(By.name("name")).sendKeys("admin");
        driver.findElement(By.name("email")).sendKeys("admin@gmail.com");
        driver.findElement(By.name("password")).sendKeys("admin");

        driver.findElement(By.cssSelector("button[type='submit']")).click();

        String result = driver.findElement(By.tagName("p")).getText();
        Assert.assertTrue(result.toLowerCase().contains("Registration"),
                "Registration in Paragraph Text was not found"
        );
    }
}
