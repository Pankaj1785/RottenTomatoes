//
//  MovieDetailViewController.swift
//  Rotten Tomatoes
//
//  Created by Pankaj Manghnani on 9/14/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var titleLabel: UILabel!
    
    var movie:NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text=movie["title"] as? String
        synopsisLabel.text=movie["synopsis"] as? String
        var urlString = movie.valueForKeyPath("posters.thumbnail") as! String
        
        let range = urlString.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            urlString = urlString.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        
        let url=NSURL(string:urlString)!
        
        imageView.setImageWithURL(url)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
