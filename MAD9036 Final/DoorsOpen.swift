//
//  DoorsOpen.swift
//  MAD9036 Final
//
//  Created by Ryan Bowes on 2017-12-10.
//  Copyright © 2017 Algonquin College. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    
    func find(header: String) -> String? {
        let keyValues = allHeaderFields.map { (String(describing: $0.key).lowercased(), String(describing: $0.value)) }
        
        if let headerValue = keyValues.filter({ $0.0 == header.lowercased() }).first {
            return headerValue.1
        }
        return nil
    }
    
}

class DoorsOpen {
    var ApiUrl: String =  "https://doors-open-ottawa.mybluemix.net/"
    var instance: DoorsOpen!
    
    enum HTTPStatusCodes: Int {
        // 100 Informational
        case Continue = 100
        case SwitchingProtocols
        case Processing
        // 200 Success
        case OK = 200
        case Created
        case Accepted
        case NonAuthoritativeInformation
        case NoContent
        case ResetContent
        case PartialContent
        case MultiStatus
        case AlreadyReported
        case IMUsed = 226
        // 300 Redirection
        case MultipleChoices = 300
        case MovedPermanently
        case Found
        case SeeOther
        case NotModified
        case UseProxy
        case SwitchProxy
        case TemporaryRedirect
        case PermanentRedirect
        // 400 Client Error
        case BadRequest = 400
        case Unauthorized
        case PaymentRequired
        case Forbidden
        case NotFound
        case MethodNotAllowed
        case NotAcceptable
        case ProxyAuthenticationRequired
        case RequestTimeout
        case Conflict
        case Gone
        case LengthRequired
        case PreconditionFailed
        case PayloadTooLarge
        case URITooLong
        case UnsupportedMediaType
        case RangeNotSatisfiable
        case ExpectationFailed
        case ImATeapot
        case MisdirectedRequest = 421
        case UnprocessableEntity
        case Locked
        case FailedDependency
        case UpgradeRequired = 426
        case PreconditionRequired = 428
        case TooManyRequests
        case RequestHeaderFieldsTooLarge = 431
        case UnavailableForLegalReasons = 451
        // 500 Server Error
        case InternalServerError = 500
        case NotImplemented
        case BadGateway
        case ServiceUnavailable
        case GatewayTimeout
        case HTTPVersionNotSupported
        case VariantAlsoNegotiates
        case InsufficientStorage
        case LoopDetected
        case NotExtended = 510
        case NetworkAuthenticationRequired
        
        public var isInformational:Bool{
            return self.rawValue >= 100 && self.rawValue <= 199
        }
        
        public var isSuccess:Bool{
            return self.rawValue >= 200 && self.rawValue <= 299
        }
        
        public var isRedirection:Bool{
            return self.rawValue >= 300 && self.rawValue <= 399
        }
        
        public var isClientError:Bool{
            return self.rawValue >= 400 && self.rawValue <= 499
        }
        
        public var isServerError:Bool{
            return self.rawValue >= 500 && self.rawValue <= 599
        }
    }
    
    private enum contentType: String {
        case Json = "application/json;"
    }
    
    init () {
        instance = self
    }
    
    func getCleanUrl (url: String) -> String {
        let fullString = ApiUrl + url
        let tempUrl = fullString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return tempUrl!
    }
    
    func handleClientError (error: Error) {
        print(error.localizedDescription)
    }
    
    func handleServerError (error: URLResponse?) {
        let httpResponse = error as? HTTPURLResponse
        let statusCode: String = String(describing: httpResponse?.statusCode)
        print("Site returned status code: " + statusCode)
    }
    
    func getDataSize( urlString: String, completion: ((Int)->Void)? ) {
        let url: URL! = URL(string: getCleanUrl(url: urlString))
        
        let request: URLRequest = URLRequest(url: url)
        
        let session: URLSession = URLSession.shared
    
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                self.handleClientError(error: error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (((response as? HTTPURLResponse)?.statusCode) != nil) else {
                self.handleServerError(error: response)
                return
            }
            
            let status = HTTPStatusCodes.init(rawValue: httpResponse.statusCode)
            // Make sure there's a success
            guard let _ = status?.isSuccess, status?.isSuccess == true else {
                self.handleServerError(error: response)
                return
            }

            if let contentType = httpResponse.find(header: "content-type") {
                let contents = contentType.components(separatedBy: " ")
                
                
            }

            
            //Content-Type: application/json; charset=utf-8

            
        }
        
        task.resume()
    }
    
    func prepareRequest( URLString: String, extra: Any?, completion: ((Data, Any?) -> Void)? ) {
        let url: URL! = URL(string: getCleanUrl(url: URLString))
        
        let request: URLRequest = URLRequest(url: url)
        
        let session: URLSession = URLSession.shared
        
        // Make the specific task from the session by passing in your request
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                return
            }
            
            guard let jsonData = responseData else {
                _ = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                return
            }
            DispatchQueue.main.async {
                completion?(jsonData, extra)
            }
        }
        
        // Tell the task to run
        task.resume()
    }
}
