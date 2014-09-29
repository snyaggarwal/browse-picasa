BrowsePicasa.factory('Albums', ['$http', function($http) {
  return {
    all: function() {
      return $http.get('/api/albums');
    },
    photos: function(albumId) {
      return $http.get("/api/albums/" + albumId + '/photos');
    }
  }
}]);