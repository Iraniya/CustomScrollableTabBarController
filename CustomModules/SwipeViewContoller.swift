//
//  SwipeViewContoller.swift
//  CustomModules
//
//  Created by Iraniya Naynesh on 16/03/18.
//  Copyright © 2018 Iraniya Naynesh. All rights reserved.
//

import UIKit

class SwipeViewContoller: UIViewController {
    
    var viewControllers = [String]()
     var max = Int.max
    
    @IBOutlet weak var tabBarCollectionView : UICollectionView!
    @IBOutlet weak var tabView: UIView!
    
    let cellNib: UINib = UINib(nibName: "SwipeTabCollectionViewCell", bundle: nil)
    
    override func viewDidLoad() {
        registeingCustomCells()
        viewControllers = ["General","Share","Others"]
        print(max)
        max = 30
        tabBarCollectionView.delegate = self
        tabBarCollectionView.dataSource = self
        self.tabView.setCornerRadius()
    }
    
    private func registeingCustomCells() {
        tabBarCollectionView.register(cellNib, forCellWithReuseIdentifier: "SwipeTabCollectionViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //To start from middle so user can swipe in both direction from starting
//        let indexPath = IndexPath.init(row: max/2, section: 0)
//        tabBarCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
////        [self collectionView:self.dateCollectionView didSelectItemAtIndexPath:indexPathForFirstRow];

    }
}


extension SwipeViewContoller: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return max
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemToShow = viewControllers[indexPath.row % viewControllers.count]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipeTabCollectionViewCell", for: indexPath) as! SwipeTabCollectionViewCell
        cell.title.text = itemToShow
//        if indexPath.item == (max/2)  {
//            max  = max * 2
//            tabBarCollectionView.reloadData()
//        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let itemToShow = viewControllers[indexPath.row % viewControllers.count]
//        
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width/3
        return CGSize(width: width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (max/2)  {
            max  = max * 2
            tabBarCollectionView.reloadData()
        }
    }
}

extension UIView {
    
    func setCornerRadius() {
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 15, height:  15))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
