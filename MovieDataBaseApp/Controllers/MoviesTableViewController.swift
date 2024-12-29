//
//  MoviesTableViewController.swift
//  MovieDataBaseApp
//
//  Created by Ashutosh Bisht on 27/07/24.
//

import UIKit
import AppCenterCrashes

class MoviesTableViewController: UITableViewController {
    var items: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "movieCell")
        Crashes.generateTestCrash()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .black
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movieData = items[indexPath.row]
        cell.setUpMoviesDataWithUI(movie: movieData)
        cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
        cell.accessoryView?.tintColor = .lightGray
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tableViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
            return
        }
        tableViewController.movie = items[indexPath.row]
        navigationController?.pushViewController(tableViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
