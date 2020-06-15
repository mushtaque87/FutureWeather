//
//  HttpClient.swift
//  FlaskApp
//
//  Created by Mushtaque Ahmed on 09/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import Foundation

public protocol URLSessioDelegate {
    func dataTask(with url: URL,  completionHandler : @escaping (Data?, URLResponse? , Error?) -> Void) -> URLSessionDataTask
    func dataTask(with request: URLRequest,  completionHandler : @escaping (Data?, URLResponse? , Error?) -> Void) -> URLSessionDataTask
}

class URLSessionMock : URLSessioDelegate {
   
    var url: URL?
    var request: URLRequest?
    var dataTaskMock : URLSessionDataTaskMock
    
    init(with data:Data?  = nil , response: URLResponse? = nil , error:Error? = nil) {
        dataTaskMock = URLSessionDataTaskMock()
        dataTaskMock.taskResponse = (data,response,error)
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = url
        self.dataTaskMock.completionHandler = completionHandler
        return self.dataTaskMock
    }
       
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        self.dataTaskMock.completionHandler = completionHandler
        return self.dataTaskMock
    }
       
    
}

final class URLSessionDataTaskMock : URLSessionDataTask {
    
   
    var taskResponse: (Data?, URLResponse?, Error?)?
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?

    override func resume() {
        self.completionHandler?(taskResponse?.0,taskResponse?.1,taskResponse?.2)
    }
}

extension URLSession: URLSessioDelegate { }

class HttpClient {
     let session : URLSessioDelegate?
    
    required init(session: URLSessioDelegate){
        self.session = session
    }
    
    func get(url:URL, completionClosure: @escaping (_ data : Data? , _ respose : URLResponse? , _ error : Error?) -> Void ) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
           // print(data!)
            completionClosure(data,response,error)
        }
        task.resume()
    }
    
}
