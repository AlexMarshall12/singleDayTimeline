//
//  ViewController.swift
//  singleDayTimeline
//
//  Created by Alex on 10/1/18.
//  Copyright © 2018 SweatNet. All rights reserved.
//

import UIKit
import UIKit
let cellIdentifier = "DayCollectionViewCell"
class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var button: UIButton!
    var dates = [Date?]()
    var startDate: Date?
    private var selectedIndexPath: IndexPath?
    
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        daysCollectionView.register(UINib.init(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let allDates = Helper.generateRandomDate(daysBack: 900, numberOf: 10)
        self.dates = allDates.sorted(by: {
            $0!.compare($1!) == .orderedAscending
        })
        startDate = self.dates.first! ?? Date()
        let secondDate = Calendar.current.date(byAdding: .day, value: 10, to: self.startDate!)
        
        self.dates = [self.startDate,secondDate]
    
        
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
    }
    var onceOnly = false
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !onceOnly {
            //let lastDateIndexPath = IndexPath(row: dates.count - 1,section: 0)
            let lastDate = dates.last
            
            let lastDayIndex = lastDate!?.interval(ofComponent: .day, fromDate: startDate!)
            let lastDayCellIndexPath = IndexPath(row: lastDayIndex!, section: 0)
            self.daysCollectionView.scrollToItem(at: lastDayCellIndexPath, at: .left, animated: false)
            self.selectedIndexPath = lastDayCellIndexPath
            //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: singleDayCellReuseIdentifier, for: lastDayCellIndexPath) as! SingleDayCollectionViewCell
            //            cell.arrowImage.isHidden = false
            //self.timeline.reloadSections([0])
            //            if let selectedRow = self.selectedIndexPath {
            //                cell.reloadCell(selectedRow == indexPath)
            //            } else {
            //                cell.reloadCell(false)
            //            }
            onceOnly = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 150
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = daysCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DayCollectionViewCell
        
        let cellDate = Calendar.current.date(byAdding: .day, value: indexPath.item, to: self.startDate!)
        
        if let selectedRow = selectedIndexPath {
            print("SELECTED",selectedRow==selectedIndexPath)
            cell.reloadCell(true)
        } else {
            cell.reloadCell(false)
        }
        
        if Calendar.current.component(.day, from: cellDate!) == 15 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            let monthString = dateFormatter.string(from: cellDate!)
            cell.drawMonth(month: monthString)
        }
        if Calendar.current.component(.day, from: cellDate!) == 1 && Calendar.current.component(.month, from: cellDate!) == 1 {
            print("drawYEAR")
            cell.drawYear(year:Calendar.current.component(.year, from: cellDate!))
        }
        if self.dates.contains(where: { Calendar.current.isDate(cellDate!, inSameDayAs: $0!) }) {
            print("same")
            cell.backgroundColor = UIColor.red
        }
        return cell
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        let randomIndex = Int(arc4random_uniform(UInt32(self.dates.count)))
        let randomDate = self.dates[randomIndex]
        let daysFrom = randomDate?.days(from: self.startDate!)
        let indexPath = IndexPath(row: daysFrom!, section: 0)
        self.selectedIndexPath = indexPath;
        
        //daysCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        daysCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        daysCollectionView.reloadData()
    }
    
}
