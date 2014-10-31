class MediaItem {
  var name: String
  init(name: String) {
    self.name = name
  }
}

class Movie: MediaItem {
  var director: String
  init(name: String, director: String) {
    self.director = director
    super.init(name: name)
  }
}

class Song: MediaItem {
  var artist: String
  init(name: String, artist: String) {
    self.artist = artist
    super.init(name: name)
  }
}

let library = [
  Movie(name: "Casablanca", director: "Michael Curtiz"),
  Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
  Movie(name: "Citizen Kane", director: "Orson Welles"),
  Song(name: "The One and only", artist: "Chesney Hawkes"),
  Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

var movieCount = 0
var songCount = 0

// checking type

for item in library {
  if item is Movie {
    movieCount++
  } else {
    songCount++
  }
}

// downcasting

for item in library {
  if let movie = item as? Movie {
    println("Movie: '\(movie.name)', dir. \(movie.director)")
  } else if let song = item as? Song {
    println("Song: '\(song.name)', by \(song.artist)")
  }
}


let someObjects: [AnyObject] = [
  Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
  Movie(name: "Moon", director: "Duncan Jones"),
  Movie(name: "Alien", director: "Ridley Scott")
]

for movie in someObjects as [Movie] {
  println("Movie: '\(movie.name)', dir. \(movie.director)")
}

var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))

for thing in things {
  switch thing {
  case 0 as Int:
    println("zero as Int")
  case 0 as Double:
    println("zero as Double")
  case let someInt as Int:
    println("an integer value of \(someInt)")
  case let someDouble as Double:
    println("a positive double value of \(someDouble)")
  case is Double:
    println("some other double value")
  case let someString as String:
    println("a string value of \"\(someString)\"")
  case let (x,y) as (Double, Double):
    println("an (x,y) point at \(x), \(y)")
  case let movie as Movie:
    println("Movie: '\(movie.name)', dir. \(movie.director)")
  default:
    println("something else")
  }
}
