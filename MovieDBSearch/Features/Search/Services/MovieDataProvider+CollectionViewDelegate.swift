//
//  MovieDataProvider+CollectionViewDelegate.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDelegate
extension MovieDataProvider {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        fetchNextPage()
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension MovieDataProvider: UICollectionViewDelegateFlowLayout  {
    
    private var itemsPerRow: Int { return 1 }
    private var sectionInsets: UIEdgeInsets { return UIEdgeInsetsMake(0, 8, 0, 8) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        var cellHeight: CGFloat!
        if(!shouldShowLoadingCell) {
            let height = heightForItem(at: indexPath, view: collectionView)
            let posterImageHeight: CGFloat = 100.0
            cellHeight = height < posterImageHeight ? 120 : height
        } else {
            cellHeight = 80
        }
        print(cellHeight)
        
        return CGSize(width: widthPerItem, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    private func heightForItem(at indexPath: IndexPath, view: UIView) -> CGFloat {
        let movie = movies[indexPath.item]
        let titleTextRect = rect(for: movie.name, font: Theme.Fonts.avenirNextMedium(size: 18).value, view: view)
        let releaseDateTextRect = rect(for: movie.releaseDate, font: Theme.Fonts.avenirNextMedium(size: 14).value, view: view)
        let overviewTextRect = rect(for: movie.overview, font: Theme.Fonts.avenirNextMedium(size: 14).value, view: view)
        let totalHeight = titleTextRect.height + releaseDateTextRect.height + overviewTextRect.height + 50
        return totalHeight
    }
    
    private func rect(for text: String, font: UIFont, view: UIView) -> CGRect {
        return NSString(string: text).boundingRect(with: CGSize(width: view.frame.width, height: 1000),
                                                   options: [.usesFontLeading, .usesLineFragmentOrigin],
                                                   attributes: [NSAttributedStringKey.font: font],
                                                   context: nil)
    }
}
