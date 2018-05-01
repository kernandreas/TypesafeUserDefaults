import XCTest
@testable import TypesafeUserDefaults

final class TypesafeUserDefaultsTests: XCTestCase {

    struct Custom: CustomDefaultsArchivable, Equatable {
        let number: Int
    }

    let defaults = UserDefaults.standard

    let array = [0, 1, 2]
    let bool = true
    let data = Data(count: 0)
    let date = Date()
    let dictionary = ["key": "value"]
    let double: Double = 1.0
    let float: Float = 1.0
    let int: Int = 1
    let string = "string"
    let url = URL(fileURLWithPath: "path")
    let custom = Custom(number: 0)

    let arrayKey = UserDefaults.Key<Array<Int>>("array")
    let boolKey = UserDefaults.Key<Bool>("bool")
    let dataKey = UserDefaults.Key<Data>("data")
    let dateKey = UserDefaults.Key<Date>("date")
    let dictionaryKey = UserDefaults.Key<Dictionary<String, String>>("dictionary")
    let doubleKey = UserDefaults.Key<Double>("double")
    let floatKey = UserDefaults.Key<Float>("float")
    let intKey = UserDefaults.Key<Int>("int")
    let stringKey = UserDefaults.Key<String>("string")
    let urlKey = UserDefaults.Key<URL>("url")
    let customKey = UserDefaults.Key<Custom>("custom")

    let defaultArray = [1, 2, 3]
    let defaultBool = false
    let defaultData = Data(count: 1)
    let defaultDate = Date()
    let defaultDictionary = ["key": "defaultValue"]
    let defaultDouble: Double = 2.0
    let defaultFloat: Float = 2.0
    let defaultInt: Int = 2
    let defaultString = "defaultString"
    let defaultUrl = URL(fileURLWithPath: "defaultPath")
    let defaultCustom = Custom(number: 1)

    lazy var arrayDefaultKey = { UserDefaults.DefaultKey<Array<Int>>("defaultArray", defaultArray) }()
    lazy var boolDefaultKey = { UserDefaults.DefaultKey<Bool>("defaultBool", defaultBool) }()
    lazy var dataDefaultKey = { UserDefaults.DefaultKey<Data>("defaultData", defaultData) }()
    lazy var dateDefaultKey = { UserDefaults.DefaultKey<Date>("defaultDate", defaultDate) }()
    lazy var dictionaryDefaultKey = { UserDefaults.DefaultKey<Dictionary<String, String>>("defaultDictionary", defaultDictionary) }()
    lazy var doubleDefaultKey = { UserDefaults.DefaultKey<Double>("defaultDouble", defaultDouble) }()
    lazy var floatDefaultKey = { UserDefaults.DefaultKey<Float>("defaultFloat", defaultFloat) }()
    lazy var intDefaultKey = { UserDefaults.DefaultKey<Int>("defaultInt", defaultInt) }()
    lazy var stringDefaultKey = { UserDefaults.DefaultKey<String>("defaultString", defaultString) }()
    lazy var urlDefaultKey = { UserDefaults.DefaultKey<URL>("defaultUrl", defaultUrl) }()
    lazy var customDefaultKey = { UserDefaults.DefaultKey<Custom>("defaultCustom", defaultCustom) }()

    override func setUp() {
        super.setUp()
        defaults.dictionaryRepresentation().keys.forEach(defaults.removeObject)
    }

