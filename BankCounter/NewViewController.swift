 //
//  NewViewController.swift
//  BankCounter
//
//  Created by anny on 2020/12/12.
//

import UIKit

class NewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var waitingsLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var myTable: UITableView!
    
    // *** 請在這裡更改！ ***
    var nameArray = ["Amy", "Bob", "Cory", "Dora", "Falu"] // 修改“櫃員名稱”
    var processingArray = Array(repeating: 0, count: 5)    // 修改“處理進行”數量
    var processedArray = Array(repeating: "", count: 5)    // 修改“已處理完成”數量
    // *** 請在這裡更改！ ***
    
    var count = 1
    var waitingQueue = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.dataSource = self
        myTable.delegate = self
        
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 10
        
        let currentQueue: DispatchQueue = DispatchQueue(label: "CorrentQueue", attributes: .concurrent)
        currentQueue.async {
            while true{
                if self.waitingQueue.count > 0 {
                    for i in 0...self.nameArray.count - 1{
                        if self.processingArray[i] == 0 && self.waitingQueue.count > 0{
                            self.process_delay(Item: i)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.waitingsLabel.text = "waitings: \(self.waitingQueue.count)"
                }
            }
        }
    }
    
    func process_delay(Item: Int){
        processingArray[Item] = waitingQueue[0]
        waitingQueue.remove(at: 0)
        DispatchQueue.main.async {
            self.myTable.reloadData()
            self.waitingsLabel.text = "waitings: \(self.waitingQueue.count)"
        }
        let globalQueue = DispatchQueue.global()
        // 修改處理秒數
        let sec = Double.random(in: 1...5)
        
        globalQueue.asyncAfter(deadline: .now() + sec) {
            print("處理進行 \(sec) 秒")
            self.processedArray[Item] += "\(self.processingArray[Item]), "
            DispatchQueue.main.async {
                self.myTable.reloadData()
            }
            self.processingArray[Item] = 0
        }
    }
    
    @IBAction func nextOne(_ sender: Any) {
        waitingQueue.append(count)
        count += 1
        nextButton.setTitle("Next \(count)", for: .normal)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BankTableViewCell
        
        cell.name.text = nameArray[indexPath.row]
        if processingArray[indexPath.row] > 0 {
            cell.processing.text = "\(processingArray[indexPath.row])"
        }else{
            cell.processing.text = "idle"
        }
        cell.processed.text = processedArray[indexPath.row]
        
        return cell
    }
}
