<html ng-app="bankOperationsModule">
<head>
<!-- <script type="text/javascript" src="public/js/angular.js"></script>
 -->
 
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.6/angular.js"></script>
 <script type="text/javascript">
 var app=angular.module("bankOperationsModule",[]);
   app.controller("bankOperationsController",
	function($scope,$window,$http){
	   $scope.flag1=false;
	   $scope.showDepositWindow=function(){
	 
	  $http({
	  method:"get",
	  url:"/CBA-Controller/deposit",
	  }).then(function(result){
		  $window.alert("Server response-SUCCESS");
		  $scope.flag1=true;
	  },function(result){
		  $window.alert("Unable to process your request!Please Try Again");  
	  });  
	   } 
	   
	  $scope.checkAccountStatus=function(){
		  $http({
			method:"get",
			url:"checkAccountStatus",
			params:{
			"accountNumber":$scope.accountNumber	
			}
		  }).then(function(result){
			  $window.alert("ok");
		  },function(result){
			  $window.alert("failure");
		  }); 
	   }
   });
</script>
</head>
<body ng-controller="bankOperationsController">
<div >
<button type="button" ng-click="showDepositWindow()">Deposit</button>
</div>
<div ng-show="flag1">
  <label>Deposit Window</label>
  <table border="1">
  <tr>
  <td><label>Enter Account Number : </label></td>
  <td><input type="text" ng-model="accountNumber"/></td>
  <td><button ng-click="checkAccountStatus()">Click</button></td>
  </tr>
  </table>
</div>
</body>
</html>


