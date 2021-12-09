//
//  WebRequests.swift
//
//
//  Created by Ahmed on 6/7/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//
//


import UIKit
import Alamofire
import AVFoundation


class WebRequests: NSObject{

    // MARK: - Vars & Lets

    private static var controller: UIViewController?
    private static var headers = [String : String]()
    private static var tokenApi = CurrentUser.userInfo?.token ?? ""
    private var isAuth: Bool = false
    var parameters = [String : Any]()
    var ReqMethod: HTTPMethod = HTTPMethod.get
    var UrlString = ""
    var nestedParams = ""
    public static var DEBUG:Bool{
        #if DEBUG
        return true
        #else
        return false
        #endif
    }


    override init() {}
    static func setup(controller: UIViewController?, headers : [String : String]? = [:]) -> WebRequests {
        if DEBUG{
            print("\r\n---- START OF REQUEST HEADER ----")
        }
        if controller != nil {
            WebRequests.controller = controller
        }else{
            WebRequests.controller = nil
        }

        if DEBUG{
            print("apiToken=\(tokenApi)\r\n")
        }
        // MARK: - Make HTTPHEADERS as API Requsets
        WebRequests.headers["Accept-Language"] = MOLHLanguage.currentAppleLanguage()
        WebRequests.headers["Content"] = "application/x-www-form-urlencoded"
        WebRequests.headers["Content-Type"] = "application/x-www-form-urlencoded"
        if self.headers.count > 0 {
            for (key, value) in self.headers {
                WebRequests.headers[key] = value
                if WebRequests.DEBUG{
                    print("\(key)=\(value)\r\n")
                }
            }
        }

        return WebRequests.init()
    }

    //MARK: - Prepare Start API Request
    func prepare(api :Endpoint,nestedParams: String = "", parameters: [String: Any]? = nil, dataType: DataType = .serialize, isAuthRequired: Bool = true) -> WebRequests {


//        if  CurrentUser.userInfo != nil{
//            WebRequests.tokenApi  = CurrentUser.userInfo?.accessToken ?? ""
//
//        }else{
//            WebRequests.tokenApi  = ""
//
//        }
        if WebRequests.DEBUG{
            print("\r\n\r\n---- START OF REQUEST URL ----")
        }
        self.nestedParams = nestedParams
        self.UrlString = "\(api.values.url)"

        ReqMethod  = api.values.reqeustType
        if WebRequests.DEBUG{
            print(UrlString)
        }
        if isAuthRequired{
            self.isAuth = true
            WebRequests.tokenApi = CurrentUser.userInfo?.token ?? ""
            WebRequests.headers["Authorization"] = "Bearer \(WebRequests.tokenApi)"

        }
        if parameters != nil {
            self.generateParametersForHttpBody(parameters: parameters!, dataType: dataType)
        }

        return self

    }

    //MARK: - Generate Parameters HTTP API Request
    private func generateParametersForHttpBody(parameters: [String: Any]?, dataType: DataType = .serialize) {
        if WebRequests.DEBUG{
            print("\r\n---- START OF REQUEST PARAMETERS ----")
        }
        for (key, value) in parameters! {
            self.parameters[key] = value
            if WebRequests.DEBUG{
                print("\(key)=\(value)\r\n")
            }
        }
    }

