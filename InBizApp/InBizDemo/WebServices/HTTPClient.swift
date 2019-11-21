import Foundation
import Alamofire
import SwiftyJSON
import Toast_Swift

protocol HTTRsponseDelegate {
    func sendResponseData(data: NSDictionary)
    func showNetworkError()
}

class HTTPClient: NSObject {
    var delegate: HTTRsponseDelegate?
    
    var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func MakeRequest(parameters:[String:Any], url:String , method: HTTPMethod = .get) {
        
        if !isConnectedToInternet {
             self.delegate?.showNetworkError()
            return
        }
        
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                if let data = response.result.value{
                    self.delegate?.sendResponseData(data: data as! NSDictionary)
                }
                else {
                    self.delegate?.showNetworkError()
                    return
                }
        }
       
    }
   
}
