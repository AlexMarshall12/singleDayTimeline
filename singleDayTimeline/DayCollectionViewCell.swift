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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.backgroundColor = UIColor.clear
    }
    
    func drawMonth(month: String){
        
    }
    func drawYear(year: Int){
        
    }
    
    func reloadCell(_ isSelected:Bool){
        arrowImage.isHidden = !isSelected
    }
    
}
