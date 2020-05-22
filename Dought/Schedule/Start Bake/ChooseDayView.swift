//
//  ChooseDayView.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI
import ASCollectionView_SwiftUI

struct ChooseDayView<Presenting>: View where Presenting: View {
    @Binding var isShowing: Bool
    let presenting: Presenting
    let onCommit: (Date) -> Void
    
    @State private var selectedDate: Date = .tomorrow
    
    
    var body: some View {
//        GeometryReader { geometry in
            ZStack {
                self.presenting
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 20 : 0)
                
                VStack {
                    Text("Choose start date")
                        .font(.title)
                        .fontWeight(.bold)
                    ASCollectionView(data: self.selectedDate.weekAhead, dataID: \.self) { day, _ in
                        Button(action: {
                            self.onCommit(day)
                        }) {
                            Text(day.formatter.weekdayTagName)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.accentColor)
                                .cornerRadius(.infinity)
                        }
                    }
                    .layout {
                        let fl = AlignedFlowLayout()
                        fl.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                        return fl
                    }
                    .shrinkToContentSize(isEnabled: true, dimension: .vertical)
                    
                    Button("Cancel") {
                        withAnimation {
                            self.isShowing.toggle()
                        }
                    }
                }
                .padding()
                .background(Color("cardBackground"))
                .cornerRadius(25)
                .shadow(radius: 7)
                .padding()
                .transition(.slide)
                .opacity(self.isShowing ? 1 : 0)
            }
//        }
    }
}

extension View {
    func chooseDayAlert(isShowing: Binding<Bool>,
                       onCommit: @escaping (Date) -> Void) -> some View {
        ChooseDayView(isShowing: isShowing,
                      presenting: self,
                      onCommit: onCommit)
    }
}

struct StartBakeView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView().chooseDayAlert(isShowing: .constant(true)) { _ in
            // No-op
        }
    }
}

class AlignedFlowLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        attributes?.forEach
            { layoutAttribute in
                guard layoutAttribute.representedElementCategory == .cell else {
                    return
                }
                layoutAttributesForItem(at: layoutAttribute.indexPath).map { layoutAttribute.frame = $0.frame }
        }
        
        return attributes
    }
    
    private var leftEdge: CGFloat {
        guard let insets = collectionView?.adjustedContentInset else {
            return sectionInset.left
        }
        return insets.left + sectionInset.left
    }
    
    private var contentWidth: CGFloat? {
        guard let collectionViewWidth = collectionView?.frame.size.width,
            let insets = collectionView?.adjustedContentInset else {
                return nil
        }
        return collectionViewWidth - insets.left - insets.right - sectionInset.left - sectionInset.right
    }
    
    fileprivate func isFrame(for firstItemAttributes: UICollectionViewLayoutAttributes, inSameLineAsFrameFor secondItemAttributes: UICollectionViewLayoutAttributes) -> Bool {
        guard let lineWidth = contentWidth else {
            return false
        }
        let firstItemFrame = firstItemAttributes.frame
        let lineFrame = CGRect(
            x: leftEdge,
            y: firstItemFrame.origin.y,
            width: lineWidth,
            height: firstItemFrame.size.height)
        return lineFrame.intersects(secondItemAttributes.frame)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }
        guard attributes.representedElementCategory == .cell else {
            return attributes
        }
        guard
            indexPath.item > 0,
            let previousAttributes = layoutAttributesForItem(at: IndexPath(item: indexPath.item - 1, section: indexPath.section))
            else {
                attributes.frame.origin.x = leftEdge // first item of the section should always be left aligned
                return attributes
        }
        
        if isFrame(for: attributes, inSameLineAsFrameFor: previousAttributes) {
            attributes.frame.origin.x = previousAttributes.frame.maxX + minimumInteritemSpacing
        } else {
            attributes.frame.origin.x = leftEdge
        }
        
        return attributes
    }
}
