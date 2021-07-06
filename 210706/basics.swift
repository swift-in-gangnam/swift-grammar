// Dongyoung Kwon @Chuncheonian (ehddud2468@gmail.com)
// Variable, Constant, Data Types

// 1. Variable (변수)
// * var [변수명]: [데이터 타입] = [value]
// * R/W (Read & Write)
var temp: String = "Hello, Swift World"
print(temp)

temp = "Bye, Swift World"  // 변수는 값 변경 가능
print(temp)

// 2. Constant (상수)
// * let [상수명]: [데이터 타입] = [value]
// * R (Only Read)
// * 가능할 때 마다 let를 사용하자
let dateInWeek: Int = 7
let maxNumber: Int = 5

// ※ Type Inference (타입 추론)
// 데이터 타입을 생략하면 컴파일러가 추론하여 자동적으로 지정, 비추천!
var job = "iOS Programmer"
print(type(of: job)) // > String

// 3. Data Types

// Integer
// * Int8 (1byte), Int16 (2byte), Int32 (4byte), Int64 (8byte)
// * 64 Architecture default : Int == Int64 (-2^63 ~ 2^63 - 1)
var integer: Int = -100
print(integer)
integer = 100
print(integer)

// Unsigned Integer
// * 64 Architecture default : UInt == UInt64 (0 ~ 2^64 - 1)
var unsignedInt: UInt = 100
print(type(of:unsignedInt))  // > UInt
// unsignedInt = -100  // > error

// Boolean
var boolean: Bool = true  // True도 가능
print(boolean)
boolean.toggle()  // true <-> false
print(boolean)

// Float, Double
// * 부동소수점을 사용하는 실수 타입
// * Float: 32 bit
// * Double: 64 bit
var floatValue: Float = 123456789.1
var doubleValue: Double = 123456789.1
print(floatValue, doubleValue)

// ※ Random Method
var randomInt: Int = Int.random(in: -100...100)
print(randomInt)

// Character
let alphabetA: Character = "A"
print(alphabetA)

let unicode: Character = "\u{1F601}"
print(unicode)

// String
var introduce: String = String()
introduce.append("My name is ")
introduce += "Dongyoung"
print(introduce)

// ※ String Interpolation (문자열 보간법)
var name: String = "Dongyoung"
var age: Int = 27
print("My name is \(name) and \(age) years old.")

// Any, AnyObject
// * Any: 스위프트의 모든 데이터 타입을 사용할 수 있다. 비추천!
// * AnyObject: 클래스의 인스턴스만 할당할 수 있다. 비추천!
var someVar: Any = "Hi"
print(someVar)
someVar = 10
print(someVar)
someVar = 10.1
print(someVar)

// nil
// * nil을 할당하여 Optional Var을 가치없는 상태로 설정
var serverResponseCode: Int? = 404
serverResponseCode = nil
print("value: \(serverResponseCode), type: \(type(of: serverResponseCode))")