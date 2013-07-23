ImageCache
==========

A shared cache class that loads/saves UIImages from the web to a Key/Value store, and sets UI Elements with the image whenever it's loaded.

## Set Up ##

* Drag the included <code>ImageCache.{h,m}</code> into your project.
* Import <code>ImageCache.h</code> into whatever class you will be loading images in.

## How to Use ##

ImageCache is super, super straightforward and easy to use. Right now it handles two cases for setting UIImages: UIImageView and UIButton. You only need two things here, a UIImageView/UIButton and a URL for an image. To lazily load your image URL into the UIImageView/UIButton without blocking the UI thread, your code will look something like this:

```objc
// Your UIImageView and UIButton
UIImageView *imgView = [[UIImageView alloc] init];
UIButton *btn = [[UIButton alloc] init];

// Your Image URL
NSURL *url = [NSURL URLWithString:@"http://newleaderscouncil.org/sanfrancisco/wp-content/uploads/2013/01/1.jpg"];

// Now Load it!
[imgView setImageFromURL:url];
[btn setImageFromURL:url forState:UIControlStateNormal];
```

And that's it. The ImageCache will check the Cache and pull the UIImage saved in it OR it will go to the web, download the image and set it after it's done downloading.

## License ##

This repository is licensed under the standard MIT License.
