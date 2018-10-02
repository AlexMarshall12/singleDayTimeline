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
        arrowImage.isHidden = true
        // Initialization code
    }
    
    func clearArrow(){
        arrowImage.isHidden = true
    }
    
    func drawArrow(){
        print("draw arrow")
        arrowImage.isHidden = false
    }
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
               self.drawArrow()
            }
            else
            {
                self.clearArrow()
            }
        }
    }
    
    func drawMonth(month: String){

    }
    func drawYear(year: Int){

    }

}
