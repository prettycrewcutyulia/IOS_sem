//
//  ViewController.swift
//  practice_4
//
//  Created by Юлия Гудошникова on 10.10.2023.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var scroll: UIScrollView!

    var images: [UIImage] = [
        UIImage(named: "image1.png")!,
        UIImage(named: "image2.png")!,
        UIImage(named: "image3.png")!,
        UIImage(named: "image4.png")!,
        UIImage(named: "image5.png")!,
        UIImage(named: "image6.png")!,
        UIImage(named: "image7.png")!,
        UIImage(named: "image8.png")!,
        UIImage(named: "image9.png")!,
        UIImage(named: "image10.png")!
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        scroll = UIScrollView()
        view.addSubview(scroll)
        scroll.delegate = self
        

        for image in images {
            let imageView = UIImageView(image: image)
            scroll.addSubview(imageView)
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnImage))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scroll.frame = view.bounds
        var i = 0
        scroll.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            if i == 0 {
                NSLayoutConstraint.activate([
                    $0.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
                    $0.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 40),
                    $0.heightAnchor.constraint(equalToConstant: 100),
                    $0.widthAnchor.constraint(equalToConstant: 100)
                ])
            } else {
                NSLayoutConstraint.activate([
                    $0.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
                    $0.topAnchor.constraint(equalTo: scroll.subviews[i - 1].bottomAnchor, constant: 40),
                    $0.heightAnchor.constraint(equalToConstant: 100),
                    $0.widthAnchor.constraint(equalToConstant: 100)
                ])
            }
            if (i == images.count - 1) {
                NSLayoutConstraint.activate([
                    $0.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -40),
                ])
            }
            i = i + 1
        }
    }

     // Обработчик прокрутки для реализации бесконечного скролла
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let contentHeight = scrollView.contentSize.height
            let yOffset = scrollView.contentOffset.y
            let pageHeight = view.frame.size.height

            if yOffset < 0 {
                // Перемещение на начало, перейдите к последнему элементу
                scrollView.setContentOffset(CGPoint(x: 0, y: contentHeight - pageHeight), animated: false)
            
            } else if yOffset > contentHeight - pageHeight {
                // Перемещение в конец, перейдите к первому элементу
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        }
    
    @objc func tapOnImage(tapGestureRecognizer: UITapGestureRecognizer) {
       let tappedImage = tapGestureRecognizer.view as! UIImageView
              
        // Выполнение перехода к другому view controller
        self.navigationController?.pushViewController(Zoom(image: tappedImage.image!), animated: false)
    }

}

