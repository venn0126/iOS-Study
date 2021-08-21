import UIKit

var greeting = "Hello, playground"

func someNames() async -> [String] {
    await Task.sleep(2)
    return ["niu","wei","augus"]
}

print("concurreny begin")
//let res = await someNames()
