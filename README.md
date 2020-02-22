# Movie

![Platform](https://img.shields.io/cocoapods/p/JOEmojiableBtn.svg?style=flat)

## Installation
need pod install will execute project  
```swift
pod install
 
```
## Usage
Language: Swift  
Architecture: MVVM  
Library: [Alamofire](https://github.com/Alamofire/Alamofire) ,[Kingfisher](https://github.com/onevcat/Kingfisher)    

Use the ​API from TMDb​:  
API Documentation . 
https://www.themoviedb.org/documentation/api?language=zh-TW

>• Discover movies - ​http://api.themoviedb.org/3/discover/movie?api_key=328c283cd27bd1877d9080ccb1604c91&primary_release_date.lte=2016-12-31&sort_by=release_date.desc&page=1  
•  Movies -   ​http://api.themoviedb.org/3/movie/328111?api_key=328c283cd27bd1877d9080ccb1604c91​  

### • Discover movies
Discover movies by different types of data like average rating, number of votes, genres and certifications. You can get a valid list of certifications from the  method.

> Home screen with list of available movies
>>a. Ordered by release date  
  b. Pull to refresh    
  c. Load when scrolled to bottom  
  d. Each movie to include:    
   >>> i. Poster/Backdrop image  
    ii. Title  
    iii. Popularity      

### Response
```swift
"page":1,
"total_results":10000,
"total_pages":500,
"results":[
{
"popularity":2.301,
"id":432374,
"video":false,
"vote_count":1,
"vote_average":10,
"title":"Dawn French Live: 30 Million Minutes",
"release_date":"2016-12-31",
"original_language":"en",
"original_title":"Dawn French Live: 30 Million Minutes",
"genre_ids":[
35
],
"backdrop_path":"27RY4W57D6HWlY3FPmSphiIXco0.jpg",
"adult":false,
"overview":"Dawn French stars in her acclaimed one-woman show, the story of her life, filmed during its final West End run.",
"poster_path":"67JLdcyxZfpNYLJTUocVvodAtAW.jpg"
}
.....
 
```
### • Movies 
>GET /movie/{movie_id} . 
 Get the primary information about a movie. 

>Movie details with these ​additional​ details:
>>•Synopsis  
•Genres 
•Language  
•Duration  
•Book the movie  
 
### Response
```swift
{
  "adult":false,
  "backdrop_path":"/3DrUqTAPjriEasoGrz5G8sPJtDU.jpg",
  "belongs_to_collection":{
  "id":427084,
  "name":"The Secret Life of Pets Collection",
  "poster_path":"/5uYBl9BNxbf5M64V33vdOUW5t1g.jpg",
  "backdrop_path":"/lB4l8H0jgPp2bf4NV2aZPIyytdQ.jpg"
},
  "budget":75000000,
  "genres":[
{
  "id":12,
  "name":"Adventure"
},
{
  "id":35,
  "name":"Comedy"
},
{
  "id":16,
  "name":"Animation"
},
{
  "id":10751,
  "name":"Family"
}
],
  "homepage":"http://www.thesecretlifeofpets.com/",
  "id":328111,
  "imdb_id":"tt2709768",
  "original_language":"en",
  "original_title":"The Secret Life of Pets",
  "overview":"The quiet life of a terrier named Max is upended when his owner takes in Duke, a stray whom Max instantly dislikes.",
  "popularity":5.816,
  "poster_path":"/WLQN5aiQG8wc9SeKwixW7pAR8K.jpg",
  "release_date":"2016-06-18",
  "revenue":875457937,
  "runtime":87,
],
  "status":"Released",
  "tagline":"Think this is what they do all day?",
  "title":"The Secret Life of Pets",
  "video":false,
  "vote_average":6.2,
  "vote_count":5909
}
 
```
## Demo

![image](https://github.com/Yu-Yen-Chou/File/blob/master/Access_Img/movie.gif)


## Example Code

>#### Read cache image
```swift
   let articleUrl = URL(string: base_url)
   let imageResource = ImageResource(downloadURL: articleUrl!, cacheKey: base_url)
   Poster_img.kf.setImage(with: imageResource)
 
```
>#### Animation cell 
```swift
func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
{
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
    UIView.animate(withDuration: 0.25, animations: {
    cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
   })
}
 
```
>#### Load when scrolled to bottom   
```swift
func scrollViewDidScroll(_ scrollView: UIScrollView)
{
   let offsetY = scrollView.contentOffset.y
   let contentHeight = scrollView.contentSize.height
   if (offsetY > contentHeight - scrollView.frame.height ) && !isLoading
   {
      loadMoreData()
   }
}
 
```

