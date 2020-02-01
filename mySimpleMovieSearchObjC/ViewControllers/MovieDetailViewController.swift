//
//  MovieDetailViewController.swift
//  mySimpleMovieSearchObjC
//
//  Created by Uzo on 1/31/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    var movie: Movie? {
        didSet {
            updateView()
        }
    }

    // MARK: -Outlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Custom Methods
    func updateView() {
        //need to load view else existingMovie == nil
        loadViewIfNeeded()
        
        // unwrap movie safely
        guard let existingMovie = movie else { return }
        
        //use the attibutes you have access to populate view
        title = existingMovie.title
        movieTitleLabel.text = existingMovie.title
        movieOverviewLabel.text = existingMovie.overview
        
        // then fetch the image to display
        MovieController.getImageFor(existingMovie) { (image) in
            DispatchQueue.main.async {
                self.moviePosterImageView.image = image
            }
        }
    }
    
}
