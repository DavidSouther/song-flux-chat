angular.module('song.dispatcher', [

]).factory('dispatcher', function(){
  function Dispatcher(){

  }
  Dispatcher.prototype = {

  };

  var dispatchers = new WeakMap();

  return {
    getDispatcher: function(moduleName){
      var ngModule = angular.module(moduleName);
      if ( !dispatchers.has(ngModule) ) {
        dispatchers.set(ngModule, new Dispatcher());
      }
      return dispatchers.get(ngModule);
    }
  };
});
