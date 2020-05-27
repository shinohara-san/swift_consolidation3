//
//  ViewController.swift
//  Consolidation3
//
//  Created by Yuki Shinohara on 2020/05/27.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(eraseItem))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    @objc func addItem(){
        let ac = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        ac.addTextField() //アラートに入力フォーム
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.add(item: item)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func eraseItem(){
       let ac = UIAlertController(title: "削除しますか？", message: nil, preferredStyle: .alert)
//       ac.addAction(UIAlertAction(title: "削除する", style: .default, handler: deleteAll))
        ac.addAction(UIAlertAction(title: "削除する", style: .destructive, handler: {[weak self](UIAlertAction) -> Void in
            self?.items.removeAll()
            self?.tableView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "戻る", style: .cancel, handler: nil))
       present(ac, animated: true)
    }
    
    func add(item: String){
        items.append(item)
        tableView.reloadData()
    }
    
    func deleteAll(){
        items.removeAll()
        tableView.reloadData()
    }
    
}

