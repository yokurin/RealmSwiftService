# RealmSwiftService

Support default CRUD functions.

<!--[![CI Status](https://img.shields.io/travis/yokurin/RealmSwiftService.svg?style=flat)](https://travis-ci.org/yokurin/RealmSwiftService)-->
<!-- [![Language](https://img.shields.io/badge/language-Swift%204.2-orange.svg)](https://swift.org)
[![Version](https://img.shields.io/cocoapods/v/RealmSwiftService.svg?style=flat)](https://cocoapods.org/pods/RealmSwiftService)
[![License](https://img.shields.io/cocoapods/l/RealmSwiftService.svg?style=flat)](https://cocoapods.org/pods/RealmSwiftService)
[![Platform](https://img.shields.io/cocoapods/p/RealmSwiftService.svg?style=flat)](https://cocoapods.org/pods/RealmSwiftService) -->
[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=for-the-badge)](https://developer.apple.com/iphone/index.action)
<!--[![Cocoapods](https://img.shields.io/badge/Cocoapods-compatible-brightgreen.svg?style=for-the-badge)](https://img.shields.io/badge/Cocoapods-compatible-brightgreen.svg)-->
<!--[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=for-the-badge)](https://github.com/Carthage/Carthage)-->
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=for-the-badge)](http://mit-license.org)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Open `Example/RealmSwiftService.xcworkspace` and run `Example` to see a simple demonstration.

## Functions

```swift
all() -> Results<ObjectType>
find(by key: Any) -> ObjectType?
first() -> ObjectType?
last() -> ObjectType?
deleteAll() throws -> Bool
delete(list: List<ObjectType>) throws -> Bool
save(update: Bool) throws -> Bool
delete() throws -> Bool
```

## Usages

Support 2 way implementation.

### 1. Implements `RealmAccessible` Protocol ( Protocol Extension )

```swift
@objcMembers
class Cat: Object, RealmAccessible {

    dynamic var id = UUID().uuidString
    dynamic var name = ""

    override static func primaryKey() -> String? { return "id" }

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

// Save Realm Object
let cat = Cat(name: "tama")
try! cat.save()

// Get Realm Objects
Cat.all().forEach { print("\($0.name)-\($0.id)") } // tama-UUIDString

// RealmAccessible Example
let cat = Cat(name: "tama")  // Create Realm Object
_ = Cat.all()                // Get All Object of Cat
_ = Cat.find(by: "id")       // Find Cat by id property
_ = Cat.first()              // Get Last Object of Cat
_ = Cat.last()               // Get First Object of Cat
try! cat.save()              // Save Object of Cat
try! cat.delete()            // Delete Object of Cat
try! Cat.deleteAll()         // Delete All Object of Cat


```

### 2. Use RealmDao
```swift
@objcMembers
class Dog: Object {

    dynamic var id = UUID().uuidString
    dynamic var name = ""

    override static func primaryKey() -> String? { return "id" }

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

// Save Realm Object
let dao = RealmDao<Dog>()
let dog = Dog(name: "pochi")
dao.save(dog)

// Get Realm Objects
dao.all().forEach { print("\($0.name)-\($0.id)") } // pochi-UUIDString

// Dao Example
let dao = RealmDao<Dog>()    // Create Dao of Dog
let dog = Dog(name: "pochi") // Create Realm Object
_ = dao.all()                // Get All Object of Dog
_ = dao.find(by: "id")       // Find Dog by id property
_ = dao.first()              // Get First Object of Dog
_ = dao.last()               // Get Last Object of Dog
try! dao.save(dog)           // Save Object of Dog
try! dao.delete(dog)         // Delete Object of Dog
try! dao.deleteAll()         // Delete All Object of Dog

```


## Requirements

- iOS 10.0+
- Xcode 10.0+
- Swift 4.2+

## Installation

### Manual

Add RealmAccessible.swift, RealmDao.swift into your Project.

### CocoaPods
WIP...

RealmSwiftService is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RealmSwiftService'
```

and run `pod install`

## Author

Tsubasa Hayashi, yoku.rin.99@gmail.com

## License

RealmSwiftService is available under the MIT license. See the LICENSE file for more info.
