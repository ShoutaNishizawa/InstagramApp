//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by coco j on 2018/08/30.
//  Copyright © 2018年 shouta.nishizawa. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var displayComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setPostData(_ postData: PostData) {
        //画像を表示
        self.postImageView.image = postData.image
        
        //キャプションを表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        //コメント数を表示
        let commentNumber = postData.comment.count
        commentLabel.text = "\(commentNumber)"
        
        //日にちを表示
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: postData.date!)
        self.dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        //コメント用のnameとコメント内容を表示
        var text = ""
        for i in 0..<postData.commentName.count {
            text += "\(postData.commentName[i]) : \(postData.comment[i]) \n \n" //次のコメントとの区別がつくように2回改行する
        }
        self.displayComment.text = text
    }
}
