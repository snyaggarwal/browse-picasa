BrowsePicasa.controller('PhotosCtrl', ['$scope', '$location', '$routeParams', 'Albums', 'Photos', function($scope, $location, $routeParams, AlbumsService, PhotosService){
  $scope.init = function() {
    PhotosService.all($routeParams.id).then(function(response) {
      $scope.photos = response.data;
    });
  };

  $scope.postComment = function(photo) {
    PhotosService.comment(photo.album_id, photo.id, photo.comment)
      .then(function(response) {
         console.log(response);
      });
  };

  $scope.init();

}]);