// 1. ARC (Automatic Reference Counting)
// - ARC is a garbage collection system that automatically manages reference counts for objects.
// - ARC는 인스턴스가 언제 메모리에서 해제되어야 할지를 컴파일과 동시에 결정
// - 객체에 대한 참조 카운트를 관리하고 0이 되면 자동으로 메모리 해제

// 1-(1). 강한 참조
// - 참조의 기본은 강한참조이다.
class Person {
  let name: String
    
  init(name: String) {
    self.name = name
    print("\(name) is being initialized")
  }
  
  deinit {
    print("\(name) is being deinitialized")
  }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

// 강한 참조
reference1 = Person(name: "John")  // count : 1
reference2 = reference1  // count : 2
reference3 = reference1  // count : 3

reference3 = nil  // count : 2
reference2 = nil  // count : 1
reference1 = nil  // count : 0
// > John is being deinitialized

// - ARC의 문제는 두 개의 클래스 인스턴스가 서로를 참조하는 경우에 strong reference cycle이 발생할 수 있다는 것이다.
// - 서로를 강한 참조로 참조하게 되면, 레퍼런스 카운트가 0이 될 수 없게 되고 영원히 메모리에서 해제되지 않게 된다.
// - 즉 메모리 누수가 발생하게 된다!

// 1-(2). 약한 참조
// - 위의 문제를 해결하는 방법
// - 약한참조는 강한참조와 달리 자신이 참조하는 인스턴스의 참조 횟수를 증가시키지 않는다.
// - 또한, 상수에서 쓰일 수 없다.
// - 만약 자신이 참조하던 인스턴스가 메모리에서 해제된다면 nil이 할당될 수 있어야 하기 때문
// - `weak` 키워드 사용

class Person2 {
  let name: String
    
  init(name: String) {
    self.name = name
  }
    
  var room: Room?
    
  deinit {
    print("\(name) is being deinitialized")
  }
}

class Room {
  let number: String
    
  init(number: String) {
    self.number = number
  }
    
  weak var host: Person2?
    
  deinit {
    print("Room \(number) is being deinitialized")
  }
}

var john: Person2? = Person2(name: "John")
var suite: Room? = Room(number: "610")

john?.room = suite
suite?.host = john // weak

john = nil
// > Gaegul is being deinitialized

suite = nil
// > Room 610 is being deinitialized
 
// 1-(3). 미소유타입
// - 약한참조와 마찬가지로 미소유참조는 인스턴스의 참조 횟수를 증가시키지 않는다.
// - 즉, 자신이 참조하는 인스턴스가 메모리에서 해제되더라도 스스로 nil을 할당해주지 않는다는 뜻
// - 그래서, weak와 달리 항상 값이 있어야 하기 때문에 옵셔널이 아닌 상수로 선언
// - `unowned` 키워드 사용

class Customer {
  let name: String
  var card: CreditCard?
  
  init(name: String) {
    self.name = name
  }
  
  deinit {
    print("\(name) is being deinitialized")
  }
}

class CreditCard {
  let number: UInt
  unowned let customer: Customer
  
  init(number: UInt, customer: Customer) {
    self.number = number
    self.customer = customer
  }
  
  deinit {
    print("Card #\(number) is being deinitialized")
  }
}

var mike: Customer?

mike = Customer(name: "Mike")
mike!.card = CreditCard(number: 1234_5678_9012_3456, customer: mike!)


// 2. Error handling (오류 처리)
// - Swift에서 오류는 `Error` Protocol을 준수하는 타입의 값을 통해 표현됨
// - `Error` Protocol은 요구사항이 없는 빈 프로토콜이다.

// - 오류를 처리하기 위한 4가지 방법:
// 1. 함수에서 발생한 오류를 해당 함수를 호출한 코드에 알리는 방법
// 2. do-catch 구문을 이용하여 오류를 처리하는 방법
// 3. 옵셔널 값으로 오류를 처리하는 방법 (?)
// 4. 오류가 발생하지 않을 것이라고 확신하는 방법 (!)

// 2-(1). throw
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Biscuit": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispense(snack: String) {
        print("\(snack) 제공")
    }
    
    func vend(itemNamed name: String) throws {
        guard let item = self.inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= self.coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - self.coinsDeposited)
        }
        
        self.coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        self.inventory[name] = newItem
        
        self.dispense(snack:name)
    }
}

let favoriteSnacks = [
    "yagom": "Chips",
    "jinsung": "Biscuit",
    "heejin": "Chocolate"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

let machine: VendingMachine = VendingMachine()
machine.coinsDeposited = 30

var purchase: PurchasedSnack = try PurchasedSnack(name: "Biscuit", vendingMachine: machine)
// Biscuit 제공

print(purchase.name)    // Biscuit

for (person, favoriteSnack) in favoriteSnacks {
    print(person, favoriteSnack)
    try buyFavoriteSnack(person: person, vendingMachine: machine)
}
// yagom Chips
// Chips 제공
// jinsung Biscuit
// heejin Chocolate

// 오류 발생!!

// 2-(2). do-catch
// - 함수,메서드, 이니셜라이저 등에서 오류를 던져주면 오류 발생을 전달받은 코드 블록은 do-catch 구문을 사용하여 오류를 처리해주어야 한다.
// do 절 내부의 코드에서 오류를 던지면, catch 절에서 오류를 전달받아 적절이 처리
func tryingVend(itemNamed: String, vendingMachine: VendingMachine) {
  do {
    try vendingMachine.vend(itemNamed: itemNamed)
  } catch VendingMachineError.invalidSelection {
    print("유효하지 않은 선택")
  } catch VendingMachineError.outOfStock {
    print("품절")
  } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("자금부족 - 동전 \(coinsNeeded)개를 추가로 지급해주세요.")
  } catch {
    print("그 외 오류 발생 : ", error)
  }
}

