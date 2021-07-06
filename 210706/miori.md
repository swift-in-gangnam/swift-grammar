# Chap2

## 📝 명명규칙
- 스위프트에서 미리 정한 예약어, 키워드 사용 불가
    - ex) `let var : String = "string"` var 은 swift 키워드 이므로 상수 이름으로 사용 불가
- 연산자로 사용될수 있는 `(+, -, *, /)` 기호 사용 불가
- 숫자로 시작하는 경우 불가
- 공백이 포함되는 것도 불가
### # Lower Case Case (첫글자가 소문자) 사용하는 경우
- 함수, 매서드, 인스터스의 이름
### # Upper Case Case (첫글자가 대문자) 사용하는 경우
- 클래스, 구조체, 익스텐션, 프로토콜, 열거형 (타입이기 때문에)

## 📝 Console Log
### #  `print()` vs `dump()`
- 'print()' 와 달리 `dump()` 는 인스턴스의 내부 콘텐츠까지 출력
``` swift
class Person {
    var name : String = ""
    var age : Int = 0
}

let miori : Person = Person()
miori.name = "miori"
miori.age = 25

print("print 쓰면 : \(miori)")
/*
- \() 이게 바로 String Interpolation
*/
dump(miori)
/* 출력
print 쓰면 : SwiftPlayground.Person
▿ SwiftPlayground.Person #0
  - name: "miori"
  - age: 25
*/
```

## 📝 변수와 상수
- 가장 큰 차이는 **생성후 값 변경 여부**
### 변수
- `var 변수명 : 데이터타입 = 값` 
- type 추론이 가능하다 annotation 해주는 것을 권장 
``` swift
var hobby = "crossfit"
print("type is \(type(of:hobby))")
// 출력 : type is String
```
### 상수
- `let 상수명 : 데이터타입 = 값` 

# Chap3

## 📝 데이터 타입
- swift 의 기본 data. type 은 구조체 기반
- Upper Camel Case 사용

## 📝 Int vs UInt
- 정수

|Data Type|범위|
|:---|:---:|
|Int|+,- 부호 포함|
|UInt|0을 포함한 양의 정수|

## 📝 Bool
- Boolean 
- true / false 값을 가짐 (소문자로 해야함)
- 0,1 과 호환 안됨
```swift
var boolean : Bool = true
print(boolean)
boolean.toggle()
print(boolean)
let a : Bool = true
print("a 출력 \(a)")
```

## 📝 Float vs Double 
- 부동소수점을 사용하는 실수

```swift
var floatVal : Float = 1234567890.1
var doubleVal : Double = 1234567890.1

print("floatVal : \(floatVal) 그리고 doubleVal : \(doubleVal)")
floatVal = 123456.1
print("float 이건 가능 \(floatVal)")

// 출력
// floatVal : 1.234568e+09 그리고 doubleVal : 1234567890.1
// float 이건 가능 123456.1
```
- float 가 수용할 수 있는 범위가 더 작음

|Data Type|범위|64bit에서 표현가능한 자릿수|
|:---|:---:|:--:|
|float|32bit|6자리|
|double|64bit|15자리|

## 📝 Character vs String

|Data Type|정의|
|:---|:---:|
|Character|단하나의 문자|
|String|문자열|

## 📝 String 의 다양한 기능
## # 문자열 이어 붙이기
- `append`
``` swift
var a : String = "a"
a.append("b")
print(a) //ab
```
- `+` 연산자
``` swift
var a : String = "a"
a += "b"
print(a) //ab
```

## # 문자 수 카운트
```swift
var a = "la la la"
print(a.count) //8
```

## # 비어있는지 확인
```swift
var a = "la la la"
print(a.isEmpty) //false
var b = ""
print(b.isEmpty) //true
```

## # 유니코드의 스칼라 값도 사용 가능
``` swift
var c : String = "\u{2665}"
print(c) //♥
```

## # 대소문자 변환
```swift
var a : String = "aaa"
print(a.uppercased()) //AAA

var b : String = "BbB"
print(b.lowercased()) //bbb
```

## # 줄 바꿈 느낌
```swift
var a = """
hello
hi
bye
"""
print(a)
/*
hello
hi
bye
*/
```

## 📝 문자열 내 특수문자

|특수문자|설명|
|:---|:---:|
|\n|줄바꿈|
|\\\\ |백슬랙시|
| \\\" |큰따옴표|
|\t|탭 눌렀을때랑 같음|
|\0|문자열 끝났음을 알리는 null 문자|

## 📝 Any, AnyObject, nil
## # Any
- 모든 데이터 타입 사용 가능함

## # AnyObject
- 클래스의 인스터스만 할당 가능

## # nil
- **없음** 을 나타냄
- 옵셔널로 오류 해결 가능

