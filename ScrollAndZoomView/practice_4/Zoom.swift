//
//  Zoom.swift
//  practice_4
//
//  Created by Юлия Гудошникова on 10.10.2023.
//

import UIKit

class Zoom: UIViewController, UIScrollViewDelegate {
    
    var image:UIImageView!
    var scroll: UIScrollView!
    
    init(image: UIImage) {
            super.init(nibName: nil, bundle: nil)
        self.image = UIImageView(image:image)
           
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white;
        scroll = UIScrollView()
        view.addSubview(scroll)
        scroll.addSubview(image)
        scroll.minimumZoomScale = 1.0
        scroll.maximumZoomScale = 6.0
        scroll.delegate = self
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scroll.frame = view.bounds
        image.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            image.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            image.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
            image.heightAnchor.constraint(equalTo: scroll.frameLayoutGuide.heightAnchor),
        ])
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return image
    }

}
