# horizontal_scroll_view [![Pub](https://img.shields.io/pub/v/horizontal_scroll_view.svg)](https://pub.dartlang.org/packages/horizontal_scroll_view)

A versatile Flutter package for implementing smooth and customizable horizontal scrolling. Perfect for image carousels, product lists, and more. Enhance your app's user experience with fluid and responsive horizontal scroll views across Android, iOS, macOS, Linux, and Windows.

<p align="center">
  <img src="example/screenshots/scroll_demo.webp" alt="Preview Example" height="600">
</p>

## Features
- **Smooth Performance**: Enjoy fluid and responsive horizontal scrolling.
- **Customizable**: Easily adjust item width, spacing, and alignment.
- **Cross-Platform**: Works seamlessly on Android, iOS, macOS, Linux, and Windows.
- **Scroll Control**: Optional `HorizontalScrollViewController` for advanced scroll control.

## Installing

Add to pubspec.yaml file

```yaml
dependencies:
  horizontal_scroll_view: ^0.0.1
```

import

```dart
import 'package:horizontal_scroll_view/horizontal_scroll_view.dart';
```

## Usage

### Using `HorizontalScrollView`

```dart
 HorizontalScrollView(
   itemWidth: 153, // Each Item Width.
   crossAxisSpacing: 8.0, // Spacing between items in the same row.
   alignment: CrossAxisAlignment.center, // Alignment of items within the row (default is center)
   children: [
     // List of child widgets
     // ...
   ],
)
```

### Using `HorizontalScrollView.builder`

If you want to create a horizontal scroll view with dynamic content, use `HorizontalScrollView.builder`. Here`s an example:

```dart
import 'package:horizontal_scroll_view/horizontal_scroll_view.dart';

HorizontalScrollView.builder(
    itemWidth: (16 / 9) * 80, // Each Item Width.
    crossAxisSpacing: 16, // Spacing between items in the same row.
    alignment: CrossAxisAlignment
        .center, // Alignment of items within the row (default is center)
    itemCount: 12, // Total number of items in the list.
    itemBuilder: (BuildContext context, int index) {
        // Create and return the widgets for each item.
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
                height: 80,
                width: (16 / 9) * 80,
                child: Image.network(
                "https://via.placeholder.com/150",
                fit: BoxFit.cover,
                ),
            ),
            ),
            SizedBox(
            height: 2,
            ),
            SizedBox(
            width: (16 / 9) * 80,
            child: Text(
                "Mission Impossible II Breaking the Barrier",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400),
            ),
            ),
        ],
        );
    },
)
```

### Using `HorizontalScrollViewController`
For advanced scroll control, you can use `HorizontalScrollViewController`:

```dart
HorizontalScrollViewController _controller = HorizontalScrollViewController();

HorizontalScrollView(
  controller: _controller,
  // other properties...
);

// To programmatically scroll to a specific item
_controller.scrollToIndex(index);
```
Enhance your Flutter app with horizontal scrolling using `horizontal_scroll_view`. It's simple, powerful, and cross-platform. Give it a try!


## Contribution and Issues

Contributions are welcome! Feel free to open an issue or submit a pull request on [GitHub](https://github.com/Nezent/horizontal_scroll_view).

If you encounter any issues or have suggestions for improvements, please let us know by [reporting a bug](https://github.com/Nezent/horizontal_scroll_view/issues).
