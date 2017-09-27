<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="bankOperationsModule">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>CBA-Operations Home Page</title>

        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.6/angular.js"></script>

        <script type="text/javascript">
            var app = angular.module("bankOperationsModule", []);
            app.controller("bankOperationsController", function ($scope, $window, $http) {
            $scope.flag1 = false;
            $scope.flag2 = false;
            $scope.flag3 = false;
            $scope.flag4 = false;
            //Flag for displaying Instrument ref
            $scope.flag5 = false;
            //Flag for displaying Bank/Branch ref
            $scope.flag6 = false;
            //Flag for displaying revised balance ref
            $scope.flag7=false;
            $scope.showDepositWindow = function () {
            $http({
            method: "get",
                    url: "/CBA-Controller/deposit",
            }).then(function (result) {
            $scope.flag1 = true;
            $scope.flag4 = true;
            }, function (result) {
            $window.alert("Server response-FAILURE! Please try again later");
            });
            }

            $scope.getAccountSummary = function () {
            $http({
            method: "get",
                    url: "/CBA-Controller/getAccountSummary",
                    params: {
                    "accountNumber": $scope.accountNumber
                    }
            }).then(function (result) {
            $scope.flag2 = true;
            $scope.response = angular.fromJson(result.data);
            if ($scope.response.status == "SUCCESS"){
            $scope.message = $scope.response.message;
            $scope.operative = angular.fromJson($scope.response.data).accountStatus;
            $scope.accountName = angular.fromJson($scope.response.data).accountName;
            $scope.balance = angular.fromJson($scope.response.data).balance;
            $scope.displayMessage = $scope.accountNumber + " | " + $scope.message + " | " + $scope.operative;
            if ($scope.operative == "ACTIVE"){
            $scope.flag3 = true;
            $scope.flag4 = false;
            
            }}

            if ($scope.response.status == "FAILURE"){
            $scope.message = $scope.response.message;
            $scope.displayMessage = $scope.accountNumber + " | " + $scope.message;
            }

            }, function (result) {
            $scope.flag2 = true;
            $scope.displayMessage = "UNABLE TO CONTACT SERVER; PL TRY AGAIN"

            });
            }

            $scope.cash = function(){
            //Flag for displaying Instrument ref
            $scope.flag5 = false;
            //Flag for displaying Bank/Branch ref
            $scope.flag6 = false;
            }

            $scope.cheque = function(){
            //Flag for displaying Instrument ref
            $scope.flag5 = true;
            //Flag for displaying Bank/Branch ref
            $scope.flag6 = true;
            }

            $scope.dd = function(){
            //Flag for displaying Instrument ref
            $scope.flag5 = true;
            //Flag for displaying Bank/Branch ref
            $scope.flag6 = true;
            }
            
            
            
            //
            
            
                    $scope.deposit = function(){
                    var formData = {
                    "accountNumber": $scope.accountNumber,
                    "amount":$scope.amount,
                    "paymentInstrument":$scope.paymentInstrument,
                    "instrumentRef":$scope.instrumentRef,
                    "bank":$scope.bank,
                    "branch":$scope.branch	
                        };
                    
                    $http.post('deposit', formData).then(function(result){
                     $scope.flag7=true;
                     $scope.response = angular.fromJson(result.data);
                     $scope.revBalance=angular.fromJson($scope.response.data).balance;
                     $scope.transactionID=angular.fromJson($scope.response.data).transactionID;
                    },
                    
                    function(result){
                     $window.alert("Failed data binding");   
                    });
                    
        
        
        
        
        
        
	   
	  }
   });
            
            
            
            
            
            
            
            
            
            
            
            
            


                    
                    
                    
                            
            
        </script>
        <style>
            table {
                border-collapse: collapse;
            }
        </style>
    </head>
    <body ng-controller="bankOperationsController">
        <h1>Commonwealth Bank of Australia</h1>
        <hr>
        <h3>Select Operation</h3> <br>
        <div>
            <table>
                <tr>
                    <td>
                        <button ng-click="showDepositWindow()">DEPOSIT</button>
                    </td>
                    <td>
                        <button type="button">WITHDRAW</button>
                    </td>
                    <td>
                        <button type="button">TRANSFER</button>
                    </td>
                    <td>
                        <button type="button">VIEW</button>
                    </td>
                    <td>
                        <button type="button">REPORT</button>
                    </td>
                </tr></table></div>
        <hr>
        <div ng-show="flag1">

            <table border="1">
                <tr><td colspan="3"><label><b>DEPOSIT WINDOW</b></label></td></tr>
                <tr><td>
                        <label>ENTER ACCOUNT NUMBER:</label></td>
                    <td><input type="text" ng-model="accountNumber" required/></td>
                    <td><button ng-show="flag4" ng-click="getAccountSummary()">VALIDATE</button></td>
                </tr>
                <tr ng-show="flag2"><td colspan="3">{{displayMessage}}</td></tr>
                <!--Display Account name-->
                <tr ng-show="flag3"><td><label>ACCOUNT NAME:</label></td>
                    <td>{{accountName}}</td></tr>
                <!--Display Account current balance-->
                <tr ng-show="flag3"><td><label>CURRENT BALANCE:</label></td>
                    <td>{{balance}}</td></tr>
                <tr ng-show="flag3">
                    <td colspan="2"><label>PAYMENT INSTRUMENT</label></td>
                    <td><table ng-show="flag3" ng-init="paymentInstrument = 'cash'">
                            <tr><td><input type="radio" ng-click="cash()" value="cash" ng-model="paymentInstrument"/>CASH</td>
                                <td><input type="radio" ng-click="cheque()" value="cheque" ng-model="paymentInstrument"/>CHEQUE</td>
                                <td><input type="radio" ng-click="dd()" value="dd" ng-model="paymentInstrument"/>DD</td></tr>
                        </table>
                    </td>
                </tr>

                <tr ng-show="flag5">
                    <td><label>ENTER INSTRUMENT REFERENCE</label></td>
                    <td><input type="text" ng-model="instrumentRef"/></td>
                </tr>
                <tr ng-show="flag6">
                    <td><label>ENTER ISSUED BANK</label></td>
                    <td><input type="text" ng-model="bank"/></td>
                </tr>
                <tr ng-show="flag6">
                    <td><label>ENTER BRANCH</label></td>
                    <td><input type="text" ng-model="branch"/></td>
                </tr>
                <tr ng-show="flag3">
                    <td><label>ENTER DEPOSIT AMOUNT</label></td>
                    <td><input type="number" ng-model="amount" min="1" max="10000000" required/></td>
                    <td><button align="center" ng-click="deposit()">DEPOSIT</button></td>
                </tr>
                <!--Display Account REVISED balance-->
                <tr ng-show="flag7"><td><label>REVISED BALANCE:</label></td>
                    <td>{{revBalance}}</td></tr>
                <!--Display TransactionID-->
                <tr ng-show="flag7"><td><label>TRANSACTION ID:</label></td>
                    <td>{{transactionID}}</td></tr>

            </table>
        </div>

    </body>
</html>