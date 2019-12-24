# Horizontal Picker

You can select your value on Horizontal Picker while scrolling on items.

## Samples

![Horizontal Picker - Sample 1](https://github.com/kaiserleka/horizontal_picker/blob/master/example/samples/sample1.jpg)

![Horizontal Picker - Sample 2](https://github.com/kaiserleka/horizontal_picker/blob/master/example/samples/sample2.jpg)

![Horizontal Picker - Sample 3](https://github.com/kaiserleka/horizontal_picker/blob/master/example/samples/sample3.jpg)

## Installation

Add package to pubspec.yaml
```
dependencies:  
  ...  
  horizontal_picker: ...
```

## Usage Example
```
HorizantalPicker(
  minValue: -10,
  maxValue: 50,
  divisions: 600,
  suffix: " cm",
  showCursor: false,
  backgroundColor: Colors.grey.shade900,
  activeItemTextColor: Colors.white,
  passiveItemsTextColor: Colors.amber,
  onChanged: (value) {},
),
```


