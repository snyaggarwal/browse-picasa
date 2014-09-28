BrowsePicasa.factory('Albums', ['$http', function($http) {
  var photosList;

  return {
    all: function() {
      return $http.get('/albums');
    },
    photos: function(albumId) {
      return $http.get("/albums/" + albumId + '/photos');
    },
    setPhotos: function(photos) {
      photosList = photos;
    },
    getPhotos: function() {
      return photosList;
    }
  }
}]);