import UIKit

/**
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

//Task {
//
//    async let img = fetchImage(name: "img0")
//    async let img1 = fetchImage(name: "img1")
//
//    let arrary = await [img,img1]
//    print(arrary)
//
//}

*/
class Person {
    
    var name: String
    init(name: String) {
        self.name = name
    }
}

actor BankAccount {
 
    var owners: [Person] = [Person(name: "augus")]
    func primaryOwner() -> Person? {
        return owners.first
    }
}

let account = BankAccount()
//Task.detached(priority: .background) {
//    if let primary = await account.primaryOwner() {
//        primary.name = "gao"
//        print("primary name is \(primary.name)")
//    }
//}

//Task(priority: .background, operation: {
//
//    if let primary = await account.primaryOwner() {
//        primary.name = "gao"
//        print("primary name is \(primary.name)")
//    }
//})

//print("The end")

enum FetchError: Error {
    case NotFound
    case TypeError
    case Unknown
}


func fetchThumbnail(for id: String,completion: @escaping (UIImage?, Error?) -> Void) {
    let request = URLRequest(url: URL(string: id)!)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(nil,error)
        } else if (response as? HTTPURLResponse)?.statusCode != 200 {
            completion(nil,error)
        } else {
            guard let image = UIImage(data: data!) else {
                completion(nil,error)
                return
            }
            image.prepareThumbnail(of: CGSize(width: 40, height: 40)) { thumbnail in
                
                guard let thum = thumbnail else {
                    completion(nil, error)
                    return
                }
                completion(thum,nil)
            }
        }
    }
    task.resume()
}

func fetchThumbnailAsync(for id: String) async throws -> UIImage {
    
    let request = URLRequest(url: URL(string: id)!)
    
    let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw FetchError.NotFound
    }
    let maybeImage = UIImage(data: data)
    guard let thumbnail = await maybeImage?.thumbnail else {
        throw FetchError.NotFound
    }
    
    return thumbnail
}




extension UIImage {
    
    var thumbnail: UIImage? {
        get async {
            let size = CGSize(width: 40, height: 40)
            return await self.byPreparingThumbnail(ofSize: size)
        }
    }
    
    func prepareThumbnail(of: CGSize,completion: (UIImage?) -> Void) {
        
        // size
        
        // draw
    }
}


// adopting

// snap

struct Feed {
    var url: URL
}


let feed1 = Feed(url: URL(string: "xxx")!)
let feed2 = Feed(url: URL(string: "xxx")!)
let feed3 = Feed(url: URL(string: "xxx")!)

let feedsToUpdate = [feed1,feed2,feed3]

let urlSession = URLSession(configuration: .default)
for feed in feedsToUpdate {
    let dataTask = urlSession.dataTask(with: feed.url) {data, response, error in
        guard let data = data else { return }
        do {
            // transfer data to some thing
            // update UI by some thing
        } catch {
            
        }
        
    }
    dataTask.resume()
}

/// to transfer by  async and await

Task {
    
//    let (response, data) = await urlSession.dataTask(with: feed1.url)
//    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//        throw FetchError.NotFound
//    }
    
    
}



