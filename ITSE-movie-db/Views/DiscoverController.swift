//
//  DiscoverController.swift
//  ITSE-movie-db
//
//  Created by Mason Phillips on 4/14/22.
//

import UIKit

class DiscoverController: UIViewController {
    @IBOutlet weak var table: UITableView!
    
    var source: Array<DiscoverMovieResponse> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "itemCell")
        
        API.shared.getDiscoverMovies { response, error in
            if let response = response {
                self.source = response.results
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            } else if let error = error {
                print(error)
            } else {
                print("no response")
            }
        }
    }
}

extension DiscoverController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = source[indexPath.row].title
        return cell
    }
}
