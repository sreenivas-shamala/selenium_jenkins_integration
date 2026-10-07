package test.java.tests;

import test.java.tests.BaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

public class LoginTest extends BaseTest {

    @Test
    public void verifyGoogleTitle() {

        driver.get("https://www.google.com");

        String title = driver.getTitle();

        System.out.println("Page title: " + title);

        Assert.assertTrue(
                title.toLowerCase().contains("google"),
                "Google title was not found"
        );
    }
}