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
    var endDate: Date?
    private var selectedIndexPath: IndexPath?
    
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        daysCollectionView.register(UINib.init(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let allDates = Helper.generateRandomDate(daysBack: 900, numberOf: 10)
        self.dates = allDates.sorted(by: {
            $0!.compare($1!) == .orderedAscending
        })
        self.startDate = Calendar.current.startOfDay(for: dates.first as! Date)
        
        self.endDate = dates.last!
        self.dates = Array(dates.suffix(from: 8))
        print(self.dates)
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
            //self.daysCollectionView.reloadData()
            onceOnly = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let days = self.endDate!.days(from: self.startDate!)
        if days <= 150 {
            return 150
        } else {
            print(days,"days")
            return days + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = daysCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DayCollectionViewCell
        
        let cellDate = Calendar.current.date(byAdding: .day, value: indexPath.item, to: self.startDate!)
        
        if let selectedRow = selectedIndexPath {
            cell.reloadCell(selectedRow==indexPath)
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
        //cell.backgroundColor = UIColor.blue
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
