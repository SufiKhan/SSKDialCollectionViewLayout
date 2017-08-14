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


  **Up and down Dial layout**
```
        layout.needsDial = true
        layout.needsZoom = true

```
![dial](https://user-images.githubusercontent.com/13538306/29262880-15b5a45a-80f4-11e7-8ece-772b6505fad5.gif)

**Zoom**

```
        layout.needsDial = false
        layout.needsZoom = true

```

![zoom](https://user-images.githubusercontent.com/13538306/29263227-98024750-80f5-11e7-9e79-a30a798a23bc.gif)

