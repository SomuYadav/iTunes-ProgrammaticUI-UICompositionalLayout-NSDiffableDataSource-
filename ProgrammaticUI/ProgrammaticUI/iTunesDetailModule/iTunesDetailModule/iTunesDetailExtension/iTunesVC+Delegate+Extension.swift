//
//  iTunesDetailVC+Delegate+Extension.swift
//  ProgrammaticUI
//
//  Created by Apple on 19/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit

extension iTunesDetailVC: UICollectionViewDelegate {
    
    /// when scrolling will going on with navigation bar , image will resize wilth nav bar
    /// - Parameter scrollView: it will take scrollview object from collectionview
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeImage(for: height)
    }

     /// it is represting the cell selection 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let rowType = dataSource.itemIdentifier(for: indexPath) else {return}
        
        switch rowType {
        case .saveButton:
            guard let iTunesSongModel = iTunesSongModel else {return}
            let perist = PersistModel(item: iTunesSongModel)
            if isSavedOnline {
                perist.delete()
            }else {
                perist.save()
            }
            snapShot.reloadSections([.actions])
            dataSource.apply(snapShot)
        default: break
        }
    }
}

//MARK: - iTunesSearchVC TableView Delagate(s)
/*
 *
 * didHighlightRowAt to implement cell selection Highlights(s)
 *
 * didUnhighlightRowAt to implement cell selection UnHighlights(s)
 *
 */
extension iTunesDetailVC {
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard indexPath.section != 1, let cell = collectionView.cellForItem(at: indexPath) else {return}
       UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 8, options: .curveEaseInOut, animations: {
           cell.transform = .init(scaleX: 0.9, y: 0.9)
       }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard indexPath.section != 1, let cell = collectionView.cellForItem(at: indexPath) else {return}
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            cell.transform = .identity
        }, completion: nil)
    }
}

extension iTunesDetailVC {
    struct Const {
        /// when you will scroll to bottom then title will large and image will be also large
        static let ImageSizeForLargeState: CGFloat = 40
        /// right anchor or traling of image
        static let ImageRightMargin: CGFloat = 16
        ///bottom margin or bottm from navigation
        static let ImageBottomMarginForLargeState: CGFloat = 12
        /// when you will scroll to top then title will small and image will also be small
        static let ImageBottomMarginForSmallState: CGFloat = 6
        /// maintain small size image
        static let ImageSizeForSmallState: CGFloat = 32
        /// check navbar small size or state  for image
        static let NavBarHeightSmallState: CGFloat = 44
        /// set navbar  for large state
        static let NavBarHeightLargeState: CGFloat = 96.5
       }
    
    /// this resize immage according to navigation bar
    /// - Parameter height: how much needed to image to resize
     func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()

        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState

        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()

        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
    }()
    let xTranslation = max(0, sizeDiff - coeff * sizeDiff)

        self.imageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
}
