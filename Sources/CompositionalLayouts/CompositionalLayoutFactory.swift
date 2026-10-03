#if canImport(UIKit)
import UIKit

/// Factory creating battle-tested UICollectionViewCompositionalLayout recipes.
@MainActor
public enum CompositionalLayoutFactory {

    /// Instagram-style explore grid: alternating 2/3 tall feature item + 2 stacked 1/3 small items.
    public static func makeInstagramExploreLayout(spacing: CGFloat = 2) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            // Small item (takes full height of stacked pair)
            let smallItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.5)
                )
            )
            smallItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

            // Pair of small items stacked vertically
            let smallStackedGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0 / 3.0),
                    heightDimension: .fractionalHeight(1.0)
                ),
                repeatingSubitem: smallItem,
                count: 2
            )

            // Large feature item (takes 2/3 width, full group height)
            let largeItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(2.0 / 3.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            largeItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

            // Main group: Large on left, stacked pair on right
            let mainGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(2.0 / 3.0)
                ),
                subitems: [largeItem, smallStackedGroup]
            )

            let section = NSCollectionLayoutSection(group: mainGroup)
            return section
        }
        return layout
    }

    /// Horizontal scrolling carousel shelf with peek and page snapping.
    public static func makeCarouselShelfLayout(
        itemWidthFraction: CGFloat = 0.8,
        itemHeight: CGFloat = 220,
        spacing: CGFloat = 12
    ) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemWidthFraction),
                    heightDimension: .absolute(itemHeight)
                ),
                subitems: [item]
            )
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing / 2, bottom: 0, trailing: spacing / 2)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
            return section
        }
        return layout
    }

    /// Adaptive photo gallery grid with consistent aspect ratio.
    public static func makePhotoGrid(columns: Int = 3, spacing: CGFloat = 2) -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / CGFloat(columns)),
            heightDimension: .fractionalWidth(1.0 / CGFloat(columns))
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0 / CGFloat(columns))
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: columns)

        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
#endif
