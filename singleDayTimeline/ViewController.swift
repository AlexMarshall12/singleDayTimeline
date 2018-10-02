//
//  ViewController.swift
//  singleDayTimeline
//
//  Created by Alex on 10/1/18.
//  Copyright © 2018 SweatNet. All rights reserved.
//

import UIKit
let cellIdentifier = "DayCollectionViewCell"
class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var button: UIButton!
    var dates = [Date?]()
    var startDate: Date?
    @IBOutlet weak var daysCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        daysCollectionView.register(UINib.init(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
       
        let allDates = Helper.generateRandomDate(daysBack: 900, numberOf: 10)
        self.dates = allDates.sorted(by: {
            $0!.compare($1!) == .orderedAscending
        })
        startDate = self.dates.first! ?? Date()
        
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 900
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = daysCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DayCollectionViewCell
        
        let cellDate = Calendar.current.date(byAdding: .day, value: indexPath.item, to: self.startDate!)
        
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
        } else {
            print("not me")
            //cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 2, height: daysCollectionView.bounds.size.height/2 )
//    }
    @IBAction func buttonPressed(_ sender: Any) {

        let randomIndex = Int(arc4random_uniform(UInt32(self.dates.count)))
        let randomDate = self.dates[randomIndex]
        let daysFrom = randomDate?.days(from: self.startDate!)
        let indexPath = IndexPath(row: daysFrom!, section: 0)
//        if let cell = daysCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as DayCollectionViewCell? {
//            print("found it")
//        } else {
//            print("didn't find it")
//        }
        daysCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        daysCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

