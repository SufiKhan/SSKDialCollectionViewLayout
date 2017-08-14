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

       **Basic**
```
       layout.needsDial = false
       layout.needsZoom = false

![basic](https://user-images.githubusercontent.com/13538306/29262952-64930a4a-80f4-11e7-8b64-be1ba6dffd9b.gif)
