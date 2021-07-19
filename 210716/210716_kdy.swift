// Dongyoung Kwon @Chuncheonian (ehddud2468@gmail.com)

// 1. Closure (클로저)
// - 클로저는 일정 기능을 하는 코드를 하나의 블록으로 모아놓은 것
// - 함수는 클로저의 한 형태이다.
// - Closure Expression
// { (매개변수들) -> 반환타입 in
//   실행코드
// }

// Closure를 들어가기 앞서, swift에는 sorted 프로퍼티를 사용하여 정렬할 수 있다.
var numArr: [Int] = [3, 2, 1, 4, 5]
print(numArr.sorted(by: <))

// 이게 어떤 식으로 작동했는지 원리를 알아보자!

// 먼저, sorted(by: ) 메소드 정의를 보면 이런 식으로 되어있다.
// public func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) ->
//   [Element]

let strArr: [String] = ["a", "b", "c", "d", "e"]

func backwards(first: String, second: String) -> Bool {
  print("\(first) \(second) 비교중")

  return first > second
}

let reversed: [String] = strArr.sorted(by: backwards)
print(reversed)  // > ["e", "d", "c", "b", "a"]

// 전달인자를 함수를 통해 전달하였는데, 이를 closure 표현으로 대체하면 훨씬 간결하고 직관적으로 보입니다.
let reversed2: [String] = strArr.sorted(by: { (first: String, second: String) -> Bool in
  return first > second
})
print(reversed2)  // > ["e", "d", "c", "b", "a"]


// 2. Trailing Closure (후행 클로저)
// - 함수나 메소드의 마지막 전달인자로 위치하는 클로저는 함수나 메소드의 소괄호를 닫은 후 작성이 가능하다.

let reversed3: [String] = strArr.sorted() { (first: String, second: String) -> Bool in
  return first > second
} 
print(reversed3)

// 2-b. 단 하나의 클로저만 전달인자로 전달하는 경우에 메소드의 소괄호 생략 가능
let reversed4: [String] = strArr.sorted { (first: String, second: String) -> Bool in
  return first > second
} 
print(reversed4)

// - 다중 후행 클로저


// 3. Capturing Values (값 획득)
// * 클로저는 자신이 정의된 위치의 주변 문맥을 통해 상수나 변수를 Capture 할 수 있습니다.
func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
  var runningTotal = 0
  
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  return incrementer
}

let tmp: (() -> Int) = makeIncrementer(forIncrement: 2)
print(tmp(), tmp(), tmp())  // > 2 4 6


// 4. Escaping Closure (탈출 클로저)
typealias VoidVoidClosure = () -> Void

let firstClosure: VoidVoidClosure = { print("Closure A") }
let secondClosure: VoidVoidClosure = { print("Closure B") }

// first와 second는 함수가 끝나도 유지되어야 하기 때문에 @escaping 처리
func returnOneClosure(
  first: @escaping VoidVoidClosure,
  second: @escaping VoidVoidClosure,
  shouldReturnFirstClosure: Bool
) -> VoidVoidClosure {
  return shouldReturnFirstClosure ? first : second
}

// 함수에서 반환된 클로저가 함수 외부의 상수에 저장
let returnedClosure: VoidVoidClosure = 
  returnOneClosure(
    first: firstClosure,
    second: secondClosure,
    shouldReturnFirstClosure: true
  )

returnedClosure()

// - @escaping를 사용하여 탈출 클로저임을 명시한 경우, 해당 타입의 프로퍼티나 메서드, 서브스크립트 등에 접근하려면 self 사용해야 함
// - 비탈출 클로저 내부에서 self는 선택 사항


// 5. Optional Chaining (옵셔널 체이닝)
// - 옵셔널을 중첩하여, 하나라도 값이 존재하지 않는다면, nil을 반환
// - 옵셔널 체이닝의 결과값은 Optional
class Room {
  var num : Int
  
  init(num : Int) {
    self.num = num
  }
}

class Building {
  var name: String
  var room: Room?

  init(name : String) {
    self.name = name
  }
}

struct Address {
  var province : String
  var city : String
  var street : String
  var building : Building?
  var detailAddress : String?
}

class Person {
  var name : String
  var address : Address?

  init(name : String) {
    self.name = name
  }
}

let chuncheonian: Person = Person(name: "chuncheonian")

let optionalChaining: Int? = chuncheonian.address?.building?.room?.num
// let optionalUnwraping: Int = chuncheonian.address!.building!.room!.num  >> Error!
print(optionalChaining)  // > nil

// - Optional Chaining + Optional Binding
if let roomNumber: Int = chuncheonian.address?.building?.room?.num {
  print(roomNumber)
} else {
  print("Can't find room number")  // > Can't find room number
}

// 6. Early Exit (빠른 종료) - guard
// - guard에는 항상 else가 있어야 한다.
// - else 내부에는 return, break, continue, throw, fatalError() 같은 제어문 전환 명령키워드가 포함해야 함

// for i in 0...3 {
//   if i == 2 {
//     print(i)
//   } else {
//     continue
//   }
// }

// 위의 if-else 문을 guard-else 문으로 변경
for i in 0...3 {
  guard i == 2 else {
    continue
  }
  print(i)
}

// 7. Map, Filter, Reduce
// - Map, Filter, Reduce은 고차함수의 한 종류들
// - 고차함수란, 다른 함수를 전달인자로 받거나 함수실행의 결과를 함수로 반환하는 함수

// 7-a. Map
// - Map은 자신을 호출할 때 매개변수로 전달된 함수를 실행하여 그 결과를 다시 반환해주는 함수
// - 즉, 기존 데이터를 변형할 때 사용
let arr: [Int] = [0, 1, 2, 3, 4]
print(arr.map { $0 + 2 })  // > [2, 3, 4, 5, 6]

// 7-b. Filter
// - Filter은 컨테이너 내부의 값을 걸러서 추출하는 함수
// - 즉, 기존 데이터를 변형이 아닌, 특정 조건에 맞게 걸러낼 때 사용
print(arr.filter { $0 % 2 == 1 })  // > [1, 3]

// - Map + Filter
print(arr.map{ $0 + 3 }.filter { $0 % 2 == 1 })  // > [3, 5, 7]

// 7-c. Reduce
// - Reduce는 컨테이너 내부의 콘텐츠를 하나로 합하는 기능을 실행하는 고차함수
let sum = arr.reduce(0, { (first: Int, second: Int) -> Int in
  return first + second
})
print(sum)  // > 10


// 8. Monad (모나드)
// - 정리 개어렵 😂