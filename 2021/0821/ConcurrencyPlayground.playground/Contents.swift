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



