//
//  TrackModel.swift
//  MusicSearchSwift
//
//  Created by Yadav, Manish on 2/5/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

import UIKit

class TrackModel: NSObject {
    var trackName:String?
    var artistName:String?
    var previewURL:String?
    var artworkURL:String?

    func parseResponse(responseDict:NSDictionary) {
        trackName = responseDict.object(forKey: "trackName") as? String
        artistName = responseDict.object(forKey: "artistName") as? String
        previewURL = responseDict.object(forKey: "previewUrl") as? String
        artworkURL = responseDict.object(forKey: "artworkUrl60") as? String
    }
}
