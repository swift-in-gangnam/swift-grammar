// 1. Tuple
// * 다양한 값들의 묶음
var person: (String, Int, Double) = ("Dongyoung", 27, 172.5)
print("Name: \(person.0), Age: \(person.1), Height: \(person.2)")  // 인덱스를 통해 추출

// * Tuple의 elem에 이름 삽입 가능
var person2: (name: String, age: Int, height: Double) = ("Dongyoung", 27, 172.5)
print("Name: \(person2.name), Age: \(person2.age), Height: \(person2.height)")

// * typealias + Tuple
typealias PersonTuple = (name: String, age: Int, height: Double)

let dongyoung: PersonTuple = ("Dongyoung", 27, 172.5)
print("Name: \(dongyoung.name), Age: \(dongyoung.age), Height: \(dongyoung.height)")

// 2. Collection Types
// * Collection Type에는 Array, Dictionary, Set가 있다.

// a. Array
// * Swift에선 기본이 동적배열이다.
var names: Array<String> = ["KDY", "KYS", "SJW"]
// var names: [String] = ["KDY", "KYS", "SJW"]  // 같은 표현

print(names[2])  // > SJW
names[2] = "SHM"
print(names[2])  // > SHM

names.append("KMS")
print(names.last)  // > KMS

// b. Dictionary
// * 원소들이 순서 없이 키와 값의 쌍으로 구성되는 컬렉션 타입
var emptyDict: Dictionary<String, Int> = Dictionary<String, Int>()
// var emptyDict: [String: Int] = [String: Int]()  // > 같은 표현
// var emptyDict: [String: Int] = [:]  // > 같은 표현

var dict: [String: Int] = ["a": 10, "b": 20, "c": 30]
// print("\(dict["a"])") // > false
print(dict.isEmpty) // > false
print(dict.count)   // > 3

// c. Set
// * 같은 타입의 데이터를 순서, 중복 없이 하나의 묶음으로 저장하는 컬렉션 타입
var emptySet: Set<Int> = Set<Int>()
// var emptySet: Set<Int> = []  // 같은 표현

print(emptySet.isEmpty) // > true
emptySet.insert(5)
print(emptySet.count) // > 1
print(emptySet.remove(5))  // > Optional(5)

// 3. enum (열거형)
// * 연관된 항목을 묶어서 표현할 수 있는 타입이며, 추가/수정이 불가
enum DateInWeek {
  case Mon
  case Tue
  case Wed
  case Thu
  case Fri
  case Sat
  case Sun
}
// 같은 표현
// enum DateInWeek {
//   case Mon, Tue, Wed, Thu, Fri, Sat, Sun
// }

var date: DateInWeek = DateInWeek.Mon
print(date)  // > Mon

// 4. 조건문 (if, switch)
// * 조건문의 조건의 값은 Bool 타입!

// a. switch
let intValue: Int = 5

switch intValue {
  case 0:
    print("Value == zero")
  case 1...10:
    print("Value == 1~10")
    fallthrough  // fallthrough: case 연속 실행시키는 keyword
  case Int.min..<0, 101..<Int.max:
    print("hi")
  default:
    print("default")
}

// 5. 반복문 (for, while)

// a. for
for i in 1...5 {
  print(i)
}

// b. while
var nameList: [String] = ["a", "b", "c", "d", "e"]

while nameList.isEmpty ==  false {
  print("Good Bye \(nameList.removeFirst())")
}

// 6. Function
func hello(_ name: String) -> String {
  return "Hello \(name)"  // > 내부의 코드가 한줄이면 return 생략 가능
}

print(hello("KDY"))

// 매개변수 기본값
func sayHello(myName: String="KDY", name: String) -> String {
    return "hello \(name) I'm \(myName)"
}

// 가변 매개변수
func sayHello2(myName: String, names: String...) -> Void {
    for name in names{
        print("hello \(name) I'm \(myName)")
    }
}

// 데이터 타입으로서의 함수
typealias CalculateInt = (Int, Int) -> Int
func addInts(_ a: Int, _ b: Int) -> Int{
  return a + b
}
func mulInts(_ a: Int, _ b: Int) -> Int{
  return a * b
}
var mathFunction: CalculateInt = addInt 

func printMathResult(_ mathFunction: CalculateInt, _ a: Int, _ b: Int) {
  print(mathFunction(a,b))
}

func chooseMathResult(_ toAdd: Bool) -> CalcaulateInt {
  return toAdd ? addInts : mulInts 
}

// 7. Optional (옵셔널)
// * 옵셔널은 변수 또는 상수의 값이 nil일 수도 있다는 뜻
// * 안전성을 문법으로 담보하는 기능

var myName : String? = "KDY"
myName = nil  // 옵셔널 변수/상수가 아니면 nil 값 할당 불가능. 즉 옵셔널 (? 추가) 이어야지만 nil 값 할당 가능
print(myName) 

// 옵셔널 추출
// * 가장 간단한 방식이지만, 가장 위험한 방식
var myNameVar: String? = "KDY"
var nameVar: String = myName! // 옵셔널이 아닌 변수에는 옵셔널 값이 들어갈 수 없음. 추출해서 할당해야 함
myNameVar = nil
// name = myName!  // > error

if myNameVar != nil {
	print("name is \(myNameVar!)")
} else {
	print("name == nil")
}

// 임시적 추출 옵셔널
// 옵셔널 바인딩으로 매번 값을 추출하기 귀찮거나 오류가 발생하지 않을 것 같다는 확신이 들 때 사용
// 원래 옵셔널 표시 시 ? 를 사용, but 여기서는 ! 사용
var myName: String! = "KDY"
print(myName)
myName = nil

if let name = myName{
	print("\(name)")
}else{
	print("nil")
}