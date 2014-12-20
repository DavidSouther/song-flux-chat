angular.module('song-chat.head-controller', [
  'song-chat.title-service'
]).controller('HeadCtrl', function($scope, TitleSvc){
  $scope.title = TitleSvc.title;
});
