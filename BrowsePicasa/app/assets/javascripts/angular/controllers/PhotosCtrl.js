BrowsePicasa.controller('PhotosCtrl', ['$scope', '$location', '$routeParams', 'Albums', 'Photos', 'Notification', function($scope, $location, $routeParams, AlbumsService, PhotosService, Notification){
  $scope.init = function() {
    PhotosService.all($routeParams.id).then(function(response) {
      if($.isEmptyObject(response.data) || response.data == "null") {
        $scope.noPhotos = true
      } else {
        $scope.photos = response.data;
        $scope.album_name = $scope.photos[0].album_name;
      }
    });
  };

  $scope.postComment = function(photo) {
    PhotosService.comment(photo.album_id, photo.id, photo.comment)
      .then(function(response) {
        Notification.log('Successfully Posted Comment ' + photo.comment + ' on ' + photo.title, 'success');
        photo.comment = '';
      });
  };

  $scope.init();

}]);