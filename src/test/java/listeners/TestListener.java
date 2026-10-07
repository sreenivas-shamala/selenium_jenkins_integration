package test.java.listeners;

import test.java.tests.BaseTest;
import org.apache.commons.io.FileUtils;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.testng.ITestListener;
import org.testng.ITestResult;

import java.io.File;

public class TestListener implements ITestListener {

	@Override
	public void onTestFailure(ITestResult result) {

		Object currentClass = result.getInstance();

		if (currentClass instanceof BaseTest) {

			BaseTest test = (BaseTest) currentClass;

			try {

				File source = ((TakesScreenshot) test.driver).getScreenshotAs(OutputType.FILE);

				File destination = new File("screenshots/" + result.getName() + ".png");

				FileUtils.copyFile(source, destination);

				System.out.println("Screenshot saved: " + destination.getAbsolutePath());

			} catch (Exception e) {

				e.printStackTrace();
			}
		}
	}
}