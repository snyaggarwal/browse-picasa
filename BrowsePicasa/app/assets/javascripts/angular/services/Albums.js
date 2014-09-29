BrowsePicasa.factory('Albums', ['$http', function($http) {
  return {
    all: function() {
      return $http.get('/albums');
    },
    photos: function(albumId) {
      return $http.get("/albums/" + albumId + '/photos');
    }
  }
}]);