    //MARK: - Start API Request
    func start(completion: @escaping ((AFDataResponse<Any>,Error?)->Void)) -> WebRequests? {

        let headers =  HTTPHeaders(WebRequests.headers)
        if WebRequests.controller != nil {
            WebRequests.controller?.showIndicator()
        }
        //MARK: - Check Internet Connection
        guard Reachability.isConnectedToNetwork() else {
            WebRequests.controller?.showAlert(title: messages.alert, message: messages.noIntrentConnection)

            return self
        }
        
        //Encoding URL
        let puplicURl =  self.UrlString + self.nestedParams
        let puplicURlEncodeing = puplicURl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!


        AF.request(puplicURlEncodeing, method: ReqMethod, parameters: self.parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            WebRequests.controller?.hideIndicator()

            if WebRequests.DEBUG{
                print("Status -- \(String(describing: response.response?.statusCode))" + " " + "{\(self.ReqMethod)}" +  " " + "URL:\(puplicURlEncodeing)" )
            }

            switch(response.result){
            case .success(_):
                completion(response,nil)
                do {
                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)

                    //MARK: - HandelError
                    if Status.code != nil && Status.code != 200{
                        switch response.response?.statusCode {
                        case 401:
                            WebRequests.controller?.showOkAlert(withTitle: messages.api, message: "not Authorized", okayButtonCompletionHandler: {
                               // Utility.rootLogin(isNav: false)
                            })
                        default:
//                            WebRequests.controller?.showAlert(title: messages.api, message:"\(Status.message ?? "")")
                            
                            WebRequests.controller?.showOkAlert(withTitle: messages.api, message:"\(Status.message ?? "")")
                        }
                    }else{
                        //MARK: - HandelError with no StatusResult
                        if response.response?.statusCode != 200 {
                            WebRequests.controller?.showAlert(title: messages.api, message:"\(response.error?.localizedDescription ?? "")")
                          
                        }
                        
                    }

                } catch let jsonErr {
                    if WebRequests.DEBUG{
                        print("Error serializing  respone json", jsonErr)
                    }
                }
                if WebRequests.DEBUG{
                    print("Success : \r\n----\(response) ----")
                }
            case .failure(_):
                if response.response?.statusCode != nil{
                    completion(response,response.error)
                }

                if WebRequests.DEBUG{
                    print("Error : \r\n----\(response) ----")
                }
                WebRequests.controller?.showAlert(title: messages.api, message:"\(response.error?.localizedDescription ?? "")")
            }

        }

        return self
    }



    //MARK: ----- Custom multipartFormData Functions -------


    //MARK: Send Single Image

