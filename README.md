# Pre-work - *Tipper*

**Tipper** is a tip calculator application for iOS.

Submitted by: **Soumik Barua**

Time spent: **20+** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.

The following **optional** features are implemented:
* [x] Settings page to change the default tip percentage.
* [ ] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!
* [x] Using a slider to provide more flexibility in tip percentages compared to a segmented control
* [x] Prevent the user from entering more than one decimal separator in the bill amount text field.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

1. It was tricky to figure out where to call UserDefaults to save the bill amount in order to remember it for restarts <10 mins.
2. The main screen updated the slider after coming back from the settings screen despite no changes in the default tip percentage. So I kept track of the default tip with a variable in main VC to see if it has changed from the last time.

## License

    Copyright [2020] [Soumik Barua]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
