# SSKDialCollectionViewLayout
3 in 1 layout for collection view like Dial with centre zoom ,centre zoom and basic.

        Example
        Dial Layout with Changing sizes
        
        let layout = RotaryFLowLayout()
        layout.needsDial = true
        layout.needsZoom = true
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 90, height: 90)
        _collectionView.collectionViewLayout = layout


