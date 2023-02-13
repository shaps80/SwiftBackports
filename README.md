![watchOS](https://img.shields.io/badge/watchOS-DE1F51)
![macOS](https://img.shields.io/badge/macOS-EE751F)
![tvOS](https://img.shields.io/badge/tvOS-00B9BB)
![ios](https://img.shields.io/badge/iOS-0C62C7)
[![swift](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fshaps80%2FSwiftUIBackports%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/shaps80/SwiftBackports)

# Swift Backports

Introducing a collection of SwiftUI backports to make your iOS development easier.

Backports attempts to bring features back to the earliest possible versions of iOS to enable greater support for modern API.

> Note, **all** backports will be API-matching to Apple's official APIs, any additional features will not be provided.

All backports are fully documented, in most cases using Apple's own documentation for consistency. Please refer to the header docs or Apple's original documentation for more details.

> Lastly, I hope this repo also serves as a great resource for _how_ you can backport effectively with minimal hacks 👍

## Sponsor

Building useful libraries like these, takes time away from my family. I build these tools in my spare time because I feel its important to give back to the community. Please consider [Sponsoring](https://github.com/sponsors/shaps80) me as it helps keep me working on useful libraries like these 😬

You can also give me a follow and a 'thanks' anytime.

[![Twitter](https://img.shields.io/badge/Twitter-@shaps-4AC71B)](http://twitter.com/shaps)

## Usage

The library adopts a backport design by [Dave DeLong](https://davedelong.com/blog/2021/10/09/simplifying-backwards-compatibility-in-swift/) that makes use of a single type to improve discoverability and maintainability when the time comes to remove your backport implementations, in favour of official APIs.

Backports for types are discoverable under the `Backport.Foo` namespace. Similarly backported functions are discoverable via `backport.foo`.

> In some cases an entire framework has been backported.

## Backports

- `UniformTypeIdentifiers`
- `CoreTransferable`
- `URLSession` async methods

Where applicable, backports to associated APIs on other types (e.g. URL) will also be included as expected.

## Installation

You can install manually (by copying the files in the `Sources` directory) or using Swift Package Manager (**preferred**)

To install using Swift Package Manager, add this to the `dependencies` section of your `Package.swift` file:

`.package(url: "https://github.com/shaps80/SwiftBackports.git", .upToNextMinor(from: "1.0.0"))`
