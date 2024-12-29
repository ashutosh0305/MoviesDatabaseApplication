//
//  MovieCategoryViewController.swift
//  MovieDataBaseApp
//
//  Created by Ashutosh Bisht on 27/07/24.
//

import UIKit
import AppCenterAnalytics
struct Section {
    let title: MovieCategory
    var items: [Any]
    var isExpanded: Bool
}

enum MovieCategory: String {
    case year = "Year"
    case genre = "Genre"
    case directors = "Directors"
    case actors = "Actors"
    case allMovies = "All Movies"
}

struct FontSizes {
    static let sectionTitle: CGFloat = 18
    static let movieDetail: CGFloat = 16
}

struct RowHeights {
    static let section: CGFloat = 60
    static let movie: CGFloat = 100
    static let defaultRow: CGFloat = 40
}

class MovieCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var tableView: UITableView!
    var searchBar: UISearchBar!
    let viewModel = MoviesViewModel()
    var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getSectionData() {[weak self] sections in
            self?.sections = sections
            self?.tableView.reloadData()
        }
        setupUI()
    }
    
  
    
    private func setupUI() {
        self.title = Constants.Titles.movieDatabase
        
        searchBar = UISearchBar()
        searchBar.placeholder = Constants.Placeholders.searchBar
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.frame.size.height += 10
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellIdentifiers.defaultCell)
        
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        
        setupConstraints()
        
        let nib = UINib(nibName: Constants.NibNames.movieTableViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.CellIdentifiers.movieCell)
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.isExpanded ? section.items.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.defaultCell, for: indexPath)
            cell.textLabel?.text = section.title.rawValue
            cell.textLabel?.textColor = .black
            cell.accessoryView = UIImageView(image: section.isExpanded ? UIImage(systemName: Constants.ImageNames.chevronDown) : UIImage(systemName: Constants.ImageNames.chevronRight))
            cell.accessoryView?.tintColor = .black
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            return cell
        } else if section.title == .allMovies {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.movieCell, for: indexPath) as? MovieTableViewCell else {
                return UITableViewCell()
            }
            if let movieData = section.items[indexPath.row - 1] as? Movie {
                cell.setUpMoviesDataWithUI(movie: movieData)
            }
            cell.accessoryView = UIImageView(image: UIImage(systemName: Constants.ImageNames.chevronRight))
            cell.accessoryView?.tintColor = .lightGray
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.defaultCell, for: indexPath)
            cell.textLabel?.text = section.items[indexPath.row - 1] as? String
            cell.textLabel?.textColor = .darkGray
            cell.textLabel?.font = UIFont.systemFont(ofSize: FontSizes.movieDetail)
            cell.accessoryView = UIImageView(image: UIImage(systemName: Constants.ImageNames.chevronRight))
            cell.accessoryView?.tintColor = .lightGray
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        if indexPath.row == 0 {
            return RowHeights.section
        } else if section.title == .allMovies {
            return RowHeights.movie
        } else {
            return RowHeights.defaultRow
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            var section = sections[indexPath.section]
            section.isExpanded.toggle()
            sections[indexPath.section] = section
            tableView.performBatchUpdates({
                tableView.reloadSections([indexPath.section], with: .automatic)
            }, completion: nil)
        } else {
            let section = sections[indexPath.section]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if section.title == .allMovies {
                if let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
                    viewController.movie = section.items[indexPath.row - 1] as? Movie
                    navigationController?.pushViewController(viewController, animated: true)
                }
            } else {
                if let viewController = storyboard.instantiateViewController(withIdentifier: "MoviesTableViewController") as? MoviesTableViewController {
                    if let filterValue = section.items[indexPath.row - 1] as? String {
                        viewController.items = viewModel.getMoviesByCategory(category: section.title, filterByValue: filterValue)
                        navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterMovies(with: searchText)
        
        if searchText.isEmpty {
            viewModel.getSectionData { [weak self] sections in
                self?.sections = sections
                self?.tableView.reloadData()
            }
        } else {
            sections = [Section(title: .allMovies, items: viewModel.filteredMovies, isExpanded: true)]
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
