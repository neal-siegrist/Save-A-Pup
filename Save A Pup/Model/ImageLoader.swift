//
//  ImageLoader.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/9/22.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageLoader: UIImageView {
    
    var currURL: URL?
    
    let loadingWheel: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = UIColor.purple
        return view
    }()
    
    func loadImage(url: URL) {

        self.image = nil
        self.currURL = url
        self.addSubview(loadingWheel)
        
        NSLayoutConstraint.activate([
            loadingWheel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingWheel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        loadingWheel.startAnimating()
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            loadingWheel.stopAnimating()
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if let error = error {
                print("Error occured loading image: \(error.localizedDescription)")
                
                DispatchQueue.main.async {
                    self?.loadingWheel.stopAnimating()
                }
                
                return
            }
            
            DispatchQueue.main.async {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self?.currURL == url {
                        self?.image = imageToCache
                    }
                    
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                }
                
                self?.loadingWheel.stopAnimating()
            }
        }.resume()
    }
}
