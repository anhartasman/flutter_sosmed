package com.fluttersosmed.app;

import static androidx.test.espresso.flutter.EspressoFlutter.onFlutterWidget;
import static androidx.test.espresso.flutter.action.FlutterActions.click;
import static androidx.test.espresso.flutter.action.FlutterActions.typeText;
import static androidx.test.espresso.flutter.action.FlutterActions.syntheticClick;
import static androidx.test.espresso.flutter.action.FlutterActions.scrollTo;
import static androidx.test.espresso.flutter.assertion.FlutterAssertions.matches;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.isDescendantOf;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.isExisting;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.withText;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.withTooltip;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.withType;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.withValueKey;
import static com.google.common.truth.Truth.assertThat;
import static org.junit.Assert.fail;

import androidx.test.core.app.ActivityScenario;
import androidx.test.espresso.flutter.EspressoFlutter.WidgetInteraction;
import androidx.test.espresso.flutter.assertion.FlutterAssertions;
import androidx.test.espresso.flutter.matcher.FlutterMatchers;
import androidx.test.ext.junit.runners.AndroidJUnit4;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

/** Unit tests for {@link EspressoFlutter}. */
@RunWith(AndroidJUnit4.class)
public class MainActivityTest {

    @Before
    public void setUp() throws Exception {
        ActivityScenario.launch(MainActivity.class);
    }

    @Test
    public void performClick() { 
        // onFlutterWidget(withValueKey("inputLokasiGPM")).perform(typeText("Jakarta")); 
        // try {
        //     Thread.sleep(3000);
        // } catch (InterruptedException e) {
        //     e.printStackTrace();
        // }
        // onFlutterWidget(withValueKey("btnSearch")).perform(click()); 
        onFlutterWidget(withValueKey("statDistribution")).perform(scrollTo());
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        onFlutterWidget(withValueKey("GPMFinish0")).perform(click()); 
        onFlutterWidget(withValueKey("googleMap")).check(matches(isExisting())); 
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        onFlutterWidget(withValueKey("btnDetail")).perform(click()); 
        onFlutterWidget(withValueKey("endList")).perform(scrollTo());
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void performAddAgenda() { 
        onFlutterWidget(withValueKey("inputLokasiGPM")).perform(typeText("Jakarta")); 
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        onFlutterWidget(withValueKey("btnSearch")).perform(click()); 
       
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        // onFlutterWidget(withValueKey("inputLokasiKegiatan")).perform(typeText("Jakarta Timur"));
        // try {
        //     Thread.sleep(3000);
        // } catch (InterruptedException e) {
        //     e.printStackTrace();
        // } 
        onFlutterWidget(withValueKey("btnKoordinat")).perform(scrollTo());
        onFlutterWidget(withValueKey("btnKoordinat")).perform(click()); 
       
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}