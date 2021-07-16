let wods : [String] = ["frontsquat","burpee","clean","snatch"]
let _wods = wods.sorted()

print("sorted - 오름차순 : \(_wods)")

//reversed
func backwards(first: String, second: String) -> Bool {
    print("\(first) \(second) 비교")
    return first > second
}

let rwods = wods.sorted(by: backwards)
print(rwods)

// MARK: closure 사용
let cwods = wods.sorted(by: {(first: String, second: String) -> Bool in
                              return first > second
})
print(cwods)

// MARK: 후행 클로저 (Trailing Closure)
/*
 - sorted() 처럼 () 를 해주면 후행 클로저 사용 가능
 */
let twods = wods.sorted() { (first: String, second: String) -> Bool in
    return first > second
}


// 하나의 클로저만 파라미터로 전달하는 경우 () 생략가능
let _twods = wods.sorted { (first:String, second:String) -> Bool in
    return first>second
}

print("twods : \(twods) \n _towods : \(_twods)")

// MARK: 타입 유추 가능
let pwods = wods.sorted { first, second in
    return first>second
}
print("매서드의 파라미터 클로저는 타입 유추 가능 \(pwods)")

// MARK: 단축도 가능
let dwods = wods.sorted {
    return $0 > $1
}
print("단축도 가능 \(dwods)")

// MARK: 암시적 반환 ; Return 생략가능
/*
 조건 1 : 반환값을 값는 클로저
 조건 2 : 클로저 내 실행문 단 한 줄
 */
let irwods = wods.sorted { $0 > $1 }
print("return도 생략 가능 \(irwods)")

// MARK: 연산자 함수
let computed_wods = wods.sorted(by: >)
    print("연산자 함수 : \(computed_wods)")

// MARK: Closure Capture (획득) 그리고 클로저 참조타입 코드
func makeIncrmenter(forIcrement amout: Int) -> (() -> Int) {
    // 반환 타임 : () -> Int : == 함수 객체를 반환
    var runningTotal = 0
    func incrementer() -> Int {
        //incrementer 함수는 각각 자신만의 runningTotal 변수 갖고 카운트
        //각각 자신만의 runningTotal의 참조를 미리 획득했기 때문
        runningTotal += amout
        return runningTotal
    }
    return incrementer
}

let incrementByTwo : (()->Int) = makeIncrmenter(forIcrement: 2)
let first : Int = incrementByTwo()
let second : Int = incrementByTwo()
let third : Int = incrementByTwo()
print("first : \(first) second : \(second) third: \(third)")
let refincrementByTwo : (()->Int) = incrementByTwo
let fourth : Int = refincrementByTwo()
print("closure는 referene type 따라서 동일 클로저 동작 fourth : \(fourth) 로 늘어남")


// MARK: 탈출 클로저 (escape)
/*
 - 탈출 : 파라미터로 전달된 클로저가 함수 종료 후에 호출될때 클로저가 함수를 탈출한다고 함.
 - 클로저를 파라미터로 갖는 함수 선언시, 파라미터 이름의 콜론(:) 뒤에 @escaping 붙여줌
 */

typealias VoidVoidClosure = () -> Void
let firstClosure : VoidVoidClosure = {
    print("closure A")
}
let secondClosure : VoidVoidClosure = {
    print("closure B")
}

func returnOneClosure(first : @escaping VoidVoidClosure, second : @escaping VoidVoidClosure, shoudReturnFirstClosure : Bool) -> VoidVoidClosure {
    //파라미터로 받은 클로저를 다시 반환 => 탈출 클로저
    return shoudReturnFirstClosure ? first : second
}

// 반환값 저장 상수
let returnedClosure : VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shoudReturnFirstClosure: true)
returnedClosure() // closure A

// MARK: 클래스의 인스턴스 매서드에 사용되는 클로저들
func withNoEscapeClosure(closure : VoidVoidClosure) {
    closure()
}

func withEscapeClosure(completionHandler : @escaping VoidVoidClosure) -> VoidVoidClosure {
    return completionHandler
}

class SomeClass {
    var x : Int = 10
    
    //탈출 엑스
    func noEscape() {
        withNoEscapeClosure {
            x=200
        }
    }
    
