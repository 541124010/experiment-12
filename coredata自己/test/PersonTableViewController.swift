//
//  PersonTableViewController.swift
//  test
//
//  Created by student on 2018/12/5.
//  Copyright © 2018年 xh. All rights reserved.
//

import UIKit
import CoreData

class PersonTableViewController: UITableViewController {
    
    
    //代理需要用到 coredata
    let appDelegate=UIApplication.shared.delegate as! AppDelegate
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    var persons:[Person]?
    
    fileprivate func reloadData(){
      
        let fetch:NSFetchRequest<Person>=Person.fetchRequest()
        //按姓名排序
        fetch.sortDescriptors=[NSSortDescriptor(key: "name", ascending: true)]
        persons=try? context.fetch(fetch)  //此处给persons  赋值  重新查询才会更新数据
        tableView.reloadData() //因为自身就是一个tableview  tableview需要更新数据
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
       reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
         reloadData()
    }
    
    //这是标题
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "this is the title"
    }
    //也可以不写
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let person=persons?[indexPath.row]{
            cell.textLabel?.text=person.name
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.model
        // Pass the selected object to the new view controller.
        //用于传参数共享里类 model   另一个不需要identier因为直接操作数据库
        if segue.identifier=="ShowDetail" {
            let secVC=segue.destination as! DetailViewController
            if  let indexPath=tableView.indexPath(for: sender as! UITableViewCell){
                secVC.person=persons?[indexPath.row]
            }
        }
    }
 

}
