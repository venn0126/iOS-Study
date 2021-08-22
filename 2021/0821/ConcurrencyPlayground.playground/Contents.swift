import UIKit

var greeting = "Hello, playground"

func someNames() async -> [String] {
    await Task.sleep(2)
    return ["niu","wei","augus"]
}

print("concurreny begin")
//let res = await someNames()

//let res = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts/1")!))
//print(res)


/// Download image by URLSession and closure
func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}



let url = URL(string: "https://github.com/venn0126/iOS-Study/blob/master/Resource/IMG_1258.jpeg?raw=true") ?? nil
//let url = URL(string: "")
guard let url = url else {
    print("url is nil")
    fatalError()
}
// get data func
getData(from: url) { data, response, error in
    guard let data = data, error == nil else { return }
    print(response?.suggestedFilename ?? url.lastPathComponent)
    print("Download Finished")
    // always update the UI from the main thread
    DispatchQueue.main.async() {
        print("image len is \(data.count)")
    }
    
}


/// async & await vs closure
/// Closure
func fetchImages(completion: (Result<[UIImage], Error>) -> Void) {
    // .. perform data request
}

/// Now async
@Sendable func asyncFetchImages() async throws -> [UIImage] {
    
    return []
}

/// Call async method

Task {
    do {
        let images = try await asyncFetchImages()
        print(images.count)
    } catch {
        print("happen error \(error)")
    }
}


class TryThis {
    func getSomethingLater(_ number: Double) async -> String {
        // test - sleep for 3 seconds, then return
        Thread.sleep(forTimeInterval: 3)
        return String(format: ">>>%8.2f<<<", number)
    }
}

let tryThis = TryThis()

Task {
    let result = await tryThis.getSomethingLater(3.141592653589793238462)
    print("result: \(result)")
}

actor TemptureMeasure {
    let label: String
    var mesuars: [Int]
    private(set) var max: Int
    init(label: String,mesuras: Int) {
        self.label = label
        self.mesuars = [mesuras]
        self.max = mesuras
    }
}

extension TemptureMeasure {
    func updateMeasure(mesuare: Int) {
        mesuars.append(mesuare)
        if mesuare > max {
            max = mesuare
        }
    }
}

let logger = TemptureMeasure(label: "Aym", mesuras: 10)
Task {
    print(await logger.max)
}




