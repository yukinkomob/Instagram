//
//  CommentViewController.swift
//  Instagram
//
//  Created by Yuki Nishimura on 2021/12/18.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentText: UITextField!
    
    var postDataId: String = ""
    
    @IBAction func postComment(_ sender: Any) {
        SVProgressHUD.show()
        
        if (Auth.auth().currentUser?.uid) != nil {
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postDataId)
            let name = Auth.auth().currentUser?.displayName
            let commentData: [String: String?] = ["author": name, "comment": commentText.text]
            postRef.updateData(["comments": FieldValue.arrayUnion([commentData])])
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
        } else {
            SVProgressHUD.showError(withStatus: "投稿が失敗しました")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
