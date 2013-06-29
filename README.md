ImageCache
==========

A shared cache class that loads/saves UIImages from the web to a Key/Value store, and sets UI Elements with the image whenever it's loaded.

## Set Up ##

* Drag the included <code>ImageCache.{h,m}</code> into your project.
* Import <code>ImageCache.h</code> into whatever class you will be loading images in.

## How to Use ##

ImageCache is super, super straightforward and easy to use. Right now it handles two cases for setting UIImages: UIImageView and UITableView. Follow along for loading your images.

**UIImageView**

You only need two things here, a UIImageView and a URL for an image. To lazily load your image URL into the UIImageView without blocking the UI thread, your code will look something like this:

```objc
// Your Image View
UIImageView *imgView;

// Your Image URL
NSURL *url = [NSURL URLWithString:@"http://newleaderscouncil.org/sanfrancisco/wp-content/uploads/2013/01/1.jpg"];

// Loading that URL into your imgView
[[ImageCache sharedCache] setImageAtURL:[NSURL URLWithString:@"http://newleaderscouncil.org/sanfrancisco/wp-content/uploads/2013/01/1.jpg"] forUIElement:imgView];
```

And that's it. The ImageCache will check the Cache and pull the UIImage saved in it OR it will go to the web, download the image and set it after it's done downloading.

** UITableView**

Since UITableViews are a little bit different paradigm than a static UIImageView, this is a little bit different as well. In your <code>tableView:cellForRowAtIndexPath:</code> method where you have an image you want to portray, set up your code similar to this:

```objc
cell.imageView.image = [[ImageCache sharedCache] imageForURLPath:@"http://newleaderscouncil.org/sanfrancisco/wp-content/uploads/2013/01/1.jpg"];
[[ImageCache sharedCache] setImageAtURL:[NSURL URLWithString:@"http://newleaderscouncil.org/sanfrancisco/wp-content/uploads/2013/01/1.jpg"] forUIElement:tableView];
```

Doing this will set each image if it exists in the cache, or reload the tableView whenever it loads one of the images that appear in a cell.
