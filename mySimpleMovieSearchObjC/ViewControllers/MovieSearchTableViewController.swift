//
//  MovieSearchTableViewController.swift
//  mySimpleMovieSearchObjC
//
//  Created by Uzo on 1/31/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController {

    // MARK: - Properties
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        cell.updateCell(withMovie: movie)
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayMovieDetailVC" {
            guard let selectedIndexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? MovieDetailViewController
                else {return }
            let movie = movies[selectedIndexPath.row]
            
            destinationVC.movie = movie
        }
    }
}

extension MovieSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        print(searchTerm)
        
        
        
        MovieController.searchForMovie(usingSearchTerm: searchTerm) { (returnedArrayOfMovies, error) in
            if (error != nil) {
                guard let error = error else { return }
                print("ther was an error retrieving movies: ", error.localizedDescription)
            } else {
                print(returnedArrayOfMovies)
                self.movies = returnedArrayOfMovies
            }
        }
        
        //clear the search field
        searchBar.text = ""
        
        //resign firstresponder statues
        searchBar.resignFirstResponder()
    }
}
