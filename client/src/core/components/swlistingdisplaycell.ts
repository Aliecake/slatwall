/// <reference path='../../../typings/hibachiTypescript.d.ts' />
/// <reference path='../../../typings/tsd.d.ts' />

class SWListingDisplayCellController{
    /* local state variables */
    public swListingDisplay:any;
    public pageRecord:any;
    public column:any;
    public popover:any;
    public value:any;
    public templateUrl:any;
    public hasActionCaller:boolean;
    public actionCaller:any;
    //string that should translate to a custom directive
    public cellView:string;
    public template:string;
    public templateVariables:any; 

    //@ngInject
    constructor(
        public corePartialsPath,
        public hibachiPathBuilder,
        public utilityService,
        public $scope
    ){
        console.log("pageRecord", this.pageRecord);
        this.hibachiPathBuilder = hibachiPathBuilder;
        this.corePartialsPath = corePartialsPath;
        this.$scope = $scope;
        this.value = this.pageRecord[this.swListingDisplay.getPageRecordKey(this.column.propertyIdentifier)];
        console.log("ldc",this.column.fallbackPropertyIdentifiers)
        if(angular.isUndefined(this.value) && angular.isDefined(this.column.fallbackPropertyIdentifiers)){
            //grab the value based on the values
            var fallbackPropertyArray = this.column.fallbackPropertyIdentifiers.split(",");
            for(var i=0; i<fallbackPropertyArray.length; i++){
                if(angular.isDefined(this.pageRecord[fallbackPropertyArray[i]])){
                    this.value = this.pageRecord[fallbackPropertyArray[i]];
                    break;
                }
            }
        }
        
        this.popover = this.utilityService.replaceStringWithProperties(this.column.tooltip, this.pageRecord)

        this.hasActionCaller = false;
        if(this.column.action && this.column.queryString){
            this.hasActionCaller = true;
            this.actionCaller = {
                action:this.column.action
            }
            if(this.column.queryString){
                this.actionCaller.action.queryString=this.swListingDisplay.replaceStringWithProperties(this.column.queryString,this.pageRecord);
            }
        }


        if(this.cellView){

            var htmlCellView = this.utilityService.camelCaseToSnakeCase(this.cellView);
            this.template = htmlCellView;
            
            //convert the page records into attrs
            this.templateVariables = {}; 
           angular.forEach(this.pageRecord, (value,key)=>{
                if(key.toString().charAt(0) != "$" && value != " "){
                    this.templateVariables[this.utilityService.keyToAttributeString(key)] = value;
                }
            });
            console.log("templateVariables", this.templateVariables);
        }else{
            this.templateUrl = this.getDirectiveTemplate();
        }


    }

    public getDirectiveTemplate = ()=>{

        var templateUrl = this.hibachiPathBuilder.buildPartialsPath(this.corePartialsPath)+'listingdisplaycell.html';
        if(this.swListingDisplay.expandable && this.column.tdclass && this.column.tdclass === 'primary'){
            //templateUrl = this.hibachiPathBuilder.buildPartialsPath(this.corePartialsPath)+'listingdisplayselectablecellexpandable.html';
        }

        if(!this.swListingDisplay.expandable || !this.column.tdclass || this.column.tdclass !== 'primary'){
            if(this.column.ormtype === 'timestamp'){
                templateUrl = this.hibachiPathBuilder.buildPartialsPath(this.corePartialsPath)+'listingdisplaycelldate.html';
            }else if(this.column.type==='currency'){

                templateUrl = this.hibachiPathBuilder.buildPartialsPath(this.corePartialsPath)+'listingdisplaycellcurrency.html';
            }else if(this.column.aggregate){
                this.value = this.pageRecord[this.swListingDisplay.getPageRecordKey(this.column.aggregate.aggregateAlias)];
                templateUrl = this.hibachiPathBuilder.buildPartialsPath(this.corePartialsPath)+'listingdisplaycellaggregate.html';
            }
        }

        return templateUrl;
    }
}

class SWListingDisplayCell {

    public restrict:string = 'E';
    public scope = {};
    public bindToController={
        swListingDisplay:"=?",
        column:"=?",
        pageRecord:"=?",
        cellView:"@?"
    }
    public controller=SWListingDisplayCellController;
    public controllerAs="swListingDisplayCell";
    public template=`
        <div ng-if="swListingDisplayCell.template" sw-directive data-variables="swListingDisplayCell.templateVariables" data-directive-template="swListingDisplayCell.template"></div>
        <div ng-if="swListingDisplayCell.templateUrl" ng-include src="swListingDisplayCell.templateUrl"></div>
        <sw-action-caller ng-if="swListingDisplayCell.hasActionCaller"
                    data-action="{{swListingDisplayCell.actionCaller.action}}"
                    data-query-string="{{swListingDisplayCell.actionCaller.action.queryString}}"
                    data-text="{{swListingDisplayCell.value}}"
                    data-tooltip-text="{{swListingDisplayCell.popover}}"

        >
        </sw-action-caller>
    `;

    public static Factory(){
        var directive:ng.IDirectiveFactory=(
        ) => new SWListingDisplayCell(
        );
        directive.$inject =[
        ];
        return directive;
    }
    //@ngInject
    constructor(
    ){

    }
}
export{
    SWListingDisplayCell
}


