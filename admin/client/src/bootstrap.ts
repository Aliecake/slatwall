/// <reference path='../typings/slatwallTypescript.d.ts' />
/// <reference path='../typings/tsd.d.ts' />
/*jshint browser:true */
import {BaseBootStrapper} from "../../../org/Hibachi/client/src/basebootstrap";
import {slatwalladminmodule} from "./slatwall/slatwalladmin.module";




//custom bootstrapper
class bootstrapper extends BaseBootStrapper{
    public myApplication;
    constructor(){
        super(slatwalladminmodule.name);


        console.log(slatwalladminmodule);
        angular.bootstrap(document,[slatwalladminmodule.name])
    }


}

export = new bootstrapper();



