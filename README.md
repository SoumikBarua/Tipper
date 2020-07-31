# Pre-work - *Tipper*

**Tipper** is a tip calculator application for iOS.

Submitted by: **Soumik Barua**

Time spent: **40+** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.

The following **optional** features are implemented:
* [x] Settings page to change the default tip percentage
* [x] UI animations (bill splitter slides in/out)
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators (see tip amount & total amount labels)
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!
* [x] Creating a *slider* to provide more flexibility in tip percentages compared to a segmented control 
* [x] Making a *splitting* feature with a stepper to adjust how many ways to split
* [x] Adding a *light/dark color theme* to the settings view. In viewWillAppear, update views with the correct theme colors
* [x] Using locale-specific *decimal separator* in labels and updating any decimal separator in bill amount textfield to reflect any region changes
* [x] Making a *LaunchScreen* for a smoother user experience & adding app icons for a more polished look
* [x] Preventing the user from entering the following in the bill amount text field: more than one decimal separator, a leading zero (unless it's a fractional value less than 1), a leading decimal separator, and more than two digits after the decimal point

## Video Walkthrough 

This GIF shows the app in action with the required and the additional features.

![Tipper Walkthrough](walkthrough.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

1. It was tricky to figure out where to call UserDefaults to save the bill amount in order to remember it for restarts <10 mins.
2. The main screen updated the slider after coming back from the settings screen despite no changes in the default tip percentage. So I kept track of the default tip with a variable in main VC to see if it has changed from the last time.
3. The most challenging part was the UI animation for the bill splitting feature.

## License

    Copyright 2020 Soumik Barua

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
