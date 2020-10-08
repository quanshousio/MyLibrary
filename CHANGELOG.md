# Change Log

All notable changes to this project will be documented in this file. `ToastUI` adheres to [Semantic Versioning](https://semver.org/).

#### 1.x Releases

* `1.2.x` Releases - [1.2.0](#120)
* `1.1.x` Releases - [1.1.0](#110) | [1.1.1](#111)
* `1.0.x` Releases - [1.0.0](#100) | [1.0.1](#101) | [1.0.2](#102)

---

## [1.2.0](https://github.com/quanshousio/ToastUI/releases/tag/1.2.0)

Released on 2020-10-08.

#### Added

* New logo for `ToastUI` .
  + Added by [Quan Tran](https://github.com/quanshousio) in Pull Request [#11](https://github.com/quanshousio/ToastUI/pull/11).
* Support for custom background in `ToastView` .
  + Added by [Quan Tran](https://github.com/quanshousio) in Pull Request [#11](https://github.com/quanshousio/ToastUI/pull/11).

#### Updated

* `cocoaBlur()` modifier adds `VisualEffectView` as a background instead of using `ZStack` .
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#11](https://github.com/quanshousio/ToastUI/pull/11).
* Default `UIBlurEffectStyle` for blurred background in `ToastView` is `.prominent` for both iOS and tvOS.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#11](https://github.com/quanshousio/ToastUI/pull/11).
* Utilize Swift 5.3 functionalities.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#11](https://github.com/quanshousio/ToastUI/pull/11).
* Documentation and README.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#11](https://github.com/quanshousio/ToastUI/pull/11).

#### Fixed

* Incorrect `keyWindow` is used in callbacks when there are multiple foreground active scenes.
  + Fixed by [Quan Tran](https://github.com/quanshousio) in Pull Request [#11](https://github.com/quanshousio/ToastUI/pull/11).

---

## [1.1.1](https://github.com/quanshousio/ToastUI/releases/tag/1.1.1)

Released on 2020-10-05.

#### Updated

* Minor code formatting and SwiftLint rules.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#10](https://github.com/quanshousio/ToastUI/pull/10).

#### Fixed

* Use Xcode 12 explicitly on GitHub virtual environment.
  + Fixed by [Quan Tran](https://github.com/quanshousio) in Pull Request [#10](https://github.com/quanshousio/ToastUI/pull/10).

## [1.1.0](https://github.com/quanshousio/ToastUI/releases/tag/1.1.0)

Released on 2020-10-05.

#### Added

* SwiftLint to enforce Swift conventions.
  + Added by [Quan Tran](https://github.com/quanshousio) in Pull Request [#9](https://github.com/quanshousio/ToastUI/pull/9).

#### Updated

* Minimum required version for Swift is 5.3.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#9](https://github.com/quanshousio/ToastUI/pull/9).
* Minor code formatting, GitHub actions and filename changes.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#9](https://github.com/quanshousio/ToastUI/pull/9).
* Remove redundant unit tests.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#9](https://github.com/quanshousio/ToastUI/pull/9).

#### Fixed

* Memory leak due to improper asynchronous usage of `UIViewPropertyAnimator` in `VisualEffectView` .
  + Fixed by [Quan Tran](https://github.com/quanshousio) in Pull Request [#9](https://github.com/quanshousio/ToastUI/pull/9).

---

## [1.0.2](https://github.com/quanshousio/ToastUI/releases/tag/1.0.2)

Released on 2020-08-16.

#### Added

* GitHub actions for building package and documentation.
  + Added by [Quan Tran](https://github.com/quanshousio) in Pull Request [#7](https://github.com/quanshousio/ToastUI/pull/7).

#### Updated

* Rename `VisualEffectBlur` to `VisualEffectView` .
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#7](https://github.com/quanshousio/ToastUI/pull/7).
* Documentation and README.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#7](https://github.com/quanshousio/ToastUI/pull/7).

#### Fixed

* Typos and formatting in ToastUISample.
  + Fixed by [Quan Tran](https://github.com/quanshousio) in Pull Request [#7](https://github.com/quanshousio/ToastUI/pull/7).
* Exception when property animator is not properly released.
  + Fixed by [Quan Tran](https://github.com/quanshousio) in Pull Request [#7](https://github.com/quanshousio/ToastUI/pull/7).

## [1.0.1](https://github.com/quanshousio/ToastUI/releases/tag/1.0.1)

Released on 2020-08-13.

#### Added

* GitHub issue and pull request templates.
  + Added by [Lucas Desouza](https://github.com/LucasCarioca) in Pull Request [#1](https://github.com/quanshousio/ToastUI/pull/1).

#### Fixed

* Content view is not properly laid out when boolean binding is triggered in `onAppear()` .
  + Fixed by [Quan Tran](https://github.com/quanshousio) in Pull Request [#3](https://github.com/quanshousio/ToastUI/pull/3).

## [1.0.0](https://github.com/quanshousio/ToastUI/releases/tag/1.0.0)

Released on 2020-08-04.

#### Added

* Initial release of `ToastUI` .
  + Added by [Quan Tran](https://github.com/quanshousio).
