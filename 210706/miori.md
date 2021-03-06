# Chap2

## π λͺλͺκ·μΉ
- μ€μννΈμμ λ―Έλ¦¬ μ ν μμ½μ΄, ν€μλ μ¬μ© λΆκ°
    - ex) `let var : String = "string"` var μ swift ν€μλ μ΄λ―λ‘ μμ μ΄λ¦μΌλ‘ μ¬μ© λΆκ°
- μ°μ°μλ‘ μ¬μ©λ μ μλ `(+, -, *, /)` κΈ°νΈ μ¬μ© λΆκ°
- μ«μλ‘ μμνλ κ²½μ° λΆκ°
- κ³΅λ°±μ΄ ν¬ν¨λλ κ²λ λΆκ°
### # Lower Case Case (μ²«κΈμκ° μλ¬Έμ) μ¬μ©νλ κ²½μ°
- ν¨μ, λ§€μλ, μΈμ€ν°μ€μ μ΄λ¦
### # Upper Case Case (μ²«κΈμκ° λλ¬Έμ) μ¬μ©νλ κ²½μ°
- ν΄λμ€, κ΅¬μ‘°μ²΄, μ΅μ€νμ, νλ‘ν μ½, μ΄κ±°ν (νμμ΄κΈ° λλ¬Έμ)

## π Console Log
### #  `print()` vs `dump()`
- 'print()' μ λ¬λ¦¬ `dump()` λ μΈμ€ν΄μ€μ λ΄λΆ μ½νμΈ κΉμ§ μΆλ ₯
``` swift
class Person {
    var name : String = ""
    var age : Int = 0
}

let miori : Person = Person()
miori.name = "miori"
miori.age = 25

print("print μ°λ©΄ : \(miori)")
/*
- \() μ΄κ² λ°λ‘ String Interpolation
*/
dump(miori)
/* μΆλ ₯
print μ°λ©΄ : SwiftPlayground.Person
βΏ SwiftPlayground.Person #0
  - name: "miori"
  - age: 25
*/
```

## π λ³μμ μμ
- κ°μ₯ ν° μ°¨μ΄λ **μμ±ν κ° λ³κ²½ μ¬λΆ**
### λ³μ
- `var λ³μλͺ : λ°μ΄ν°νμ = κ°` 
- type μΆλ‘ μ΄ κ°λ₯νλ€ annotation ν΄μ£Όλ κ²μ κΆμ₯ 
``` swift
var hobby = "crossfit"
print("type is \(type(of:hobby))")
// μΆλ ₯ : type is String
```
### μμ
- `let μμλͺ : λ°μ΄ν°νμ = κ°` 

# Chap3

## π λ°μ΄ν° νμ
- swift μ κΈ°λ³Έ data. type μ κ΅¬μ‘°μ²΄ κΈ°λ°
- Upper Camel Case μ¬μ©

## π Int vs UInt
- μ μ

|Data Type|λ²μ|
|:---|:---:|
|Int|+,- λΆνΈ ν¬ν¨|
|UInt|0μ ν¬ν¨ν μμ μ μ|

## π Bool
- Boolean 
- true / false κ°μ κ°μ§ (μλ¬Έμλ‘ ν΄μΌν¨)
- 0,1 κ³Ό νΈν μλ¨
```swift
var boolean : Bool = true
print(boolean)
boolean.toggle()
print(boolean)
let a : Bool = true
print("a μΆλ ₯ \(a)")
```

## π Float vs Double 
- λΆλμμμ μ μ¬μ©νλ μ€μ

```swift
var floatVal : Float = 1234567890.1
var doubleVal : Double = 1234567890.1

print("floatVal : \(floatVal) κ·Έλ¦¬κ³  doubleVal : \(doubleVal)")
floatVal = 123456.1
print("float μ΄κ±΄ κ°λ₯ \(floatVal)")

// μΆλ ₯
// floatVal : 1.234568e+09 κ·Έλ¦¬κ³  doubleVal : 1234567890.1
// float μ΄κ±΄ κ°λ₯ 123456.1
```
- float κ° μμ©ν  μ μλ λ²μκ° λ μμ

|Data Type|λ²μ|64bitμμ ννκ°λ₯ν μλ¦Ώμ|
|:---|:---:|:--:|
|float|32bit|6μλ¦¬|
|double|64bit|15μλ¦¬|

## π Character vs String

|Data Type|μ μ|
|:---|:---:|
|Character|λ¨νλμ λ¬Έμ|
|String|λ¬Έμμ΄|

## π String μ λ€μν κΈ°λ₯
## # λ¬Έμμ΄ μ΄μ΄ λΆμ΄κΈ°
- `append`
``` swift
var a : String = "a"
a.append("b")
print(a) //ab
```
- `+` μ°μ°μ
``` swift
var a : String = "a"
a += "b"
print(a) //ab
```

## # λ¬Έμ μ μΉ΄μ΄νΈ
```swift
var a = "la la la"
print(a.count) //8
```

## # λΉμ΄μλμ§ νμΈ
```swift
var a = "la la la"
print(a.isEmpty) //false
var b = ""
print(b.isEmpty) //true
```

## # μ λμ½λμ μ€μΉΌλΌ κ°λ μ¬μ© κ°λ₯
``` swift
var c : String = "\u{2665}"
print(c) //β₯
```

## # λμλ¬Έμ λ³ν
```swift
var a : String = "aaa"
print(a.uppercased()) //AAA

var b : String = "BbB"
print(b.lowercased()) //bbb
```

## # μ€ λ°κΏ λλ
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

## π λ¬Έμμ΄ λ΄ νΉμλ¬Έμ

|νΉμλ¬Έμ|μ€λͺ|
|:---|:---:|
|\n|μ€λ°κΏ|
|\\\\ |λ°±μ¬λμ|
| \\\" |ν°λ°μ΄ν|
|\t|ν­ λλ μλλ κ°μ|
|\0|λ¬Έμμ΄ λλ¬μμ μλ¦¬λ null λ¬Έμ|

## π Any, AnyObject, nil
## # Any
- λͺ¨λ  λ°μ΄ν° νμ μ¬μ© κ°λ₯ν¨

## # AnyObject
- ν΄λμ€μ μΈμ€ν°μ€λ§ ν λΉ κ°λ₯

## # nil
- **μμ** μ λνλ
- μ΅μλλ‘ μ€λ₯ ν΄κ²° κ°λ₯