    func testKeyAccessors() {
        XCTAssertNil(defaults.value(forKey: arrayKey))
        XCTAssertNil(defaults.value(forKey: boolKey))
        XCTAssertNil(defaults.value(forKey: dataKey))
        XCTAssertNil(defaults.value(forKey: dateKey))
        XCTAssertNil(defaults.value(forKey: doubleKey))
        XCTAssertNil(defaults.value(forKey: floatKey))
        XCTAssertNil(defaults.value(forKey: intKey))
        XCTAssertNil(defaults.value(forKey: stringKey))
        XCTAssertNil(defaults.value(forKey: urlKey))
        XCTAssertNil(defaults.value(forKey: customKey))

        defaults.set(array, forKey: arrayKey)
        defaults.set(bool, forKey: boolKey)
        defaults.set(data, forKey: dataKey)
        defaults.set(date, forKey: dateKey)
        defaults.set(double, forKey: doubleKey)
        defaults.set(float, forKey: floatKey)
        defaults.set(int, forKey: intKey)
        defaults.set(string, forKey: stringKey)
        defaults.set(url, forKey: urlKey)
        defaults.set(custom, forKey: customKey)

        XCTAssertEqual(defaults.value(forKey: arrayKey), array)
        XCTAssertEqual(defaults.value(forKey: boolKey), bool)
        XCTAssertEqual(defaults.value(forKey: dataKey), data)
        XCTAssertEqual(defaults.value(forKey: dateKey), date)
        XCTAssertEqual(defaults.value(forKey: doubleKey), double)
        XCTAssertEqual(defaults.value(forKey: floatKey), float)
        XCTAssertEqual(defaults.value(forKey: intKey), int)
        XCTAssertEqual(defaults.value(forKey: stringKey), string)
        XCTAssertEqual(defaults.value(forKey: urlKey)?.absoluteString, url.absoluteString)
        XCTAssertEqual(defaults.value(forKey: customKey), custom)
    }

    func testKeySubscripts() {
        XCTAssertNil(defaults[arrayKey])
        XCTAssertNil(defaults[boolKey])
        XCTAssertNil(defaults[dataKey])
        XCTAssertNil(defaults[dateKey])
        XCTAssertNil(defaults[doubleKey])
        XCTAssertNil(defaults[floatKey])
        XCTAssertNil(defaults[intKey])
        XCTAssertNil(defaults[stringKey])
        XCTAssertNil(defaults[urlKey])
        XCTAssertNil(defaults[customKey])

        defaults[arrayKey] = array
        defaults[boolKey] = bool
        defaults[dataKey] = data
        defaults[dateKey] = date
        defaults[doubleKey] = double
        defaults[floatKey] = float
        defaults[intKey] = int
        defaults[stringKey] = string
        defaults[urlKey] = url
        defaults[customKey] = custom

        XCTAssertEqual(defaults[arrayKey], array)
        XCTAssertEqual(defaults[boolKey], bool)
        XCTAssertEqual(defaults[dataKey], data)
        XCTAssertEqual(defaults[dateKey], date)
        XCTAssertEqual(defaults[doubleKey], double)
        XCTAssertEqual(defaults[floatKey], float)
        XCTAssertEqual(defaults[intKey], int)
        XCTAssertEqual(defaults[stringKey], string)
        XCTAssertEqual(defaults[urlKey]?.absoluteString, url.absoluteString)
        XCTAssertEqual(defaults[customKey], custom)
    }

