
import Foundation

// Thanks to https://stackoverflow.com/a/34308158/3266978
extension URLSession {
    func synchronousDataTask(with url: URL, andHeaders headers : Dictionary<String, String>? = nil) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var request = URLRequest(url: url)
        
        if headers != nil {
            for key in headers!.keys {
                let value = headers![key]!
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let dataTask = self.dataTask(with: request) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
}
