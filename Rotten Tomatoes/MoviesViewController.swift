//
//  MoviesViewController.swift
//  Rotten Tomatoes
//
//  Created by Pankaj Manghnani on 9/14/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var movies:[NSDictionary]?
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string:"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
        
        let request = NSURLRequest(URL:url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            
            self.movies=responseDictionary["movies"] as! [NSDictionary]
            self.tableView.reloadData()
            }
        
        tableView.dataSource=self
        tableView.delegate=self
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.moviecell", forIndexPath: indexPath) as! MovieCell
        let movie = movies![indexPath.row]
        
        cell.titleLabel.text=movie["title"] as? String
        cell.synopsisLabel.text=movie["synopsis"] as? String

        var urlString = movie.valueForKeyPath("posters.thumbnail") as! String
        
        let range = urlString.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            urlString = urlString.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        
        let url=NSURL(string:urlString)!
        
        cell.posterView.setImageWithURL(url)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies=movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell=sender as! UITableViewCell
        let indexPath=tableView.indexPathForCell(cell)!
        let movie=movies![indexPath.row]
        
        let movieDetailViewController=segue.destinationViewController as! MovieDetailViewController
        movieDetailViewController.movie=movie
    }


}
