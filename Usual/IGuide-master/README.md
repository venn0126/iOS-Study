# IGuide

[![support](https://img.shields.io/badge/support-ios%209.0+-orange.svg)](#)
[![Version](https://img.shields.io/cocoapods/v/IGuide.svg?style=flat)](https://cocoapods.org/pods/IGuide)
[![License](https://img.shields.io/cocoapods/l/IGuide.svg?style=flat)](https://cocoapods.org/pods/IGuide)
[![Platform](https://img.shields.io/cocoapods/p/IGuide.svg?style=flat)](https://cocoapods.org/pods/IGuide)

🎃🎃🎃 一个轻量、灵活，用于制作新手引导教程的组件。使用该组件你可快速地为任意UIView或CGRect添加一个高颜值的图文注解。内置种类丰富的图文注解视图供你选择。注解与注解之间通过弹性动画切换。组件高度灵活、易扩展，每一个视图、每一个动画都可自定义，能满足你的各种定制需求。

使用Swift的同学可参考这个有 4.1k+ star 的库：[Instructions](https://github.com/ephread/Instructions)

##  ⚠️这里是广告⚠️
如果你喜欢Safari的简洁，又讨厌它的简陋，不妨试试我个人开发的一款iOS浏览器：[biubiu浏览器，极简设计神仙颜值](https://apps.apple.com/cn/app/id1474593656)

## Features

* 支持Swift项目；
* 可为任意UIView、CGRect添加注解；
* 可自定义注解视图；
* 可自定义指示器；
* 可自定义动画；
* 可自定义模糊效果；
* 可自定义任意按钮；
* 内置种类丰富的图文注解视图；
* 内置种类丰富的指示器视图；
* 轻量，总大小约74KB；
* 横屏适配；
* 长期维护；
* 为了避免遮挡，所有按钮都可拖动；
* 使用简单，一句代码调用；
* 哇竟然还有注释；

## Preview

![preview](/preview.gif)![preview](/preview2.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0+
- Objective-C

## Installation

IGuide is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'IGuide'
```

## Usage

Conforms to the protocol 'IGuideViewControllerDataSource', and then calls

```ruby
[IGuideViewController showsWithDataSource:self];
```

## Author

* Github: [@whatsbug](https://github.com/whatsbug)

## Show your support

如果这个项目对你有帮助的话，给颗小⭐️⭐️呗！(😆哈哈其实不给也没关系的🐶)

## License

IGuide is available under the MIT license. See the LICENSE file for more info.
