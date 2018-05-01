# Typesafe UserDefaults

[![Build Status](https://travis-ci.org/kernandreas/TypesafeUserDefaults.svg?branch=master)](https://travis-ci.org/kernandreas/TypesafeUserDefaults)

TypesafeUserDefaults is a thin extension to UserDefaults that enables a type safe use. As a bonus, Types that conform to Codable can be stored in the UserDefaults.

## Features

### Strongly Typed

Define the keys:
``` Swift
enum UserKeys {
    static let name = UserDefaults.Key<String>("name")
    static let date = UserDefaults.Key<Date>("date")
}
```

Use them like the classic UserDefaults API:
``` Swift
UserDefaults.standard.set("Max Mustermann", forKey: UserKeys.name)
UserDefaults.standard.set(Date(), forKey: UserKeys.date)

let name = UserDefaults.standard.value(forKey: UserKeys.name)
let date = UserDefaults.standard.value(forKey: UserKeys.date)
```

Or use the convenient subscript:
``` Swift
UserDefaults.standard[UserKeys.name] = "Max Mustermann"
UserDefaults.standard[UserKeys.date] = Date()

let name = UserDefaults.standard[UserKeys.name]
let date = UserDefaults.standard[UserKeys.date]
```

The compiler will tell you if something is wrong:
``` Swift
// UIImage is not archivable in UserDefaults
let imageKey = UserDefaults.Key<UIImage>("image")

// Assigning value of type Date to a key that defined the value to be String
UserDefaults.standard[UserKeys.name] = Date()

// The return type does not match the type of the value
let date: Date = UserDefaults.standard[UserKeys.name]
```

### Provide Default Values

### Store Codable Types

Conform to `CustomDefaultsArchivable`:
``` Swift
struct User: CustomDefaultsArchivable {
    let name: String
    let date: Date
}
```

Define the key:
``` Swift
let userKey = UserDefaults.Key<User>("user")
```

Use the key:
``` Swift
UserDefaults.standard[userKey] = User(name: "Max Mustermann", date: Date())
let name = UserDefaults.standard[userKey]?.name
let date = UserDefaults.standard[userKey]?.date
```