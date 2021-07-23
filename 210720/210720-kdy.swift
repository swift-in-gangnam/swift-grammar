// 1. Sub-script (서브스크립트)
// - Class, Struct, Enum에 정의할 수 있으며,
// - 별도의 getter, setter 등의 메소드를 구현하지 않아도 인덱스를 통해 값을 접근할 수 있게 해주는 기능
// - `subscrip` 키워드를 통해 객체에 서브스크립트를 정의할 수 있다.
// - 통상 하나의 매개변수를 갖는 것이 보통이지만, 여러 개의 매개변수 및 기본값을 가질 수 있다.
// - 하지만, in-out 매개변수는 가질 수 없다.

// 1-(1). 객체에 서브스크립트를 정의하기
struct Student {
  var name: String
  var number: Int
}

class School {
  var number: Int = 0
  var students: [Student] = [Student]()

  func addStudent(name: String) {
    let student: Student = Student(name: name, number: self.number)
    self.students.append(student)
    self.number += 1
  }

  func addStudents(names: String...) {
    for name in names {
      self.addStudent(name: name)
    }
  }

  // subscript는 읽기전용일 때, `get` 생략 가능
  subscript(index: Int = 0) -> Student? {
    if index < self.number {
      return self.students[index]
    }
    return nil
  }
}

let highSchool: School = School()
highSchool.addStudents(names: "A", "B", "C", "D", "E")

let aStudent: Student? = highSchool[1]  // Optional Type인 걸 인지해야 한다.

print(aStudent?.number as Any, aStudent?.name as Any)  // > Optional(1) Optional("B")

// []에 argument가 없으므로 subscript의 parameter 기본값(0)을 사용
print(highSchool[]?.name as Any)  // > Optional("A")


// 1-(2). 복수 개의 subscript
// - subscript는 Overloading이 가능하다.
class School2 {
  var number: Int = 0
  var students: [Student] = [Student]()

  func addStudent(name: String) {
    let student: Student = Student(name: name, number: self.number)
    self.students.append(student)
    self.number += 1
  }

  func addStudents(names: String...) {
    for name in names {
      self.addStudent(name: name)
    }
  }

  // subscript는 getter, setter의 역할을 할 수 있다.
  subscript(index: Int) -> Student? {
    get {
      if index < self.number {
        return self.students[index]
      }
      return nil
    }
    set {
      guard var newStudent: Student = newValue else { return }  // 입력값이 Student Type이 아니면 빠른종료

      var number: Int = index
      
      if (index > self.number) {
        number = self.number
        self.number += 1
      }
      newStudent.number = number
      self.students[number] = newStudent
    }
  }

  subscript(name: String) -> Int? {
    get {
      return self.students.filter({ $0.name == name }).first?.number
    }
    set {
      guard var number: Int = newValue else { return }  // 입력값이 Int Type이 아니면 빠른종료

      if (number > self.number) {
        number = self.number
        self.number += 1
      }
      let newStudent: Student = Student(name: name, number: number)
      self.students[number] = newStudent
    }
  }

  subscript(name: String, number: Int) -> Student? {
    return self.students.filter({ $0.name == name && $0.number == number }).first
  }
}

let highSchool2: School2 = School2()
highSchool2.addStudents(names: "A", "B", "C", "D", "E")

highSchool2[0] = Student(name: "newA", number: 0)  // setter
print(highSchool2[0]?.name as Any)  // > Optional("newA")

print(highSchool2["F"] as Any)  // > nil
print(highSchool2["B", 1] as Any)  // > Optional(main.Student(name: "B", number: 1))

// 1-(3). Type subscript
// - 인스턴스가 아니라 타입 자체에서 사용할 수 있는 subscript
// - `static subscript` 키워드 사용


// 2. Class Inheritance (클래스 상속)
// - Struct랑 달리, Class는 부모 Class로부터 상속받을 수 있다.
// - `override` 키워드를 통해 부모 클래스의 함수를 재정의 할 수 있다.
// - Method뿐만 아니라, Property, Property 감시자, Subscript도 Override 가능하다.
// - override를 통해 재정의하였지만, 부모클래스의 함수를 활용하고 싶으면 `super` 키워드 사용
// - `final` 키워드를 통해 부모 클래스의 함수를 재정의를 못하도록 할 수 있다.
// - Class 자체를 상속을 금지할려면 class 앞에 `final`를 명시해주면 된다.

