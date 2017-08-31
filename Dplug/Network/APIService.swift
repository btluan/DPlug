//
//  APIService.swift
//  Dplug
//
//  Created by Lan Tran on 8/14/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit
import Alamofire

class APIService: NSObject {
    let hostAddress = "https://api.travelrey.com"
    static let shareInstance = APIService()
    typealias ResponseCompletion = ((_ data: Any?) -> Void)
    typealias ResponseFaild = ((_ message: String) -> Void)
}

extension APIService {
    
    func requestPost(param: [String:Any], url: String, completion: @escaping ResponseCompletion, faild: @escaping ResponseFaild) {
        
    }
    
    func requestGet(url: String, completion: @escaping ResponseCompletion) {
        //TODO
    }
    
    func requestPostWithAuth(header: HTTPHeaders, param: [String:Any], url: String, completion: @escaping ResponseCompletion) {
        //TODO
    }
    
    func requestGetWithAuth(header: HTTPHeaders, url: String, completion: @escaping ResponseCompletion) {
        //TODO
    }
}

//Post
extension APIService {
    
    func signUpEmail(username: String, password: String, email: String, provider: String, completion: @escaping ResponseCompletion, faild: @escaping ResponseFaild) {
        let url = hostAddress + EndPoint.signup.rawValue
        print("signUpEmail - Url : \(url)")
        
        var param: [String : Any]? = [String : Any]()
        param?["username"] = username
        param?["password"] = password
        param?["email"] = email
        param?["provider"] = provider
        print("signUpEmail - param : \(String(describing: param))")
        
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { responseData in
            print("signUpEmail - response : \(responseData.result), - error : \(String(describing: responseData.result.error))")
            let result = responseData.result.value as Any
            guard let data = result as? NSDictionary else {
                faild("Connect Faild")
                return
            }
            
            if data["isActive"] != nil {
                completion(responseData.result)
            } else {
                if let message = data["message"] as? String {
                    faild(message)
                } else {
                    faild("Unknow Message")
                }
            }
        }
    }
    
    func signInEmail(username: String, password: String, completion: @escaping ResponseCompletion, faild: @escaping ResponseFaild) {
        let url = hostAddress + EndPoint.signin.rawValue
        var param: [String : Any]? = [String : Any]()
        param?["username"] = username
        param?["password"] = password
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { responseData in
            print("signInEmail - response : \(responseData.result), - error : \(String(describing: responseData.result.error))")
            let result = responseData.result.value as Any
            guard let data = result as? NSDictionary else {
                faild("Connect Faild")
                return
            }
            if data["token"] != nil {
                completion(responseData.result.value)
            } else {
                if let message = data["message"] as? String {
                    faild(message)
                } else {
                    faild("Unknow Message")
                }

            }
        }
    }
    
    func uploadImage(paths: URL) {
        let url = hostAddress + EndPoint.uploadImage.rawValue
        print("url: \(url)")
        print("paths: \(paths)")
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(paths, withName: "image")
                //multipartFormData.append(rainbowImageURL, withName: "rainbow")
        },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print("\(response.value)")
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
        /*
        Alamofire.upload(paths, to: url).responseJSON { response in
            //debugPrint(response)
            print("-----")

            print("\(response)")
        }*/
    }
}
