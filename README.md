ImageCache
==========

A shared cache class that loads/saves UIImages from the web to a Key/Value store, and sets UI Elements with the image whenever it's loaded.

## Set Up ##

* Drag the included <code>ImageCache.{h,m}</code> into your project.
* Import <code>ImageCache.h</code> into whatever class you will be loading images in.

## How to Use ##

**Loading Images**

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

**Dumping the Cache**

There are two options provided for getting rid of items in the cache, either by Least Recently Used or dumping the entire thing. The Least Recently Used method takes in an int as a parameter and removes that many items from the cache (up to the total count of the cache). This works by checking the date of access for the images - either loaded from the web or loaded from the cache - and removing the least recently used ones. Both methods can be used like this:

```objc
// Removing the 4 most recently used images
[ImageCache dumpLeastRecentlyUsed:4];

// Removing all items from the cache
[ImageCache dumpCache];
```

Ideally you would call these methods in the <code>didReceiveMemoryWarning</code> method of your ViewController or before entering the background in the App Delegate <code>applicationDidEnterBackground:(UIApplication *)application</code> method.

## Design Caveats ##

So one part of the design process for me was to remove extra-long method names and calls, and the other part was for the primary use of one ImageCache per App. To meet these guidelines, I created the ImageCache to only use class methods that operate on the <code>[ImageCache sharedCache]</code> instance behind the scenes. This means that the function calls end up being something like this <code>[ImageCache dumpCache]</code> instead of <code>[[ImageCache sharedCache] dumpCache]</code>, which may be more idiomatic Objective-C. If you would like to use multiple ImageCache classes (who knows, you might just want to) for a single application, I suggest turning those methods into instance methods and changing all mentions of <code>[ImageCache sharedCache]</code> to <code>self</code>. That should free you up to use multiple cache instances in your app.

## License ##

This repository is licensed under the standard MIT License.
