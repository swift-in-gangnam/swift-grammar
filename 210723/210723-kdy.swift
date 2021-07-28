// 1. Protocol (프로토콜)
// - Protocol이란 특정 역할을 하기 위한 메서드 , 프로퍼티, 기타 요구사항 등의 청사진을 정의
// - 즉, 정의를 하고 제시를 할 뿐, 기능을 구현하지 않는다.
// - 만약, 클래스가 다른 클래스를 상속받는다면 상속받을 클래스 이름 다음에 프로토콜 나열한다.

// 1-(1). Property
// - 프로토콜은 항상 var 키워드를 사용한 변수 프로퍼티로 정의합니다.
protocol SomeProtocal {
  var settableProperty: String { get set }
  var notNeedToBeSettableProperty: String { get }
}

// Type Property 일 땐 `static` 사용하여 정의
protocol AnotherProtocol {
  static var someTypeProperty: Int { get set }
  static var anotherTypeProperty: Int { get }
}

// - class의 Type Property일 때는 `class` `static`을 구분하지 않고 모두 `static` 사용

// 1-(2). Method
// - Parameter 기본값을 지정할 수 없다.
protocol Receiveable {
  func received(data: Any, from: Sendable)
}

protocol Sendable {
  var from: Sendable { get }
  var to: Receiveable? { get }
    
  func send(data: Any)
    
  static func isSendableInstance(_ instance: Any) -> Bool
}

class Message: Sendable, Receiveable {
  var from: Sendable {
    return self
  }
    
  var to: Receiveable?
  
  func send(data: Any) {
    guard let receiver: Receiveable = self.to else {
      print("Message has no receiver")
      return
    }
    receiver.received(data: data, from: self.from)
  }
  
  static func isSendableInstance(_ instance: Any) -> Bool {
    if let sendableInstance: Sendable = instance as? Sendable {
      return sendableInstance.to != nil
    }
    return false
  }
  
  func received(data: Any, from: Sendable) {
    print("Message received \(data) from \(from)")
  }
}

class Mail: Sendable, Receiveable {
  var from: Sendable {
    return self
  }
  
  var to: Receiveable?
  
  func send(data: Any) {
    guard let receiver: Receiveable = self.to else {
      print("Mail has no receiver")
      return
    }
    receiver.received(data: data, from: self.from)
  }
  
  static func isSendableInstance(_ instance: Any) -> Bool {
    if let sendableInstance: Sendable = instance as? Sendable {
      return sendableInstance.to != nil
    }
    return false
  }
  
  func received(data: Any, from: Sendable) {
    print("Mail received \(data) from \(from)")
  } 
}

let myPhoneMessage: Message = Message()
let yourPhoneMessage: Message = Message()

myPhoneMessage.send(data: "Hello")

myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello")

let myMail: Mail = Mail()
let yourMail: Mail = Mail()

myMail.send(data: "Hi")

myMail.to = yourMail
myMail.send(data: "Hi")

myMail.to = myPhoneMessage
myMail.send(data: "Bye")

Message.isSendableInstance("Hello")
Message.isSendableInstance(myPhoneMessage)
Message.isSendableInstance(yourPhoneMessage)

Mail.isSendableInstance(myPhoneMessage)
Mail.isSendableInstance(myMail)

// 1-(3). 가변 Method
// - 프로토콜이 어떤 타입이든 간에, 인스턴스 내부의 값을 변경해야하는 Method를 요구하려면 `mutating` 사용
protocol Resettable {
  mutating func reset()
}

// 1-(4). Initializer
// - Protocol에서 Initializer를 정의할 수 있다.
protocol Named {
  var name: String { get }
    
  init(name: String)  // Init 정의
}

struct Pet: Named {
  var name: String
    
  init(name: String) {
    self.name = name
  }
}

class Person: Named {
  var name: String

  required init(name: String) {  // Init을 요구하는 Protocol을 채택하면 `require` 필수
    self.name = name
  }
}

final class FinalPerson: Named {
  var name: String

  init(name: String) {  // 다만, final class이면 `required` 불필요
    self.name = name
  }
}

// - 실패 가능한 Initializer일 때는 구현할 때 아무렇게나 구현 가능


// 2. Extension (익스텐션)
// - 구조체, 클래스, 열거형, 프로토콜 타입에 새로운 기능을 추가할 수 있다.
// - Extension은 타입에 새로운 기능을 추가할 수는 있지만, 기존에 존재하는 기능을 재정의할 수는 없습니다.
// - `extension` 키워드 사용