    func yesEscape() -> VoidVoidClosure {
        return withEscapeClosure {
            self.x = 100
        }
    }
}

let instance : SomeClass = SomeClass()
instance.noEscape()
print(instance.x)

let returnedClosure2 : VoidVoidClosure = instance.yesEscape()
returnedClosure2()
print(instance.x)



// CHAP 14 : 옵셔널 체이닝과 빠른 종료
class Room {
    var roomNum : Int
    // 저장 프로퍼티인 roomNum 은 이니셜라이저 필요
    init(roomNum : Int) {
        self.roomNum = roomNum
    }
}

class Building {
    var name: String
    var room: Room?
    
    init(name : String){
        self.name = name
    }
}

struct Address {
    var province : String //필수
    var city : String //필수
    var street : String //필수
    var buinding : Building?
    var detailAddress : String?
}

class Person {
    var name : String
    var address : Address?
    
    init(name : String) {
        self.name = name
    }
}

let miori : Person = Person(name: "miori")
let mioriRN : Int? = miori.address?.buinding?.room?.roomNum //nil

var roomNumber : Int? = nil
if let mioriAddress : Address = miori.address {
    if let mioriBuilding : Building = mioriAddress.buinding {
        if let mioriRoom : Room = mioriBuilding.room {
            roomNumber = mioriRoom.roomNum
        }
    }
}

if let number : Int = roomNumber{
    print(number)
} else {
    print("nil 값이었지롱")
}

// 옵셔널 체이닝 사용
let miori2 : Person = Person(name: "miori2")

if let roomNum2 : Int = miori2.address?.buinding?.room?.roomNum {
    // 옵셔널 체이닝의 결과값이 옵셔널 이라서
    // 옵셔널 바인딩과 결합 가능
    print(roomNum2)
} else {
    print("nil 이었지")
}

// 옵셔널 체이닝으로 할당도 가능
// 대신 큰거(?) 부터 차례대로
miori2.address = Address(province: "경기", city: "하남", street: "세미로", buinding: nil, detailAddress: nil)
miori2.address?.buinding = Building(name: "푸르지오")
miori2.address?.buinding?.room = Room(roomNum: 1)
print(miori2.address?.buinding?.room?.roomNum) //Optional(1)

// MARK: 빠른 종료 : guard 구문
/*
 - 예외사항만 처리하고 싶다면 guard 사용
 - if else 보다 훨씬 간결
 */


// MARK: 맵,필터, 리듀스
let mapNums : [Int] = [0,1,2,3,4]
var doubleNums : [Int] = [Int]()

for number in mapNums {
    doubleNums.append(number*2)
}

print("for 문 사용 : \(doubleNums)")

// map 을 쓰고, 후행 클로저로 코드 가독성 증가
doubleNums = mapNums.map {$0 * 2}
print("map 클로저 사용 :\(doubleNums)")

let oddNums = mapNums.filter {$0 % 2 == 1}
print("filter 클로저 : \(oddNums)")

// map + filter 도 가능
let evenNums = mapNums.map{ $0 + 3 }.filter{ $0 % 2 == 0 }
// [3,4,5,6,7]
// [4,6]
print("map + filter : \(evenNums)")


// MARK: 모나드
/*
 참고 - https://zeddios.tistory.com/449
 - context =  상자 = 어떤 위치에 값이 존재할수 있는 맥락 = like optional
 */

var myValue : Int? = 2
print(myValue.map { $0 + 3 }) //Optinal(5)
/*
 - myValue 는 Int? 타입
 - Int? 랑 Int 는 달라
 - maValue  컨텍스트에서 꺼내주고 다시 컨텍스트에 넣어서 반환해주는 얘가 map
 - 말인즉슨, optional 에 map 적용
 - optional 은 map 을 적용할수 있는 컨테이너 타입 = 함수객체
 */


// MARK: Optional 은 함수객체 이면서 모나드
func doubledEven(_ num : Int) -> Int? {
    if num.isMultiple(of: 2) {
        return num * 2
    }
    return nil
}

print(Optional(3).flatMap(doubledEven)) //nil
print(Optional(4).flatMap(doubledEven)) //Optional(8)
