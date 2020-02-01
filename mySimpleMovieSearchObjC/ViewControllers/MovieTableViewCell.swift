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
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    func updateCell(withMovie movie: Movie?) {

        guard let existingMovie = movie else { return }

        MovieController.getImageFor(existingMovie) { (image) in
            guard let returnedImage = image else {return}
            
            DispatchQueue.main.async {
                self.moviePosterImageView.image = returnedImage
            }
        }
        movieTitleLabel.text = existingMovie.title
        movieRatingLabel.text = "Rating: \(existingMovie.rating)"
        movieOverviewLabel.text = "\(existingMovie.overview)"
    }
}
