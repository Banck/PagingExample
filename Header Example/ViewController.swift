//
//  ViewController.swift
//  Header Example
//
//  Created by Egor Sakhabaev on 31/10/2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import UIKit
import CollectionKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: CollectionView!
    var previousContentOffset: CGPoint = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectionAction = { (context: BasicProvider<String, TitleCell>.TapContext) -> Void in
            print("was selected")
        }
        let data = ["aa", "bb", "cc", "dd"]
        let cellUpdater = { (cell: TitleCell, data: String, index: Int) in
            cell.configure(with: data)
        }
        let viewSource = ClosureViewSource(viewUpdater: cellUpdater)
        let sizeSource = { (index: Int, data: String, collectionSize: CGSize) -> CGSize in
            return CGSize(width: 280, height: 105)
        }

        let provider = BasicProvider<String, TitleCell>(dataSource: ArrayDataSource(data: data),
                                         viewSource: viewSource,
                                         sizeSource: sizeSource,
                                        layout: RowLayout(spacing: 16, justifyContent: .start).inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)),
                                        tapHandler: selectionAction)
        
        collectionView.provider = provider
        collectionView.delegate = self

    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let kMaxIndex: CGFloat = CGFloat(collectionView.provider?.numberOfItems ?? 0) - 1
        let pageSize: CGFloat = 280
        let pageSpacing: CGFloat = 16
        
        let targetX = scrollView.contentOffset.x + velocity.x * 60
        var targetIndex: CGFloat = 0.0
        
        if velocity.x >= 0 {
            targetIndex = ceil(targetX / (pageSize + pageSpacing))
        }
        else {
            targetIndex = floor(targetX / (pageSize + pageSpacing))
        }
        if targetIndex < 0 {
            targetIndex = 0
        }
        if targetIndex > kMaxIndex {
            targetIndex = kMaxIndex;
        }
        
        targetContentOffset.pointee.x = targetIndex * (pageSize + pageSpacing)
        let previousIndex = (previousContentOffset.x / (pageSize + pageSpacing))
        var k: CGFloat = 0.0
        k = (scrollView.contentOffset.x / (pageSize + pageSpacing))
        if k > previousIndex {
            k = k.rounded(.up)
        } else {
            k = k.rounded(.down)
        }
        k = min(max(0, k), kMaxIndex)
        DispatchQueue.main.async {
            scrollView.setContentOffset(CGPoint(x: k * (pageSize + pageSpacing), y: scrollView.contentOffset.y), animated: true)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        previousContentOffset = scrollView.contentOffset
    }

}

