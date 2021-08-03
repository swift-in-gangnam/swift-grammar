# Part5. 스위프트 고급

# 1. 타입 중첩

- 중첩 타입 : 타입 내부에 새로운 타입을 선언

[중첩 데이터 타입 구현] 

```swift
class person {
    enum job { //중첩 데이터 타입 
        case jobless, programmer, student 
}
var job : job = .jobless 
}

class Student: person { 
    enum School {  //중첩 데이터 타입 
        case elementary, middle, high
    }
    var school : School 
    init(school: School) {
        self.school = school 
        super.init() 
        self.job = .student
    }
}

let personjob: person.job = .jobless 
let studentjob: Student.job = .student 

let student: Student = Student(school: .middle)
print(student.job) //student
print(student.school) // middle
```

# 2. 패턴

- 패턴 : 단독 또는 복합 값의 구조를 나타내는 것
- 패턴 매칭 : 코드에서 어떤 패턴의 형태를 찾아내는 행위
- Switch, if, guard, for 등 키워드의 패턴
- 대부분의 패턴은 switch 구문이 가장 강력한 힘을 가진다

**[ 스위프트 패턴 종류 ]** 

1. 값을 해체(추출)하거나 무시하는 패턴 
- 와일드카드 패턴, 식별자 패턴, 값 바인딩 패턴, 튜플 패턴 
2. 패턴 매칭을 위한 패턴 
- 열거형 케이스 패턴, 옵셔널 패턴, 표현 패턴, 타입캐스팅 패턴 

## 2.1 와일드카드 패턴

- _  와일드카드 식별자 사용
- 와일드카드 식별자가 위치한 곳의 값은 무시

```swift
let string : String = "abc"

switch string { 
// abc 
case _ : print(string)
}

let optionalString: String? = "abc"
switch optionalString { 
case "abc"? : print(optionalString)
case _? : print("has value, but not abc")
case nil: print("nil") 
}//Optional("abc")

let yagom = (" ", 12, "male") 

switch yagom {
case ("yagom", _, _): print("hello")
    case (_,_,_): print("who cares~")
} //who cares~

for _ in 0..<2 {
    print("hello")
}
// hello // hello
```

## 2.2 식별자 패턴

- 변수 또는 상수의 이름에 알맞는 값을 어떤 값과 매치시키는 패턴

```swift
let somevalue : Int = 42 
```

## 2.3  값 바인딩 패턴

- 변수/상수의 이름에 매치된 값을 바인딩
- 예를 들어 튜플의 요소를 해체하여 그에 대응하는 식별자 패턴에 각각의 요소 값을 바인딩

```swift
let yagom = ("yagom", 22, "male")

switch yagom {
// name, age, gender을 yagom의 각각의 요소와 바인딩한다 
case let(name,age,gender) : print("name: \(name)", "age: \(age)", "gender: \(gender)")
}

switch yagom { 
// 값 바인딩 패턴은 와일드카드 패턴과 결합하여 유용하게 사용한다 
case (let name, _ , let gender) : print("name: \(name)", "gender: \(gender)")
}
```

## 2.4 튜플 패턴

- 소괄호 내 쉼표로 분리하는 리스트
- 그에 상응하는 튜플 타입과 값을 매치한다

```swift
let(a): Int = 2
print(a) 

let (x,y): (Int,Int) = (1,2)
print(x)

let name: String = "bossbaby"
let age: Int = 1 
let gender: String? = "male"

switch(name,age,gender) {
case("bosbaby", _, _) : print("hello baby")
    case(_,_,"male"): print("who are you man?")
        default: print("i don't know you are")
} 
```

## 2.4. 열거형 케이스 패턴

- 값을 열거형 타입의 case와 매치시킨다
- Switch 구문의 case 레이블과 if,while,guard,for-in 구문의 case 조건에서 볼 수 있다.

```swift
let somevalue : Int = 69 

if case 0...100 = somevalue {
    print("0 <= \(somevalue) <= 100")
}  //0 <= 69 <= 100

let anothervalue: String = "abc"

if case "abc" = anothervalue {
    print(anothervalue)
}//abc

enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(witchsauce: Bool)
    case rice 
}

var dishes: [MainDish] = []

var dinner: MainDish = .pasta(taste: "cream") 
dishes.append(dinner)

if case .pasta(let taste) = dinner {
    print("\(taste)pasta")
}//creampasta
```

? 왜 let taste 가 들어가는지 이해안됨 

## 2.5 옵셔널 패턴

- 식별자 패턴 뒤에 물음표를 넣어 표기하며 열거형 케이스 패턴과 동일한 위치에 자리한다
- 옵셔널 값을 저장하는 배열인 for-in 구문을 통한 순환에서 nil이 아닌 값을 찾는데 유용하게 쓰임

