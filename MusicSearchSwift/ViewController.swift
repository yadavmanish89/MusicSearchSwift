//
//  ViewController.swift
//  MusicSearchSwift
//
//  Created by Yadav, Manish on 2/5/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var trackTableView: UITableView!
    var dataArray = [TrackModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadTrack(search: "ABC")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if((searchBar.text?.characters.count)!>2){
            loadTrack(search: searchBar.text!)
        }
    }
    
    func loadTrack(search:String)  {
        let apiManager:APIManger = APIManger.init()
        apiManager.getTrackForSeacrh(searchStrng: search) { (response) in
            
            if let data:NSData = response as? NSData{
                do{
                    let res = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    if let dict:NSDictionary = res as? NSDictionary{
                        if let resultArr:NSArray = dict.object(forKey: "results") as? NSArray{
                            self.dataArray.removeAll()
                            for dictObj in resultArr{
                                let modelObj = TrackModel.init()
                                modelObj.parseResponse(responseDict: (dictObj as? NSDictionary)!)
                                self.dataArray.append(modelObj)
                            }
                            self.trackTableView.reloadData()
                        }
                    }
                }catch{
                    
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TrackTableViewCell
        let modelObj:TrackModel = self.dataArray[indexPath.row]
        cell.trackName.text = modelObj.trackName
        cell.artistName.text = modelObj.artistName
        DispatchQueue.global().async {
            let imgUrl = URL.init(string: modelObj.artworkURL!)
            let data:NSData? = NSData.init(contentsOf: imgUrl!)
            if let imgData = data{
                let image = UIImage.init(data: imgData as Data)
                DispatchQueue.main.async {
                    cell.logoImageView.image = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modelObj:TrackModel = self.dataArray[indexPath.row]
        let urlStr = modelObj.previewURL
        UIApplication.shared.open(URL.init(string: urlStr!)!, options: [:], completionHandler: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
