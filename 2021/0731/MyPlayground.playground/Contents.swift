//: A UIKit based Playground for presenting user interface
  

import Foundation

/**
let p = UnsafeMutableRawPointer.allocate(byteCount: 4 * 8, alignment: 8)
defer {
    p.deallocate()
}

for i in 0..<4 {
    p.advanced(by: i * 8).storeBytes(of: i, as: Int.self)
}
let offset = 8 * 4
print(p.advanced(by: offset).load(as: Int.self))

class Document {
    
    var name: String?
    
    init() {}
    
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class AutoDoc: Document {
    
//    override init() {
//        super.init()
//        self.name = "[Untitled]"
//    }
    
    override init() {
        super.init(name: "[Untitled]")!
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[untitled]"
        } else {
            self.name = name
        }
    }
}



/// Protocol
protocol FullyName {
    
    var fullName: String { get }
}

struct Person: FullyName {
    
    var fullName: String
}

let p = Person(fullName: "augus venn")
print(p.fullName)


/// property requirements
class StarShip: FullyName {
    
    
    // instance properties
    var prefix: String?
    var name: String
    
    // instance compute property
    var fullName: String {
        return ((prefix != nil) ? prefix! : "") + name
    }
    
    // initialization method
    init(name: String,prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
}

let s1 = StarShip(name: "niu")
s1.fullName
let s2 = StarShip(name: "niu", prefix: "wei")
s2.fullName

/// Method requirements

protocol RandomNumberGenerate {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerate {
    
    //property
    var lastRandom = 42.0
    let a = 139968.0
    let m = 3877.0
    let c = 29573.0
    
    
    // protocol method
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        return lastRandom / m
    }
}


let generator = LinearCongruentialGenerator()
print(generator.random())
print(generator.random())
print(generator.random())

/// Mutaing method requirement
protocol Togglable {
    mutating func toggle()
}

enum OneSwitch: Togglable {
    
    case on,off
    
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}


var one = OneSwitch.off
one.toggle()
one.toggle()

/// Initialization requiremnt

protocol SomeProtol {
    init()
}

class BaseClass {
    init() {
        
    }
}

class someClass: BaseClass, SomeProtol {
    
   override required init() {
        
    }
}


/// Protocol as type
class Dice {
    
    let sides: Int
    let generator: RandomNumberGenerate
    
    init(sides: Int,generator: RandomNumberGenerate) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
    
}

let dice = Dice(sides: 3, generator: LinearCongruentialGenerator())
for _ in 1..<5 {
    print("random dice is \(dice.roll())")
}

/// Delegation
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

/// Only class to adopt
protocol DiceGameDelegate: AnyObject {
    
    // Start game method
    func gameDidStart(_ game: DiceGame)
    // Dice start turn
    func game(_ game: DiceGame,didStartNewTurnWithDiceRolldiceRoll diceRoll: Int)
    // End game
    func gameDidEnd(_ game: DiceGame)
    
}

class SnakesAndLadders: DiceGame {
    
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[0] = +08;board[06] = +11;board[09] = +09
        board[10] = +02;board[14] = -10;board[19] = -11;
        board[22] = -02;board[24] = -08
    }
    
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRolldiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue
            
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
    
}


class DiceGameTracker: DiceGameDelegate {
 
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("start a new dice game")
        }
        
        print("The gam is use \(game.dice.sides)")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRolldiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Roll a \(diceRoll)")
    }
    
    
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()



/// Add protocol conformance with an extensions
protocol TextDescription {
    var description: String { get }
}


protocol HasName {
    var name: String { get }
}

struct Cat {
    var name: String = "Tom"
    var age: Int = 18
}

extension Cat: TextDescription {
    var description: String {
        return "The cat name is \(name) and ags is \(age)"
    }
}

struct Car: HasName {
    var name: String = "DZ"
    var wheel: Int = 2
    

}

extension Car: TextDescription {
    var description: String {
        return "The Car name is \(name) and has \(wheel) wheels"
    }
}

let aCar = Car()
aCar.description

let aCat = Cat()
aCat.description

extension Array: TextDescription where Element: HasName {
    
    func mapSomething() -> [String] {
        
        let res = self.map {
            $0.name
        }
        return res
    }
}

struct Hamster: HasName {
    var name: String = "Tom"
    var description: String {
        return "A hamster name is \(name)"
    }
}

extension Hamster: TextDescription {}

var aHamster = Hamster(name: "gao")
aHamster.name = "weo"
aHamster.description

struct Vector3D: Equatable {
    var x = 0.0,y = 0.0,z = 0.0
    var decription: String {
        return "xxx"
    }
}

let aTwo = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let otherTwo = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if aTwo == otherTwo {
    print("atwo is equal thetwo")
} else {
    print("atwo is not equal thetwo")

}
aTwo.decription

enum Week: Equatable,Hashable {
    case Monday,Tuseday,Wednesday
    var description: String {
        return "The day is \(self)"
    }
}

let aDay = Week.Monday
let otherDay = Week.Monday
if  aDay == otherDay {
    print("aday is equal other theday")
} else {
    print("aday is not equal other theday")
}
aDay.description

if aDay.hashValue == otherDay.hashValue {
    print("aday hash is equal theday")
} else {
    print("aday hash is not equal theday")

}

enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(start: Int)
}

var levels = [SkillLevel.beginner,SkillLevel.intermediate,SkillLevel.expert(start: 3),SkillLevel.expert(start: 5)]
                
for level in levels.sorted() {
    print(level)
}

let things: [TextDescription] = [aCat,aCar,aHamster]
for thing in things {
    print(thing.description)
}

/// Protocol Inheritance

protocol PrettyTextDescription: TextDescription {
    var prettyTextDescription: String { get }
}

extension Car: PrettyTextDescription {
    var prettyTextDescription: String {
        return "🐈‍⬛ name is \(name)"
    }
}

aCar.prettyTextDescription

/// Class-Only Protocol
protocol MaxTextDescription: AnyObject,HasName {
    
    var maxTextDescription: String { get }
}
class Peron {
    var height: Double
    init(height: Double) {
        self.height = height
    }
}

extension Peron: MaxTextDescription {
    var name: String {
        return "Niu"
    }
    var maxTextDescription: String {
        return "The max person height is \(height)"
    }
}

let aPerson = Peron(height: 17.8)
aPerson.maxTextDescription

/// Non-class not comform AnyObjct protocl
//struct Rect: MaxTextDescription {
//    var name: String
//
//}


/// Protocol Composition
protocol Named {
    var name: String { get }
}

protocol Aged {
    var aged: Int { get }
}

struct SPerson: Named,Aged {
    var name: String
    var aged: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday,celebrator's name is \(celebrator.name) and age is \(celebrator.aged)")
}

let sp = SPerson(name: "Gao", aged: 17)
wishHappyBirthday(to: sp)
//wishHappyBirthday(to: aCar)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double,longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location,Named {
    
    var name: String
    init(name: String,latitude: Double,longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("The \(location.name) city lat \(location.latitude) and longitude \(location.longitude)")

}

let aCity = City(name: "Beijing", latitude: 112.9, longitude: 121.2)
beginConcert(in: aCity)


/// check protocol conformance
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    var radius: Double
    var area: Double {
        return (radius * radius * 3.14)
    }
    
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

let objects: [AnyObject] = [Circle(radius: 10.0),Country(area: 5.0),Peron(height: 12.2)]
for obc in objects {
    if let ob = obc as? HasArea {
        print("The are is \(ob.area)")
    } else {
        print("ob is no area")
    }
}

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment()  {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject,CounterDataSource {
    let fixedIncrement = 3
}


var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class ZeroSource: NSObject,CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if  count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.dataSource = ZeroSource()
counter.count = -4
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}


/// Protocl Extensions
extension HasArea {
    func isArea() -> Bool {
        return area > 0.5
    }
}

let acountry = Country(area: 0.9)
acountry.isArea()

// Provide default implention

extension HasName {
    var name: String {
        return  name
    }
}

extension MaxTextDescription {
    var maxTextDescription: String {
        return name
    }
}

// Add Constraints to protocol extensions
extension Collection where Element: Equatable {
    
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

let array1 = [1,2,1,1]
let array2 = [2,2,2,2]
print(array1.allEqual())
print(array2.allEqual())
 

/// Associated Types
protocol Container {
    
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
}

struct IntStack: Container {
    // original instack implemetation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        items.removeLast()
    }
    
    // conformance to the Container protocol
//    typealias Item = Int
    mutating func append(_ item: Item) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
    
}

var st = IntStack()
st.push(1)
st.push(2)
print(st.items)


struct StackT<T>: Container {
    // origin implemetion
    var items = [T]()
    
    mutating func push(item: T)  {
        items.append(item)
    }
    
    mutating func pop() {
        items.removeLast()
    }
    
    // protocol container implementation
    typealias Item = T
    mutating func append(_ item: Item) {
        self.push(item: item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> T {
        return items[i]
    }
}

var stt = StackT<String>()
stt.push(item: "niu")
stt.push(item: "wei")
print(stt.items)
stt.pop()

extension Array: Container {}
var arr = Array<String>()
arr.append("sss")


func allItemMatch<C1: Container,C2: Container>(_ someContainer: C1,_ otherContainer: C2) -> Bool where C1.Item == C2.Item,C1.Item: Equatable {
    
    if someContainer.count != otherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != otherContainer[i] {
            return false
        }
    }
    
    return true
}

var stackOfStr = StackT<String>()
stackOfStr.push(item: "niu")
stackOfStr.push(item: "wei")

var otherStrArray = ["niu","weis"]
if allItemMatch(stackOfStr, otherStrArray) {
    print("two container is equal")
} else {
    print("two container is not equal")
}

// Extensions with a generic where
// clause

extension StackT where T: Equatable {
    
    func isTop(_ item: T) -> Bool {
        
        guard let top = items.last else {
            return false
        }
        
        return top == items.last
    }
}

var topInt = StackT<Int>()
topInt.push(item: 1)
topInt.push(item: 2)
topInt.push(item: 3)

if topInt.isTop(3) {
    print("it is top")
} else {
    print("it is not top")
}

extension Container where Item: Equatable {
    
    func startsWith(_ item: Item) -> Bool {
        
        return count >= 1 && self[0] == item
    }
}


if [1,2,3].startsWith(1) {
    print("Begin is 1")
} else {
    print("Begin is not 1")
}

extension Container where Item == Double {
    
    func average() -> Double {
        var sum = 0.0
        for idx in 0..<count {
            sum += self[idx]
        }
        return sum / Double(count)
    }
}

print("avergae is \([1.1,2.2,3.24].average())")


// Contextual where clauses
extension Container where Item ==  Int {
    func average() -> Double {
        
        var sum = 0.0
        for idx in 0..<count {
            sum += Double(self[idx])
        }
        return sum / Double(count)
    }
}

extension Container where Item: Equatable {
    
    func endWith(_ item: Item) -> Bool {
        return count >= 1 && item == self[count-1]
    }
}


// Associated types with a generic where clause

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    //
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
    
    
}

protocol ComparableContainer: Container where Item: Comparable {
    
}

// Generic subcripts
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item] where Indices.Iterator.Element == Int {
        var  result = [Item]()
        for idx in 0..<count {
            result.append(self[idx])
        }
        return result
    }
}
 
 */

/// Memory safey

var apple = 1 // write
print("apple's value is \(apple)") // read

func addNumber(_ number: Int) -> Int {// write
    
    //
//    number += 1
    // read
    return number + 1
}


var stepSize = 1
func increment(_ num: inout Int) {// if num is stepSize so writing stepSize
    num += stepSize // stepSize is reading
}

var num = 3
// read and write is same time
//increment(&stepSize)

print("num is \(num)")

// slove situation
// make an explict copy

var copyStepSize = stepSize
print("copy value is\(copyStepSize) and step size is \(stepSize)")
increment(&copyStepSize)
print("copy value is\(copyStepSize) and step size is \(stepSize)")


func balance(_ x: inout Int,_ y: inout Int) {// write x & y variable
    
    let temp = x + y // read x and y
    x = temp / 2 // write x
    y = temp - x // write y
    
}

var one = 43
var two = 30
balance(&one, &two)
//balance(&one, &one)

// clouse of strong cycle

class Tian {
    
    var name: String
    var description: ()-> Void {
        return { [unowned self] in
            print("name is \(self.name)")
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("tian is deinitalization")
    }
}

var t1: Tian?
t1 = Tian(name: "gao")
t1?.description()
t1 = nil







