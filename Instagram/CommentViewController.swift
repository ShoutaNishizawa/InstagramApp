//
//  CommentViewController.swift
//  Instagram
//
//  Created by coco j on 2018/09/01.
//  Copyright © 2018年 shouta.nishizawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    
    let SCREEN_SIZE = UIScreen.main.bounds.size
    
    var postData: PostData?
    
    @IBAction func postCommentButton(_ sender: Any) {
        

        if let userName = Auth.auth().currentUser?.displayName {
            postData?.commentName.append(userName)
            postData?.comment.append(self.commentTextView.text!)
            
            print("DEBUG_PRINT:" ,postData!.comment, postData!.commentName)
            
            //辞書を作成してFirebaseに保存する
            let postRef = Database.database().reference().child(Const.PostPath).child(postData!.id!)
            
            let commentDic = [ "commentName": postData?.commentName, "comment": postData?.comment]
            postRef.updateChildValues(commentDic)
            
            //HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
            
            print("DEBUG_PRINT: コメント投稿完了")
            
            //全てのモーダルを閉じる
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(CommentViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //ここでUIKeyboardWillShowという名前の通知のイベントをオブザーバー登録をしている
        NotificationCenter.default.addObserver(self, selector: #selector(CommentViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        //ここでUIKeyboardWillHideという名前の通知のイベントをオブザーバー登録をしている
        
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        //テーブルの行の高さをAutoLayoutで自動調整する
        tableView.rowHeight = UITableViewAutomaticDimension
        //テーブル行の高さの概算値を設定しておく
        //高さ概算値 = 「縦横比1:1のUIImageViewの高さ(=画面幅)」+「いいねボタン、キャプションラベル、その他余白の高さの合計概算(=100pt)」
        tableView.estimatedRowHeight = UIScreen.main.bounds.width + 100
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        commentTextView.layer.borderWidth = 1.0   //ボーダーの幅
        commentTextView.layer.cornerRadius = 10.0  //ボーダーの角の丸み
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
    
    //UIKeyboardWillShow通知を受けて、実行される関数
    @objc func keyboardWillShow(_ notification: NSNotification){
        
        let keyboardHeight = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.height
        commentTextView.frame.origin.y = SCREEN_SIZE.height - keyboardHeight - commentTextView.frame.height
    }
    
    
    //UIKeyboardWillShow通知を受けて、実行される関数
    @objc func keyboardWillHide(_ notification: NSNotification){
        
        commentTextView.frame.origin.y = SCREEN_SIZE.height - commentTextView.frame.height - 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        commentTextView.text = "コメントを入力してください"
        commentTextView.textColor = UIColor.lightGray
        commentTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if commentTextView.textColor == UIColor.lightGray {
            commentTextView.text = nil
            commentTextView.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text.isEmpty {
            commentTextView.text = "コメントを入力してください"
            commentTextView.textColor = UIColor.lightGray
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
        
        cell.setPostData(postData!)
        
        return cell
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
