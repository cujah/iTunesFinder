# iTunesFinder

## An application based on UICollectionView and UITableView, using the UIKit and Core Data framework and receiving data from the iTunes API.
 
 iTunesFinder is a simple application for the iPhone. The application display album artwork from the iTunes API, and the user able to see detailed information about the selected album.
Also, search history saved and user can see the search history on the second tab, after tapping on the search string search result will be opened.

### UI Description:
UITabBarController with two tabs (Search, History):
- Tab with UISearchBar for start and stop searching.
- UICollectionView with albums.
- After selecting an album, will display a screen with full information about the album and list of songs (in both tabs - Search and History).
- Albums are displayed in alphabetical order

Tab with search history:
- UITableView with history from UISearchBar input text. This history saved between application launch.
- After selecting search string will display a screen with search result.
- Navigation between screens

![](https://github.com/cujah/iTunesFinder/blob/main/iTunesFinder.jpeg?raw=true)