//    static func sendPostMultipartRequestWithImgParam(api :Endpoint,nestedParams :String = "", parameters: [String:String], img: UIImage, withName: String, completion: @escaping ((AFDataResponse<Any>,AFError?)->Void)){
//
//        //MARK: Check Internet Connection
//        guard Reachability.isConnectedToNetwork() else {
//            WebRequests.controller?.showAlert(title: "Alert!", message: "There is no internet connection".localized)
//            return
//        }
//
//        let imageData = img.jpegData(compressionQuality: 0.1)
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: .utf8)!, withName: key)
//            }
//
//            multipartFormData.append(imageData!, withName: withName, fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
//        }, to: api.values.url+nestedParams,method: api.values.reqeustType,
//        headers: ["Authorization": "Bearer \(tokenApi)", "Accept": "application/json"]).uploadProgress(queue: .main, closure: { (progress) in
//            //Current upload progress of file
//            print("Upload Progress: \(progress.fractionCompleted)")
//        }).responseJSON(completionHandler:  { (result) in
//            switch result.result {
//            case .success(_):
//                if let JSON = result.value {
//                    print("JSON: \(JSON)")
//                    completion(result, nil)
//                }else{
//                    completion(result, result.error)
//                    print(result.error?.localizedDescription ?? "" )
//                }
//
//            case .failure(let encodingError):
//                print(encodingError)
//            }
//
//        }
//        )
//    }

    static func sendPostMultipartRequestWithImgParam(api :Endpoint,nestedParams :String = "", parameters: [String:Any], img: UIImage, withName: String, completion: @escaping ((AFDataResponse<Any>,AFError?)->Void)){

        //MARK: Check Internet Connection
        guard Reachability.isConnectedToNetwork() else {
            WebRequests.controller?.showAlert(title: "Alert!", message: "There is no internet connection".localized)
            return
        }

        let imageData = img.jpegData(compressionQuality: 0.1)

        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                     multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                    }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
               // multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
            multipartFormData.append(imageData!, withName: withName, fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
            
        }, to: api.values.url+nestedParams,method: api.values.reqeustType,
        headers: ["Authorization": "Bearer \(CurrentUser.userInfo?.token ?? "")", "Accept": "application/json"]).uploadProgress(queue: .main, closure: { (progress) in
            //Current upload progress of file
            
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler:  { (result) in
            switch result.result {
            case .success(_):
                if let JSON = result.value {
                    print("JSON: \(JSON)")
                    completion(result, nil)
                }else{
                    completion(result, result.error)
                    print(result.error?.localizedDescription ?? "" )
                }

            case .failure(let encodingError):
                print(encodingError)
            }

        }
        )
    }

    //MARK: Send Two Images

    static func sendPostMultipartRequestWith2ImgParam(api :Endpoint,nestedParams :String = "", parameters: [String:String], img: UIImage, withName: String,img2:UIImage,withName2:String, completion: @escaping ((AFDataResponse<Any>,AFError?)->Void)){

        //MARK: Check Internet Connection
        guard Reachability.isConnectedToNetwork() else {
            WebRequests.controller?.showAlert(title: "Alert!", message: "There is no internet connection".localized)
            return
        }

        let imageData = img.jpegData(compressionQuality: 0.1)
        let imageData2 = img2.jpegData(compressionQuality: 0.1)


        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }

            if imageData != nil{
                multipartFormData.append(imageData!, withName: withName, fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
            }
            if imageData2 != nil{
                multipartFormData.append(imageData2!, withName: withName2, fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
            }

        }, to: api.values.url+nestedParams,method: api.values.reqeustType,
        headers: ["Authorization": "Bearer \(tokenApi)", "Accept": "application/json"]).uploadProgress(queue: .main, closure: { (progress) in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler:  { (result) in
            switch result.result {
            case .success(_):
                if let JSON = result.value {
                    print("JSON: \(JSON)")
                    completion(result, nil)
                }else{
                    completion(result, result.error)
                    print(result.error?.localizedDescription ?? "" )
                }

            case .failure(let encodingError):
                print(encodingError)
            }

        }
        )


    }


    //MARK: Send Array Of Images And Image

    static func sendPostMultipartRequestWithMultiImgSParamS(api :Endpoint,nestedParams :String = "", parameters: [String:String], imges: [UIImage], withName: String, img:UIImage,
                                                            imgName:String, completion: @escaping ((AFDataResponse<Any>,AFError?)->Void)){
        //MARK: Check Internet Connection
        guard Reachability.isConnectedToNetwork() else {
            WebRequests.controller?.showAlert(title: "Alert!", message: "There is no internet connection".localized)
            return
        }


        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            let imageProfile = img.jpegData(compressionQuality: 0.4)
            multipartFormData.append(imageProfile!, withName: imgName, fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")

            for i in 0..<imges.count{

                let imageData = imges[i].jpegData(compressionQuality: 0.1)

                multipartFormData.append(imageData!, withName: withName + "[\(i)]", fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
            }
        }, to: api.values.url+nestedParams,method: api.values.reqeustType,
        headers: ["Authorization": "Bearer \(tokenApi)", "Accept": "application/json"]).uploadProgress(queue: .main, closure: { (progress) in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler:  { (result) in
            switch result.result {
            case .success(_):

                if let JSON = result.value {
                    print("JSON: \(JSON)")
                    completion(result, nil)
                }else{
                    completion(result, result.error)
                    print(result.error?.localizedDescription ?? "" )
                }

            case .failure(let encodingError):
                print(encodingError)
            }

        }
        )

    }

    //MARK: Send Array Of Images

    static func sendPostMultipartRequestWithMultiImgs(api :Endpoint,nestedParams :String = "",addImagge :Bool = true, parameters: [String:Any], imges: [UIImage], withName: String, completion: @escaping ((AFDataResponse<Any>,AFError?)->Void)){
        //MARK: Check Internet Connection
        guard Reachability.isConnectedToNetwork() else {
            WebRequests.controller?.showAlert(title: "Alert!", message: "There is no internet connection".localized)
            return
        }


        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                     multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                    }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: .utf8)!, withName: key)