// 2-(3). 옵셔널 값으로 오류처리
// - try? 를 사용하여 옵셔널 값으로 변환하여 오류를 처리할 수도 있음
// - try?를 실행하고 오류를 던지면 그 코드의 반환값은 nil 이 됨
func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
    if shouldThrowError {
    enum SomeError: Error {
      case justSomeError
    } 
    throw SomeError.justSomeError
  }
  return 100
}

let x: Optional = try? someThrowingFunction(shouldThrowError: true)
print(x)  // > nil

let y: Optional = try? someThrowingFunction(shouldThrowError: false)
print(y)  // > Optional(100)

// 2-(4). 다시 던지기
// - 자신의 매개변수로 전달받은 함수가 오류를 던진다는 것을 나타낼 수 있음
// - rethrows 가 가능하게 하려면 최소 하나 이상의 오류 발생 가능한 함수를 매개변수로 전달받아야 한다.
// - `rethrows` 키워드 사용
func someThrowingFunction() throws {
  enum SomeError: Error {
    case justSomeError
  }
    
  throw SomeError.justSomeError
}

// 다시던지기 함수
func someFunction(callback: () throws -> Void) rethrows {
  try callback()  // 다시던지기 함수는 오류를 다시 던질 뿐 따로 처리하지는 않습니다.
}

do {
  try someFunction(callback: someThrowingFunction)
} catch {
  print(error)
}

// 2-(5). 후처리 defer
// - 현재 코드 블록을 나가기 전에 꼭 실행해야 하는 코드를 작성 가능
// - 코드가 블록을 어떤 식으로 빠져나가든 간에 꼭 실행해야 하는 마무리 작업 실행 가능
func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
    
    defer {
        print("First")
    }
    
    if shouldThrowError {
        
        enum SomeError: Error {
            case justSomeError
        }
        
        throw SomeError.justSomeError
    }
    
    defer {
        print("Second")
    }
    
    defer {
        print("Third")
    }
    
    return 100
}

try? someThrowingFunction(shouldThrowError: true)
// First
// 오류를 던지기 직전까지 작성된 defer 구문까지만 실행됩니다.

try? someThrowingFunction(shouldThrowError: false)
// Third
// Second
// First

// 코드 28-13 복합적인 defer 구문의 실행 순서
func someFunction() {
  print("1")
    
  defer {
    print("2")
  }
    
  do {
    defer { print("3") }
    print("4")
  }
    
  defer { print("5") }
    
  print("6")
}

someFunction() // > 1 4 3 6 5 2


// 3. Memory Safety (메모리 안전)

// - 메모리 접근에는 세 가지 특성이 있다. 만약 메모리 접근이 두 군데 이상의 코드에서 동시에 발생하면 메모리 접근 충돌이 발생
// 1. 최소한 한곳에서 쓰기 접근이 가능
// 2. 같은 메모리 위치에 접근
// 3. 접근 타이밍이 겹친다.

// 3-(1). 순차적, 순간적 메모리 접근
func oneMore(than number: Int) -> Int {
  return number + 1
}

var myNumber: Int = 1
myNumber = oneMore(than: myNumber)
print(myNumber)

// - 장기적으로 메모리 접근이라는 접근 방식도 있다.
// - 장기적 메모리는 해당 메모리가 소멸되기 전에 다른 코드에서 메모리 접근을 할 수 있어 겹치지 않게 조심을 해야 한다.
// - 접근 타이밍이 겹치게 되는 대표적 상황은 함수나 메서드에서 inout을 사용한 입출력 매개변수를 사용하거나 구조체에서 mutating키워드를 사용하는 가변 매개변수를 사용하는 경우이다.
// - 코드에서 메모리 접근 충돌을 예측할 수 있는 경우 컴파일러에서 오류로 취급을 해버려 컴파일을 하지 않다.

// 3-(2). 입출력 매개변수(inout)에서의 메모리 접근 충돌
var step: Int = 1
var copyStep: Int = step

func increment(_ number: inout Int) {
  number += copyStep
}

increment(&step)
print(step)  // > 2

// - 메모리 안전 때문에 구조체의 프로퍼티 메모리에 접근하는 타이밍이 겹치는 것을 무조건 제한하는 것은 아닙니다.
// - 아래 세 조건을 충족하면 구조체의 프로퍼티 메모리에 동시에 접근하더라도 안전이 보장될 것입니다.
// 1. 연산 프로퍼티나 클래스 프로퍼티가 아닌 인스턴스의 저장 프로퍼티에만 접근
// 2. 전역 변수가 아닌 지역변수일 때
// 3. 클로저에 의해 획득되지 않았거나, 비탈출 클로저에 의해서만 획득되었을 때


// 4. Opaque Types (불명확 타입)
// - 반환 타입에 불명확 타입을 사용하면 반환할 타입의 정확한 타입을 알려주지 않은채로 반환하겠다는 것을 의미
// - `역제네릭 타입`이라 표헌도 가능
// - 함수의 반환 타입뿐만 아니라 프로퍼티나 서브스크립트의 타입에도 사용할 수 있다.
// - `some` 키워드를 사용