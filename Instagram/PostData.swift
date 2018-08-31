//
//  PostData.swift
//  Instagram
//
//  Created by coco j on 2018/08/30.
//  Copyright © 2018年 shouta.nishizawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLinked: Bool = false
    
    init(snapshot: DataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        imageString = (valueDictionary["image"] as? String)
        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
        
        self.name = valueDictionary["name"] as? String
        
        self.caption = valueDictionary["caption"] as? String
        
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        //likesのキー配列中に、myIdとself.likesキーと一致しているか調べ、一致していたらisLikkedをtrueにする
        for likeId in self.likes {
            if likeId == myId {
                self.isLinked = true
                break
            }
        }
        
    }
    
    

}
