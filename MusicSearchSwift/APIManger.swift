//
//  APIManger.swift
//  MusicSearchSwift
//
//  Created by Yadav, Manish on 2/5/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

import UIKit

class APIManger: NSObject {
    func getTrackForSeacrh(searchStrng:String, completion:@escaping (Any)->Void) {
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        let urlStr = "https://itunes.apple.com/search?term="+searchStrng
        session.dataTask(with: URL.init(string: urlStr)!) { (data, response, err) in
            if let responseData = data{
                DispatchQueue.main.async {
                    completion(responseData)
                }
            }
        }.resume()
    }
    
    func deletmyFunc() -> AnyObject {
        
        return ""  as AnyObject
    }
}
