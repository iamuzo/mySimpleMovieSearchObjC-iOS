//
//  MovieDetailViewController.swift
//  mySimpleMovieSearchObjC
//
//  Created by Uzo on 1/31/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie: Movie? {
        didSet {
            updateView()
        }
    }

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateView() {
        guard let movie = movie else { return }
        
        movieTitleLabel.text = movie.title
    }
    
}
