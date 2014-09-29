BrowsePicasa.factory('Photos', ['$http', function ($http) {
  return {
    all: function (albumId) {
      return $http.get('/api/albums/' + albumId + '/photos');
    },
    comment: function (albumId, photoId, comment) {
      return $http.post("/api/albums/" + albumId + "/photos/" + photoId + "/comment",
        {comment: comment},
        {
          headers: {'X-CSRF-Token': $($('meta[name=csrf-token]')[0]).attr('content')}
        }
      );
    }
  }
}]);