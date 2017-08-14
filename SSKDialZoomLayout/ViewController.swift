//
//  ViewController.swift
//  SSKDialZoomLayout
//
//  Created by mac on 14/08/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    static let extraSpace :CGFloat = 30
    static let lineSpace :CGFloat = 10
    static let cellsVisible :CGFloat = 3

    @IBOutlet weak var _collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = RotaryFLowLayout()
        layout.needsDial = true
        layout.needsZoom = true
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 90, height: 90)
        _collectionView.collectionViewLayout = layout
        _collectionView.dataSource = self
        _collectionView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.size.width - ViewController.extraSpace) / ViewController.cellsVisible, height: (collectionView.frame.size.width - ViewController.extraSpace) / ViewController.cellsVisible)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let totalCellWidth = (collectionView.frame.size.width - ViewController.extraSpace) / ViewController.cellsVisible
        let totalSpacingWidth = CGFloat(ViewController.lineSpace * (ViewController.cellsVisible)) / 2
        let leftInset = totalSpacingWidth + totalCellWidth
        let rightInset = leftInset
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dCell", for: indexPath) as! DialCell
        if(indexPath.row % 3 == 0){
            cell._imageIcon.image = UIImage(named: "fb")
        }else if(indexPath.row % 3 == 2){
            cell._imageIcon.image = UIImage(named: "camera")
        }else{
            cell._imageIcon.image = UIImage(named: "twitter")
        }
        cell.layer.cornerRadius = 10
        return cell
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            let pageWidth: Float = Float(_collectionView.frame.width / ViewController.cellsVisible)//3 number of visible cell
            // width + space
            let currentOffset: Float = Float(scrollView.contentOffset.x)
            let targetOffset: Float = Float(targetContentOffset.pointee.x)
            var newTargetOffset: Float = 0
            if targetOffset > currentOffset {
                newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
                
            }
            else {
                newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
            }
            if newTargetOffset < 0 {
                newTargetOffset = 0
            }
            else if (newTargetOffset > Float(scrollView.contentSize.width)){
                newTargetOffset = Float(Float(scrollView.contentSize.width))
            }
            
            targetContentOffset.pointee.x = CGFloat(currentOffset)
            scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
    }

}

