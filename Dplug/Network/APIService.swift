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
    
    func signUpEmail(username: String, password: String, email: String, provider: String, avata: String?, completion: @escaping ResponseCompletion, faild: @escaping ResponseFaild) {
        let url = hostAddress + EndPoint.signup.rawValue        
        var param: [String : Any]? = [String : Any]()
        param?["username"] = username
        param?["password"] = password
        param?["email"] = email
        param?["provider"] = provider
        
        if let urlAvata = avata {
            var profile: [String : Any]? = [String : Any]()
            profile?["picture"] = urlAvata
            param?["profile"] = profile
        }
        print("signUpEmail - param : \(String(describing: param))")
        
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { responseData in
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
    
    func uploadImage(paths: URL, completion: @escaping ResponseCompletion) {
        let url = hostAddress + EndPoint.uploadImage.rawValue
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(paths, withName: "image")
        },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        completion(response.value)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
    }
}

//get
extension APIService {
    
    func getCategories(completion: @escaping ResponseCompletion) {
        let url = hostAddress + EndPoint.level1Categories.rawValue + "?level=1"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            print("\(String(describing: response.value))")
            completion(response.value)
        }
    }
}
