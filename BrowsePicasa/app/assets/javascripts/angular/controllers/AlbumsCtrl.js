BrowsePicasa.controller('AlbumsCtrl', ['$scope', '$location', 'Albums', function($scope, $location, AlbumsService){
  $scope.init = function() {
    AlbumsService.all().then(function(response) {
      if($.isEmptyObject(response.data) || response.data == "null") {
        $scope.noAlbums = true
      } else {
        $scope.albums = response.data;
      }

    });
  };

  $scope.getPhotos = function(album) {
    $location.path('/albums/' + album.id + "/photos/");
  };

  $scope.init();

}]);