```swift
var optionalValue: Int? = 100

if case .some(let value) = optionalValue {
    print(value)
} //100

func isithasvalue(_ optinalValue: Int?) {
    guard case .some(let value) = optinalValue else { 
        print("none") 
        return 
    }

print(value)
}

isithasvalue(optionalValue) //100

while case .some(let value) = optionalValue {
    print(value)
    optionalValue = nil 
}

print(optionalValue) //nil
```

? Some 키워드 

## 2.6 타입캐스팅 패턴

- Is 패턴 
- switch case 레이블에서만 사용 가능 
- is (type_name) 
- 값의 타입이 is 우측에 쓰여진 타입 혹은 그 타입의 자식클래스 타입이면 값과 매치시킨다 
- 반환된 결괏값은 신경쓰지 않는다

- As 패턴 
- somePattern as (TYPE_NAME) 
- 값의 타입이 as 우측에 쓰여진 타입 혹은 그 타입의 자식클래스 타입이면 값과 매치시킨다

```swift
let someValue: Any = 100

switch someValue {
case is String: print("it's string")
    case let value as Int: print(value + 1)
        default: print("int x , string x ")
} // 101
```

## 2.7 표현 패턴

- 표현식의 값을 평가한 결과를 이용
- Switch 구문의 case 레이블에서만 사용
- ~= 연산자의 연산결과가 true를 반환하면 매치시킨다
- 표현패턴은 매우 유용한 패턴 중 하나
- ~= 연산자를 중복정의 혹은 새로 정의하거나 자신이 만든 타입에 
~= 연산자를 구현해준다면 원하는 패턴으로 완성시킬 수 있다.

```swift
switch 3{
case 0...5: print("0~5")
    default: print("x<0,x>5")
} //0~5

var point: (Int,Int) = (1,2)

switch point {
case (0,0): print("zero")
    case(-2...2, -2...2): print("\(point.0),\(point.1) close ")
        default: print("point (\(point.0),\(point.1))")
}//1,2 close 

func ~= (pattern: String, value: Int) -> Bool {
    return pattern == "\(value)"
}

point = (0,0)

switch point {
case (0,0): print("zero")
default: print("point (\(point.0),\(point.1))")
} //zero
```

# 3. Where절

- 패턴과 결합하여 조건 추가
- 타입에 대한 제약 추가

→ 특정 패턴에 bool 타입 조건을 지정하거나 어떤 타입의 특정 프로토콜 준수 조건을 추가하는 등 기능 

[ 값 바인딩, 와일드카드 패턴과 where절 활용] 

```swift
let tuple: [(Int),(int)] = [(1,2),(1,-4)]

for tuple in tuples {
    switch tuple {
    case let (x,y) where x == y: print("x==y")
        case let (x,y) where x == -y: print("x== -y")
            default: print("ddd")
    }
}
```

[옵셔널 패턴과 where절 활용] 

```swift
let array: [Int?] = [nil,1,3,nil,5]

for case let number? in array where number>2 {
    print("found a \(number)")
}
//found a 3
//found a 5
```

- 프로토콜 익스텐션에 where절을 사용하면 이 익스텐션이 특정 프로토콜을 준수하는 
타입에만 적용될 수 있도록 제약을 줄 수 있다.

```swift
protocol Selfprintable {
    func printSelf()
}

struct person: Selfprintable { }

extension Int: Selfprintable { } 
extension UInt: Selfprintable { } 

extension Selfprintable where Self: FixedWidthInteger, Self: SighnedInteger {
    func printSelf() {
        print("dddddd \(type(of:self))")
    }
}
```

- 타입 매개변수와 연관 타입의 제약을 추가하는데 where절을 사용한다
- 제네릭 함수의 반환 타입 뒤에 where절을 포함하면 요구사항 추가

```swift
// 타입 매개변수 T,U가 CustomStringConvertible 프로토콜을 준수하는 타입 
func prints<T,U>(first: T, second: U) where T: CustomStringConvertible, U: CustomStringConvertible {
    print(first)
    print(second)
}

func prints<T: CustomStringConvertible, U: CustomStringConvertible> (first: T, second: U) {
    print(first)
    print(second)
}
```

- 연관타입이 특정 프로토콜을 준수하는 경우만 제네릭 타입에 프로토콜을 채택하도록 제네릭 타입의 연관 타입에 제약을 줄 수 있다.

```swift
protocol Talkable { }
protocol CallToAll {
    func calltoAll()
}

struct Person: Talkable { }
struct Animal { }

extension Array: CallToAll where Element: Talkable {
    func calltoAll() { }
}
```

- Anilmal 타입이 talkable 프로토콜을 준수하지 않는다.
- Element 타입이 talkable 프로토콜을 준수하는 경우만 array 타입에 calltoall 프로토콜을 채택했으므로, 
Animal 타입을 요소로 갖는 array 타입은 calltoall 프로토콜을 채택하지 않는다.