//            }
            if addImagge{
                for i in 0..<imges.count{
                    let imageData = imges[i].jpegData(compressionQuality: 0.1)
                    multipartFormData.append(imageData!, withName: withName + "[\(i)]", fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
                    
                }
            }
        }, to: api.values.url+nestedParams,method: api.values.reqeustType,
        headers: ["Authorization": "Bearer \(tokenApi)", "Accept": "application/json"]).uploadProgress(queue: .main, closure: { (progress) in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler:  { (result) in
            switch result.result {
            case .success(_):

                if let JSON = result.value {
                    print("JSON: \(JSON)")
                    completion(result, nil)
                }else{
                    completion(result, result.error)
                    print(result.error?.localizedDescription ?? "" )
                }

            case .failure(let encodingError):
                print(encodingError)
            }

        }
        )

    }


    //MARK: Send Two Files Of Array Images And One Image And One Video

    static func sendPostMultipartWithImagesAndVideo(api :Endpoint,nestedParams :String = "",
                                                    parameters: [String:String],
                                                    imgsFileOne: [UIImage],
                                                    withFileOneName: String,
                                                    imgsFileTwo: [UIImage],
                                                    withFileTwoName: String,
                                                    img:UIImage,
                                                    imgName:String,
                                                    video:Data?,
                                                    completion: @escaping ((AFDataResponse<Any>,AFError?)->Void)){
        //MARK: Check Internet Connection
        guard Reachability.isConnectedToNetwork() else {
            WebRequests.controller?.showAlert(title: "Alert!", message: "There is no internet connection".localized)
            return
        }


        var imagesJobsData: [Data] = []
        var imagesCertificatesData: [Data] = []

        for i in imgsFileOne{
            let imageData = i.jpegData(compressionQuality: 0.5)
            imagesJobsData.append(imageData!)
        }

        for i in imgsFileTwo{
            let imageData = i.jpegData(compressionQuality: 0.5)
            imagesCertificatesData.append(imageData!)
        }

        AF.upload(multipartFormData: { (multipartFormData) in
            var Jobsindx: Int = 0
            for imageData in imagesJobsData {
                multipartFormData.append(imageData, withName: "\(imgsFileOne)[\(Jobsindx)]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                Jobsindx += 1
            }

            var CertificatesIndx: Int = 0
            for imageData in imagesCertificatesData {
                multipartFormData.append(imageData, withName: "\(withFileTwoName)[\(CertificatesIndx)]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                CertificatesIndx += 1
            }

            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)

            }

            let imageProfile = img.jpegData(compressionQuality: 0.4)

            multipartFormData.append(imageProfile!, withName: imgName, fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")

            if let videoData = video{
                multipartFormData.append(videoData, withName: "video", fileName: "video.mp4", mimeType: "video/mp4")
            }

        }, to: api.values.url+nestedParams,method: api.values.reqeustType,
        headers: ["Authorization": "Bearer " + "\(tokenApi)", "Accept": "application/json", "Content-Type": "application/x-www-form-urlencoded"])
        //    ,"Accept-Language": Language.currentLanguage()])
        .uploadProgress(queue: .main, closure: { (progress) in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler:  { (result) in
            switch result.result {
            case .success(_):

                if let JSON = result.value {
                    print("JSON: \(JSON)")
                    completion(result, nil)
                }else{
                    completion(result, result.error)
                    print(result.error?.localizedDescription ?? "" )
                }

            case .failure(let encodingError):
                print(encodingError)
            }

        }
        )
    }

    //MARK: Send Single Video

    static func sendPostMultipartRequestWithVideoaram(api :Endpoint,nestedParams :String = "", parameters: [String:String], video: URL?, withName: String, completion: @escaping ((AFDataResponse<Any>,AFError?)->Void)){

        //MARK: Check Internet Connection
        guard Reachability.isConnectedToNetwork() else {
            WebRequests.controller?.showAlert(title: "Alert!", message: "There is no internet connection".localized)
            return
        }

        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }

            if video != nil{

                multipartFormData.append(video!, withName: withName, fileName: "video_\(Date().toMillis() ?? 0).mp4", mimeType: "video/mp4")
                let asset = AVURLAsset(url: video!)
                let generator = AVAssetImageGenerator(asset: asset)
                generator.appliesPreferredTrackTransform = true
                let timestamp = CMTime(seconds: 5, preferredTimescale: 60)
                if let imageRef = try? generator.copyCGImage(at: timestamp, actualTime: nil) {
                    let imageData = UIImage(cgImage: imageRef).jpegData(compressionQuality: 0.1)
                    multipartFormData.append(imageData!, withName: "thumbnail", fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
                }

            }
        }, to: api.values.url+nestedParams,method: api.values.reqeustType,
        headers: ["Authorization": "Bearer \(tokenApi)", "Accept": "application/json", "Content-Type": "application/json"])
        .uploadProgress(queue: .main, closure: { (progress) in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler:  { (result) in
            switch result.result {
            case .success(_):

                if let JSON = result.value {
                    print("JSON: \(JSON)")
                    completion(result, nil)
                }else{
                    completion(result, result.error)
                    print(result.error?.localizedDescription ?? "" )
                }

            case .failure(let encodingError):
                print(encodingError)
            }

        }
        )

    }

    //MARK: Send  Single Image  And  Single Video


    static func sendPostMultipartRequestParam(api :Endpoint,nestedParams :String = "", parameters: [String:String], img: UIImage, withName: String, video: URL?, VideoWithName: String, completion: @escaping ((AFDataResponse<Any>,AFError?)->Void)){

        //MARK: Check Internet Connection
        guard Reachability.isConnectedToNetwork() else {
            WebRequests.controller?.showAlert(title: "Alert!".localized, message: "There is no internet connection".localized)
            return
        }

        let imageData = img.jpegData(compressionQuality: 0.1)


        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            if imageData != nil{

                multipartFormData.append(imageData!, withName: withName, fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
            }
            if video != nil{

                multipartFormData.append(video!, withName: VideoWithName, fileName: "video_\(Date().toMillis() ?? 0).mp4", mimeType: "video/mp4")
                let asset = AVURLAsset(url: video!)
                let generator = AVAssetImageGenerator(asset: asset)
                generator.appliesPreferredTrackTransform = true
                let timestamp = CMTime(seconds: 5, preferredTimescale: 60)
                if let imageRef = try? generator.copyCGImage(at: timestamp, actualTime: nil) {
                    let imageData = UIImage(cgImage: imageRef).jpegData(compressionQuality: 0.1)
                    multipartFormData.append(imageData!, withName: "thumbnail", fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")

                }



            }
        }, to: api.values.url+nestedParams,method: api.values.reqeustType,
        headers: ["Authorization": "Bearer \(tokenApi)", "Accept": "application/json", "Content-Type": "application/json"])
        .uploadProgress(queue: .main, closure: { (progress) in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler:  { (result) in
            switch result.result {
            case .success(_):

                if let JSON = result.value {
                    print("JSON: \(JSON)")
                    completion(result, nil)
                }else{
                    completion(result, result.error)
                    print(result.error?.localizedDescription ?? "" )
                }


            case .failure(let encodingError):
                print(encodingError)
            }

        }
        )

    }

    //MARK: Send  Document  And  Video

    static func sendPostDocument(api :Endpoint,nestedParams :String = "", parameters: [String:String], img: URL, withName: String, video: URL?, VideoWithName: String, SkipFile: Bool, completion: @escaping ((AFDataResponse<Any>,AFError?)->Void)){

        //MARK: Check Internet Connection
        guard Reachability.isConnectedToNetwork() else {
            WebRequests.controller?.showAlert(title: "Alert!", message: "There is no internet connection".localized)
            return
        }

        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            if !SkipFile{

                multipartFormData.append(img, withName: withName, fileName: "fff\(Date().toMillis() ?? 0).pdf", mimeType: "application/pdf")
                if video != nil{

                    multipartFormData.append(video!, withName: VideoWithName, fileName: "video_\(Date().toMillis() ?? 0).mp4", mimeType: "video/mp4")
                    let asset = AVURLAsset(url: video!)
                    let generator = AVAssetImageGenerator(asset: asset)
                    generator.appliesPreferredTrackTransform = true
                    let timestamp = CMTime(seconds: 5, preferredTimescale: 60)
                    if let imageRef = try? generator.copyCGImage(at: timestamp, actualTime: nil) {
                        let imageData = UIImage(cgImage: imageRef).jpegData(compressionQuality: 0.1)
                        multipartFormData.append(imageData!, withName: "thumbnail", fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")

                    }




                    let duration = asset.duration.seconds
                    multipartFormData.append(duration.description.data(using: .utf8)!, withName: "duration")

                }


            }
        }, to: api.values.url+nestedParams,method: api.values.reqeustType,
        headers: ["Authorization": "Bearer \(tokenApi)", "Accept": "application/json", "Content-Type": "application/json"])
        .uploadProgress(queue: .main, closure: { (progress) in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler:  { (result) in
            switch result.result {
            case .success(_):

                if let JSON = result.value {
                    print("JSON: \(JSON)")
                    completion(result, nil)
                }else{
                    completion(result, result.error)
                    print(result.error?.localizedDescription ?? "" )
                }

            case .failure(let encodingError):
                print(encodingError)
            }

        }
        )

    }


}

