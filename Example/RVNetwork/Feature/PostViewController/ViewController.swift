//
//  ViewController.swift
//  RVNetwork
//
//  Created by 26132769 on 01/22/2023.
//  Copyright © 2022 r.ranjanchn@gmail.com. All rights reserved.
//

import UIKit
import RVNetwork
class ViewController: UIViewController {

    @IBOutlet weak var postTable: UITableView!
    var post : Post? {
        didSet {
            DispatchQueue.main.async {
                self.postTable.reloadData()
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.postTable.dataSource = self
        self.postTable.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        let postRoute = PostRoute()
        let service = RVNetwork.RVServiceRouter()
        
        service.performDataTask(postRoute) { [weak self] (result: Result<Post, RVNetworkingError>) in
            switch  result {
            case .success(let post):
                print(post)
                self?.post = post
            case .failure(let failure):
                print(failure)
            }
        }
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension  ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        cell.postLabel.text = post?[indexPath.row].body

        return cell
    }
}
