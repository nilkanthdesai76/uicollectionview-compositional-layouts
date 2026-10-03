#if canImport(UIKit)
import UIKit

/// Type-safe helper utilities for managing UICollectionViewDiffableDataSource and snapshots.
@MainActor
public enum DiffableSnapshotHelper {

    /// Applies a list of items to a single section snapshot with optional animation.
    public static func applySnapshot<Section: Hashable, Item: Hashable>(
        dataSource: UICollectionViewDiffableDataSource<Section, Item>,
        section: Section,
        items: [Item],
        animatingDifferences: Bool = true
    ) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    /// Reconfigures existing items in place without full reload animation flicker.
    public static func reconfigureItems<Section: Hashable, Item: Hashable>(
        dataSource: UICollectionViewDiffableDataSource<Section, Item>,
        items: [Item]
    ) {
        var snapshot = dataSource.snapshot()
        if #available(iOS 15.0, tvOS 15.0, *) {
            snapshot.reconfigureItems(items)
        } else {
            snapshot.reloadItems(items)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
#endif
