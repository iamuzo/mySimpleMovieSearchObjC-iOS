//
//  MovieTableViewCell.swift
//  mySimpleMovieSearchObjC
//
//  Created by Uzo on 1/31/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverViewLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    func updateCell(withMovie movie: Movie?) {

        guard let existingMovie = movie else { return }
        movieTitleLabel.text = existingMovie.title
        movieRatingLabel.text = "Rating: \(existingMovie.rating)"
        movieOverViewLabel.text = "\(existingMovie.overview)"

        MovieController.getImageFor(existingMovie) { (image) in
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    self.moviePosterImageView.image = image
                }
            }
        }
    }
}
