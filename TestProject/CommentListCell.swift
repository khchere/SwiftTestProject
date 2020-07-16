//
//  CommentListCell.swift
//  TestProject
//
//  Created by Platform Development on 2020/07/16.
//  Copyright © 2020 Platform Development. All rights reserved.
//

import UIKit

class CommentListCell: UITableViewCell {
   @IBOutlet weak var pImageView: UIImageView!
    @IBOutlet weak var pGradeImg: UIImageView!
    @IBOutlet weak var pNickNameLabel: UILabel!
    @IBOutlet weak var pCommentImageView: UIImageView!
    @IBOutlet weak var pCommentLabel: UILabel!
    @IBOutlet weak var pCommentTextView: UITextView!
    @IBOutlet weak var pTimeLabel: UILabel!
    @IBOutlet weak var pImageWidthConstraints: NSLayoutConstraint!
    @IBOutlet weak var pImageHeightConst: NSLayoutConstraint!
    @IBOutlet weak var pDeleteBtn: UIButton!
    @IBOutlet weak var pDeleteBtnWidthConstraints: NSLayoutConstraint!
}