// 2-(1). Computed Property
// - Extension으로 Computed Property를 추가할 수 있지만, Stored Property, Property 감시자는 추가할 수 없다.
extension Int {
  var isEven: Bool {
    return self % 2 == 0
  }
    
  var isOdd: Bool {
    return self % 2 == 1
  }
}

print(1.isEven) // > false
print(1.isOdd)  // > true

// 2-(2). Method
extension Int {
  func multiply(by n: Int) -> Int {
    return self * n
  }
    
  mutating func multiplySelf(by n: Int) {
    self = self.multiply(by: n)
  }
    
  static func isIntTypeInstance(_ instance: Any) -> Bool {
    return instance is Int
  }
}

print(2.multiply(by: 3)) // > 6

var number: Int = 2
number.multiplySelf(by: 3)
print(number) // > 6

print(Int.isIntTypeInstance(number)) // > true

// 2-(3). Initializer
// - 인스턴스를 초기화 할 때 다양한 데이터를 전달 받을 수 있도록 이니셜라이저를 확장할 수 있다.
// - 다만. 클래스는 편의 이니셜라이저만 추가 가능
extension String {
  init(intTypeNumber: Int) {
    self = "\(intTypeNumber)"
  }
    
  init(doubleTypeNumber: Double) {
    self = "\(doubleTypeNumber)"
  }
}

let stringFromInt = String(intTypeNumber: 100)  // > "100"
let stringFromDouble = String(doubleTypeNumber: 100.0)  // > "100.0"

class Person2 {
  var name: String
    
  init(name: String) {
    self.name = name
  }
}

extension Person2 {
  convenience init() {
    self.init(name: "Unknown")
  }
}

let someOne = Person2()
print(someOne.name)  // > Unknown

// 2-(4). Subscript
extension String {
  subscript(appendValue: String) -> String {
    return self + appendValue
  }
    
  subscript(repeatCount: UInt) -> String  {
    var str: String = ""
        
    for _ in 0..<repeatCount {
      str += self
    }
    return str
  }
}

print("abc"["def"]) // > abcdef
print("abc"[3])     // > abcabcabc


// 3. Generic (제네릭)
// 제네릭 코드는 유연하게 작성할 수 있고, 재사용가능한 함수와 타입이 어떤 타입과 작업할 수 있도록 요구사항을 정의한다. 중복을 피하고 의도를 명확하게 표현하고, 추상적인 방법으로 코드를 작성할 수 있다.

// 3-(1). Generic Function
func swap<T>(_ a: inout T, _ b: inout T) {
  let tmp: T = a
  a = b
  b = tmp
}

var someInt: Int = 1
var anotherInt = 2
swap(&someInt, &anotherInt)
print(someInt, anotherInt)

var someString: String = "A"
var anotherString: String = "B"
swap(&someString, &anotherString)  // > 2 1
print(someString, anotherString)   // > B A

// 3-(2). Generic Type
// - 제네릭 타입은 제네릭 함수를 사용하여 제네릭 타입을 정의할 수 있다.
struct Stack<Element> {
  var items = [Element]()
    
  mutating func push(_ item: Element) {
    items.append(item)
  }
    
  mutating func pop() -> Element {
    return items.removeLast()
  }
}

var stack: Stack<Int> = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.pop()   // > 3
print(stack)  // > 1, 2

// 3-(3). Type Constraint (타입 제약)
// - 특정 타입 또는 특정 프로토콜을 준수하는 타입만 사용할 수 있도록 제약 가능
// - 타입 제약은 Class Tyoe 또는 Protocol로만 제약할 수 있다.
// - 여러 제약을 할려면 콤마로 구분이 아닌 where절 사용
func substract<T: BinaryInteger>(_ a: T, _ b: T) -> T {
  return a - b
}

print(substract(3, 2)) // > 1
// print(substract("3", "2")) // > error

// 3-(4). Protocol' Associate Type
// - 타입 매개변수의 그 역할을 프로토콜에서 수행할 수 있도록 만들어진 기능
protocol Container {
  associatedtype ItemType
    
  var count: Int { get }
    
  mutating func append(_ item: ItemType)
    
  subscript(i: Int) -> ItemType { get }
}

// 3-(5). Generic Subscript
// - 서브스크립트도 제네릭을  활용하여 타입에 큰 제한없이 유연하게 구현할 수 있음


// 4. Protocol Oriented Programming (프로토콜 지향 프로그래밍)
// - Protocol을 통해 정의를 하며, Extension을 통해 구현하는 방식이다.