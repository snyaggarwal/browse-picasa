BrowsePicasa.controller('AlbumsCtrl', ['$scope', '$location', 'Albums', function($scope, $location, AlbumsService){
  $scope.init = function() {
    AlbumsService.all().then(function(response) {
      $scope.albums = response.data;
    });
  };

  $scope.getPhotos = function(album) {
    $location.path('/albums/' + album.id + "/photos/");
  };

  $scope.init();

}]);