// 2-(1). Class 상속
// Student의 부모 클래스
class Person {  
  var name: String = ""
  var age: Int = 0

  var introduce: String {
    return "Hi, my name is \(name) and I'm \(age) years old."
  }

  func speak() {
    print("Blah~ Blah~")
  }
}

// Person의 자식 클래스
class Student2: Person {
  var grade: String = "F"

  func study() {
    print("I'm studying hard.")
  }

  // Override를 통해 부모클래스의 speak() 재정의
  override func speak() {
    super.speak()  // super를 통해 부모클래스의 speak() 호출
    print("I'm Student")
  }
}

let p1: Person = Person()
p1.name = "John"
p1.age = 20
print(p1.introduce)  // > Hi, my name is John and I'm 20 years old.)
p1.speak()  // > Blah~ Blah~

let s1: Student2 = Student2()
s1.name = "Jay"
s1.age = 10
s1.grade = "A"
print(s1.introduce)  // > Hi, my name is Jay and I'm 10 years old.)
s1.speak()  // > Blah~ Blah~\nI'm Student
s1.study()  // > I'm studying hard.

// 2-(2). Designated Init, Convenience Init
// - Designated Init: 부모클래스의 Init을 호출할 수 있으며, 같은 클래스의 모든 프로퍼티를 초기화한다.
// - Convenience Init: 항상 같은 클래스의 이니셜라이저를 호출한다.
class Person2 {
  var name: String
  var age: Int
  var test: String = "할당됐는 지 체크"

  // designated init
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

// - 적절하게 초기화한 경우: super.init하기 전에 본 클래스의 프토퍼티 모두 초기화, 상속된 값을 사용하기 전에 superclass 초기화
class Student3 : Person2 {
  var major: String

  // designated init
  init(name: String, age: Int, major: String) {
    self.major = "CS"
    // print(test)  -> 아직 할당되지 않았으므로 오류 발생
    super.init(name: name, age: age)  // super.init은 현 클래스의 프로퍼티를 초기화한 후 호출되어야 한다. 즉, major를 초기화한 후 호출
    print(test)  // 할당되었음
  }

  // convenience init
  convenience init(name: String) {
    self.init(name: name, age: 7, major: "")  // convenience init는 내부에 designated init를 반드시 호출
  }
}

var s2: Student3 = Student3(name: "A")
print(s2.name, s2.age, s2.major)  // > A 7 CS

// 2-(3). 자동 상속 Init
// - 대부분의 경우 자식클래스에서 이니셜라이저를 재정의 할 필요 없음
// - 자식 클래스에서 별도의 지정 이니셜라이저를 구현하지 않는다면 부모클래스의 지정 이니셜라이저가 자동 상속
class Person3 {
  var name: String

  init(name: String) {
    self.name = name
  }
}

class Student4: Person3 {
  var major: String = "CS"
}

// 2-(3). Required Init
// - Required Init은 자식클래스에서 반드시 구현해야한다.
// - `required` 키워드 사용하여
class Person4 {
  var name: String

  required init() {  // Required Init
    self.name = "Unknown"
  }
}

class Student5: Person4 {
  var major: String = "Unknown"  // Init 자동 상속
}

let m: Student5 = Student5()
print(m.name)  // > Unknown


// 3. TypeCasting (타입 변환)
// - 인스턴스의 타입을 검사하거나, 해당 인스턴스를 자신의 ‘클래스 계층 (class hierarchy)’ 어딘가의 다른 ‘상위 클래스’ 또는 ‘하위 클래스’ 로 취급하기 위한 방법입니다.
// - `is` 연산자 또는, Metatype을 사용

// 3-(1). is
var check: Int = 5
print(check is Int)     // > true
print(check is String)  // > false

// 3-(2). Metatype
// - https://sujinnaljin.medium.com/swift-self-type-protocol-self%EA%B0%80-%EB%AD%94%EB%94%94%EC%9A%94-7839f6aacd4
// - 다시 정리 예정

// 3-(3). Downcasting
// - 부모클래스의 타입을 자식클래스의 타입으로 다운하여 캐스팅
// - `as?`, `as!` 두 형태로 사용
let optionalValue: Int? = 100
print(optionalValue as? Int)  // > 100