
import Foundation
import Alamofire
import OAuthSwift
import SWXMLHash

class Network {
    private static func request(_ url : URL, method: HTTPMethod, parameters: Parameters?, parametersEncoding: String, headers: HTTPHeaders?) -> (Data?, Error?) {
        var data : Data?
        var error : Error?
        var encoding : ParameterEncoding = URLEncoding.default
        if parametersEncoding == "json" {
            encoding = JSONEncoding.default
        }
        let semaphore = DispatchSemaphore(value: 0)
        
        let queue = DispatchQueue.global(qos: .background)
        queue.async {
            Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).response(queue: queue, completionHandler: { (response) in
                data = response.data
                error = response.error
                semaphore.signal()
            })
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, error)
    }
    
    static func getJsonDictionary(url : String, headers : [String : Any]?) -> [String: Any] {
        var data : Data?
        var error : Error?
        let url : URL = URL(string: url) != nil ? URL(string: url)! : URL(string: "http://example.com")!
        
        (data, error) = Network.request(url, method: .get, parameters: nil, parametersEncoding: "default", headers: headers as? Dictionary<String, String>)
        
        if error != nil {
            print(error!.localizedDescription)
            // Handle network error
            return [:]
        }
        
        do {
            if let data = data,
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                return json
            }
        } catch {
            print("Error deserializing JSON")
        }
        
        return [:]
    }
    
    static func getJsonArray(url : String, headers : [String : Any]?) -> [Any] {
        var data : Data?
        var error : Error?
        let url : URL = URL(string: url) != nil ? URL(string: url)! : URL(string: "http://example.com")!
        
        (data, error) = Network.request(url, method: .get, parameters: nil, parametersEncoding: "default", headers: headers as? Dictionary<String, String>)
        
        if error != nil {
            print(error!.localizedDescription)
            // Handle network error
            return []
        }
        
        do {
            if let data = data,
                let json = try JSONSerialization.jsonObject(with: data) as? [Any] {
                return json
            }
        } catch {
            print("Error deserializing JSON")
        }
        
        return []
    }
    
    static func getImage(url : String, headers : [String : Any]?) -> UIImage {
        var data : Data?
        var error : Error?
        let url : URL = URL(string: url) != nil ? URL(string: url)! : URL(string: "http://example.com")!
        
        (data, error) = Network.request(url, method: .get, parameters: nil, parametersEncoding: "default", headers: headers as? Dictionary<String, String>)
        
        if error != nil {
            print(error!.localizedDescription)
            // Handle network error
            return UIImage(named: "blank")!
        }
        
        if let data = data,
            let image = UIImage(data: data) {
            return image
        }
        
        return UIImage(named: "blank")!
    }
    
    static func postJsonStringResponse(toUrl url : String, withBody body : [String : Any], withHeaders headers : [String : Any]?) -> String {
        var data : Data?
        var error : Error?
        let url : URL = URL(string: url) != nil ? URL(string: url)! : URL(string: "http://example.com")!
        
        (data, error) = Network.request(url, method: .post, parameters: body, parametersEncoding: "json", headers: headers as? Dictionary<String, String>)
        
        if error != nil {
            print(error!.localizedDescription)
            // Handle network error
            return ""
        }
        
        if let data = data,
            let string = String(data: data, encoding: .utf8) {
            return string
        }
        
        return ""
    }
    
    static func postJsonDictResponse(toUrl url : String, withBody body : [String : Any], withHeaders headers : [String : Any]?) -> [String : Any] {
        var data : Data?
        var error : Error?
        let url : URL = URL(string: url) != nil ? URL(string: url)! : URL(string: "http://example.com")!
        
        (data, error) = Network.request(url, method: .post, parameters: body, parametersEncoding: "json", headers: headers as? Dictionary<String, String>)
        
        if error != nil {
            print(error!.localizedDescription)
            // Handle network error
            return [:]
        }
        
        do {
            if let data = data,
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                return json
            }
        } catch {
            print("Error deserializing JSON")
        }
        
        return [:]
    }
    
    static func getXMLDictionary(url : String, headers : [String : Any]?) -> [String: Any] {
        var data : Data?
        var error : Error?
        let url : URL = URL(string: url) != nil ? URL(string: url)! : URL(string: "http://example.com")!
        
        (data, error) = Network.request(url, method: .get, parameters: nil, parametersEncoding: "default", headers: headers as? Dictionary<String, String>)
        
        if error != nil {
            print(error!.localizedDescription)
            // Handle network error
            return [:]
        }
        
        if data != nil {
            
            func enumerate(_ indexer: XMLIndexer) -> Dictionary<String, Any> {
                
                var childElements = Dictionary<String, Any>()
                for child in indexer.children {
                    if child.children.count == 0 {
                        
                        if childElements[child.element!.name] == nil {
                            childElements[child.element!.name] = child.element!.text
                        } else if childElements[child.element!.name] is Array<Any> {
                            var arrayValue = (childElements[child.element!.name] as! Array<Any>)
                            arrayValue.append(child.element!.text)
                            childElements[child.element!.name] = arrayValue
                        } else {
                            let oldValue = childElements[child.element!.name]
                            var arrayValue = Array<Any>()
                            arrayValue.append(oldValue as Any)
                            arrayValue.append(child.element!.text)
                            childElements[child.element!.name] = arrayValue
                        }
                        
                    } else {
                        
                        if childElements[child.element!.name] == nil {
                            childElements[child.element!.name] = enumerate(child)
                        } else if childElements[child.element!.name] is Array<Any> {
                            var arrayValue = (childElements[child.element!.name] as! Array<Any>)
                            arrayValue.append(enumerate(child))
                            childElements[child.element!.name] = arrayValue
                        } else {
                            let oldValue = childElements[child.element!.name]
                            var arrayValue = Array<Any>()
                            arrayValue.append(oldValue as Any)
                            arrayValue.append(enumerate(child))
                            childElements[child.element!.name] = arrayValue
                        }
                        
                    }
                }
                
                return childElements
                
            }
            
            let xml = SWXMLHash.parse(data!)
            return enumerate(xml)
        }
        
        return ["error": "No XML data available"]
    }
    
    static func postForm(toUrl url : String, formData form : [String : Any], withHeaders headers : [String : Any]?) -> Bool {
        var result = false
        let url : URL = URL(string: url) != nil ? URL(string: url)! : URL(string: "http://example.com")!
        let semaphore = DispatchSemaphore(value: 0)
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for key in form.keys {
                    
                    let value = form[key]
                    
                    guard value != nil else {
                        continue
                    }
                    
                    // From https://stackoverflow.com/questions/28680589/how-to-convert-an-int-into-nsdata-in-swift
                    if value is Int {
                        var intValue = (value as! Int).bigEndian
                        let data = NSData(bytes: &intValue, length: MemoryLayout<Int>.size)
                        
                        multipartFormData.append(data as Data, withName: key)
                    }
                    if value is Float {
                        var floatValue = value as! Float
                        let data = NSData(bytes: &floatValue, length: MemoryLayout<Float>.size)
                        
                        multipartFormData.append(data as Data, withName: key)
                    }
                    if value is String {
                        let data = (value as! String).data(using: String.Encoding.utf8)!
                        multipartFormData.append(data, withName: key)
                    }
                    if value is Bool {
                        var boolValue = value as! Bool
                        let data = NSData(bytes: &boolValue, length: MemoryLayout<Bool>.size)
                        
                        multipartFormData.append(data as Data, withName: key)
                    }
                    if value is Dictionary<String, Any> ||
                        value is Array<Any> {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: value!, options: .sortedKeys)
                            multipartFormData.append(data, withName: key)
                        } catch {
                            continue
                        }
                    }
                    if value is UIImage {
                        let data = UIImagePNGRepresentation(value as! UIImage)
                        guard data != nil else {
                            continue
                        }
                        
                        multipartFormData.append(data!, withName: key)
                    }
                }
        },
            to: url.absoluteString,
            headers: headers as? Dictionary<String, String>,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseString { response in
                        if response.error != nil {
                            result = false
                        } else {
                            result = true
                        }
                        semaphore.signal()
                    }
                    
                case .failure(_):
                    result = false
                    semaphore.signal()
                }
        })
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return result
    }
    
    static func OAuthSignIn(consumerKey key : String, consumerSecret secret : String, authorizeUrl authUrl : String, accessTokenUrl tokenUrl : String, responseType response : String, callbackUrl callback : String, scope : String, state : String, handlerViewController handler : UIViewController) -> String {
        let oauth = OAuth2Swift(consumerKey: key, consumerSecret: secret, authorizeUrl: authUrl, accessTokenUrl: tokenUrl, responseType: response)
        oauth.authorizeURLHandler = SafariURLHandler(viewController: handler, oauthSwift: oauth)
        let callbackUrl = URL(string: callback) != nil ? URL(string: callback)! : URL(string: "http://example.com")!
        var token = ""
        
        let semaphore = DispatchSemaphore(value: 0)
        
        // https://developer.github.com/apps/building-oauth-apps/authorization-options-for-oauth-apps/
        
        _ = oauth.authorize(withCallbackURL: callbackUrl, scope: scope, state: state,
                                  success: { credential, response, parameters in
                                    token = credential.oauthToken
                                    semaphore.signal()
        },
                                  failure: { error in
                                    token = "OAuth Error: \(error.localizedDescription)"
                                    semaphore.signal()
        })
        
        semaphore.wait()
        
        return token
    }
}