    func testDefaultKeyAccessors() {
        XCTAssertEqual(defaults.value(forKey: arrayDefaultKey), defaultArray)
        XCTAssertEqual(defaults.value(forKey: boolDefaultKey), defaultBool)
        XCTAssertEqual(defaults.value(forKey: dataDefaultKey), defaultData)
        XCTAssertEqual(defaults.value(forKey: dateDefaultKey), defaultDate)
        XCTAssertEqual(defaults.value(forKey: doubleDefaultKey), defaultDouble)
        XCTAssertEqual(defaults.value(forKey: floatDefaultKey), defaultFloat)
        XCTAssertEqual(defaults.value(forKey: intDefaultKey), defaultInt)
        XCTAssertEqual(defaults.value(forKey: stringDefaultKey), defaultString)
        XCTAssertEqual(defaults.value(forKey: urlDefaultKey).absoluteString, defaultUrl.absoluteString)
        XCTAssertEqual(defaults.value(forKey: customDefaultKey), defaultCustom)

        defaults.set(array, forKey: arrayDefaultKey)
        defaults.set(bool, forKey: boolDefaultKey)
        defaults.set(data, forKey: dataDefaultKey)
        defaults.set(date, forKey: dateDefaultKey)
        defaults.set(double, forKey: doubleDefaultKey)
        defaults.set(float, forKey: floatDefaultKey)
        defaults.set(int, forKey: intDefaultKey)
        defaults.set(string, forKey: stringDefaultKey)
        defaults.set(url, forKey: urlDefaultKey)
        defaults.set(custom, forKey: customDefaultKey)

        XCTAssertEqual(defaults.value(forKey: arrayDefaultKey), array)
        XCTAssertEqual(defaults.value(forKey: boolDefaultKey), bool)
        XCTAssertEqual(defaults.value(forKey: dataDefaultKey), data)
        XCTAssertEqual(defaults.value(forKey: dateDefaultKey), date)
        XCTAssertEqual(defaults.value(forKey: doubleDefaultKey), double)
        XCTAssertEqual(defaults.value(forKey: floatDefaultKey), float)
        XCTAssertEqual(defaults.value(forKey: intDefaultKey), int)
        XCTAssertEqual(defaults.value(forKey: stringDefaultKey), string)
        XCTAssertEqual(defaults.value(forKey: urlDefaultKey).absoluteString, url.absoluteString)
        XCTAssertEqual(defaults.value(forKey: customDefaultKey), custom)
    }

    func testDefaultKeySubscripts() {
        XCTAssertEqual(defaults[arrayDefaultKey], defaultArray)
        XCTAssertEqual(defaults[boolDefaultKey], defaultBool)
        XCTAssertEqual(defaults[dataDefaultKey], defaultData)
        XCTAssertEqual(defaults[dateDefaultKey], defaultDate)
        XCTAssertEqual(defaults[doubleDefaultKey], defaultDouble)
        XCTAssertEqual(defaults[floatDefaultKey], defaultFloat)
        XCTAssertEqual(defaults[intDefaultKey], defaultInt)
        XCTAssertEqual(defaults[stringDefaultKey], defaultString)
        XCTAssertEqual(defaults[urlDefaultKey].absoluteString, defaultUrl.absoluteString)
        XCTAssertEqual(defaults[customDefaultKey], defaultCustom)

        defaults[arrayDefaultKey] = array
        defaults[boolDefaultKey] = bool
        defaults[dataDefaultKey] = data
        defaults[dateDefaultKey] = date
        defaults[doubleDefaultKey] = double
        defaults[floatDefaultKey] = float
        defaults[intDefaultKey] = int
        defaults[stringDefaultKey] = string
        defaults[urlDefaultKey] = url
        defaults[customDefaultKey] = custom

        XCTAssertEqual(defaults[arrayDefaultKey], array)
        XCTAssertEqual(defaults[boolDefaultKey], bool)
        XCTAssertEqual(defaults[dataDefaultKey], data)
        XCTAssertEqual(defaults[dateDefaultKey], date)
        XCTAssertEqual(defaults[doubleDefaultKey], double)
        XCTAssertEqual(defaults[floatDefaultKey], float)
        XCTAssertEqual(defaults[intDefaultKey], int)
        XCTAssertEqual(defaults[stringDefaultKey], string)
        XCTAssertEqual(defaults[urlDefaultKey].absoluteString, url.absoluteString)
        XCTAssertEqual(defaults[customDefaultKey], custom)
    }

    static var allTests = [
        ("testKeyAccessors", testKeyAccessors),
        ("testKeySubscripts", testKeySubscripts),
        ("testDefaultKeyAccessors", testDefaultKeyAccessors),
        ("testDefaultKeySubscripts", testDefaultKeySubscripts)
    ]
}
