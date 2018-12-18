//
//  ViewController.swift
//  test
//
//  Created by student on 2018/12/5.
//  Copyright © 2018年 xh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tfname: UITextField!
    
    @IBOutlet weak var tfphone: UITextField!
    
    
    
    
    let appDelegate=UIApplication.shared.delegate as! AppDelegate
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //保存
    override func viewWillDisappear(_ animated: Bool) {
        //  凡是修改了数据库数据的都要savecontext
        appDelegate.saveContext()
    }
    
    @IBAction func add2(_ sender: Any) {
        let person=Person(context: context)
        person.name=tfname.text
        person.phone=tfphone.text
        //和present对应
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func add(_ sender: Any) {
        let person=Person(context: context)
        person.name=tfname.text
        person.phone=tfphone.text
        //和present对应
        dismiss(animated: true, completion: nil)
       
    }
    
    @IBAction func cancel(_ sender: Any) {
         dismiss(animated: true, completion: nil)
        
    }
    @IBAction func update(_ sender: Any) {
        let fetch:NSFetchRequest<Person> = Person.fetchRequest()

        fetch.predicate=NSPredicate(format: "name=%@", tfname.text!)
        let persons=try?context.fetch(fetch)
        if let p=persons?.first{
            p.phone=tfphone.text
        }
        
    }
    
    @IBAction func del(_ sender: Any) {
        //先查询再进行其他操作 除了add
        let fetch:NSFetchRequest<Person> = Person.fetchRequest()
        fetch.predicate=NSPredicate(format: "name=%@", tfname.text!)
        let persons=try?context.fetch(fetch)
        if let p=persons?.first{
            context.delete(p)
        }
    }
    
    @IBAction func query(_ sender: Any) {
        
        let fetch:NSFetchRequest<Person> = Person.fetchRequest()
        fetch.predicate=NSPredicate(format: "name=%@", tfname.text!)
        let persons=try?context.fetch(fetch)// persons 查询得到的结果
        if let p=persons?.first{
            tfphone.text=p.phone
        }
        
    }
}

