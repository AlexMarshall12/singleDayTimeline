//
//  DayCollectionViewCell.swift
//  singleDayTimeline
//
//  Created by Alex on 10/1/18.
//  Copyright © 2018 SweatNet. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var arrowImage: UIImageView!

    override var isSelected: Bool{
        didSet{
            arrowImage.isHidden = !isSelected
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        arrowImage.isHidden = true
    }

    override func prepareForReuse() {
        self.backgroundColor = UIColor.clear
    }
    
    func drawMonth(month: String){

    }
    func drawYear(year: Int){

    }

}
