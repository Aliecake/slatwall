

//controllers
import {AlertController} from "./controllers/alertcontroller";
//services
import {AlertService} from "./service/alertservice";
var alertmodule = angular.module('hibachi.alert',[])
//controllers
.controller('alertController',AlertController)
//services
.service('alertService',AlertService)
;
export{
	alertmodule
}; 
