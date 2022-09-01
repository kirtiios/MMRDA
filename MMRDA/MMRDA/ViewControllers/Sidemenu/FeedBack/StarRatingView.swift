//
//  StarRatingView.swift
//
//  Created by Guido on 7/1/20.
//  Copyright © applified.life - All rights reserved.
//

import UIKit
  
public enum StarRounding: Int {
    case roundToHalfStar = 0
    case ceilToHalfStar = 1
    case floorToHalfStar = 2
    case roundToFullStar = 3
    case ceilToFullStar = 4
    case floorToFullStar = 5
}


@IBDesignable
class StarRatingView: UIView {
    
    @IBInspectable var rating: Int = 1 {
        didSet {
            setStarsFor(rating: rating)
        }
    }
    @IBInspectable var starColor: UIColor = UIColor.systemOrange {
        didSet {
            for starImageView in [hstack?.star1ImageView, hstack?.star2ImageView, hstack?.star3ImageView, hstack?.star4ImageView, hstack?.star5ImageView] {
                starImageView?.tintColor = starColor
            }
        }
    }
    

    var starRounding: StarRounding = .roundToHalfStar {
        didSet {
            setStarsFor(rating: rating)
        }
    }
    @IBInspectable var starRoundingRawValue:Int {
        get {
            return self.starRounding.rawValue
        }
        set {
            self.starRounding = StarRounding(rawValue: newValue) ?? .roundToHalfStar
        }
    }
    
    fileprivate var hstack: StarRatingStackView?

    fileprivate let fullStarImage: UIImage = UIImage(named: "starFill")!
    fileprivate let halfStarImage: UIImage = UIImage(named: "starEmpty")!
    fileprivate let emptyStarImage: UIImage = UIImage(named: "starEmpty")!

    
    convenience init(frame: CGRect, rating: Int, color: UIColor, starRounding: StarRounding) {
        self.init(frame: frame)
        self.setupView(rating: rating, color: color, starRounding: starRounding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(rating: self.rating, color: self.starColor, starRounding: self.starRounding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView(rating:1, color: UIColor.systemOrange, starRounding: .roundToHalfStar)
    }
    
    
    fileprivate func setupView(rating: Int, color: UIColor, starRounding: StarRounding) {
        let bundle = Bundle(for: StarRatingStackView.self)
        let nib = UINib(nibName: "StarRatingStackView", bundle: bundle)
        let viewFromNib = nib.instantiate(withOwner: self, options: nil)[0] as! StarRatingStackView
        self.addSubview(viewFromNib)
        
        viewFromNib.translatesAutoresizingMaskIntoConstraints = false
              self.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[v]|",
                    options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                    metrics: nil,
                    views: ["v":viewFromNib]
                 )
              )
              self.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[v]|",
                    options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                    metrics: nil, views: ["v":viewFromNib]
                 )
              )
        
        self.hstack = viewFromNib
        self.rating = Int(rating)
        self.starColor = color
        self.starRounding = starRounding
        
        self.isMultipleTouchEnabled = false
        self.hstack?.isUserInteractionEnabled = false
    }
    
    fileprivate func setStarsFor(rating: Int) {
        let starImageViews = [hstack?.star1ImageView, hstack?.star2ImageView, hstack?.star3ImageView, hstack?.star4ImageView, hstack?.star5ImageView]
        for i in 1...5 {
            let iFloat = (i)
            switch starRounding {
            case .roundToHalfStar:
                starImageViews[i-1]!.image = rating >= iFloat ? fullStarImage : emptyStarImage
            case .ceilToHalfStar:
                starImageViews[i-1]!.image = rating >= iFloat ? fullStarImage : emptyStarImage
            case .floorToHalfStar:
                starImageViews[i-1]!.image = rating >= iFloat ? fullStarImage : emptyStarImage
            case .roundToFullStar:
                starImageViews[i-1]!.image = rating >= iFloat ? fullStarImage : emptyStarImage
            case .ceilToFullStar:
                starImageViews[i-1]!.image = rating > iFloat ? fullStarImage : emptyStarImage
            case .floorToFullStar:
                starImageViews[i-1]!.image = rating >= iFloat ? fullStarImage : emptyStarImage
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
        guard let touch = touches.first else {return}
        touched(touch: touch, moveTouch: false)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touched moved")
        guard let touch = touches.first else {return}
        touched(touch: touch, moveTouch: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touched ended")
        guard let touch = touches.first else {return}
        touched(touch: touch, moveTouch: false)
    }
    
    var lastTouch: Date?
    fileprivate func touched(touch: UITouch, moveTouch: Bool) {
        guard !moveTouch || lastTouch == nil || lastTouch!.timeIntervalSince(Date()) < -0.1 else { return }
        print("processing touch")
        guard let hs = self.hstack else { return }
        let touchX = touch.location(in: hs).x
        let ratingFromTouch = 5*touchX/hs.frame.width
        var roundedRatingFromTouch: Int!
        switch starRounding {
        case .roundToHalfStar, .ceilToHalfStar, .floorToHalfStar:
            roundedRatingFromTouch = Int(round(ratingFromTouch))
        case .roundToFullStar, .ceilToFullStar, .floorToFullStar:
            roundedRatingFromTouch = Int(round(ratingFromTouch))
        }
       self.rating = roundedRatingFromTouch
      
      
        print(self.rating)
        lastTouch = Date()
    }
    
    
    



}
