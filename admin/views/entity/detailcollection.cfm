<div class="panel-group s-pannel-group" id="accordion" ng-controller="collections">
    <div class="panel panel-default">
        <a data-toggle="collapse"  href="#basic">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <span>Basic</span>
                    <i class="fa fa-caret-left"></i>
                </h4>
            </div>
        </a>

        <div id="basic" class="panel-collapse collapse in">
         <content class="s-body-box s-panel-header-info">

        	<div class="col-xs-12 s-filter-content">
		    <!--- Header nav with title start --->
		   <!--- <span ng-controller="collectionsTabController">--->
			<!---<span 	sw-header-with-tabs
					header-title="collection.collectionName"
					tab-array="[{tabTitle:'PROPERTIES',isActive:true,id:'properties'},
								{tabTitle:'FILTERS ('+filterCount+')',isActive:false,id:'filters'},
								{tabTitle:'DISPLAY OPTIONS',isActive:false,id:'display-options',directive:'sw-tab-display-options'}
					]"
			>
			</span>--->
			
		    <!---</span>--->
		    <div class="row s-header-bar">
		      <div class="col-md-7"><h1 ng-bind="collection.collectionName"></h1></div>
		      <div class="col-md-5 s-header-nav">
		        <ul class="nav nav-tabs" role="tablist">
		          <li class="active"><a href="##j-properties" role="tab" data-toggle="tab">PROPERTIES</a></li>
		          <li><a href="##j-filters" role="tab" data-toggle="tab">FILTERS <span>(<span ng-bind="filterCount()"></span>)</span></a></li>
		          <li><a href="##j-display-options" role="tab" data-toggle="tab">DISPLAY OPTIONS</a></li>
		        </ul>
		      </div>
		    </div>
		    <!--- //Header nav with title end --->
		
		    <!--- Tab panes for menu options start--->
		    
		    <div class="row s-options">
		      <div class="tab-content" id="j-property-box">
		
		        <div class="tab-pane active" id="j-properties">
		          <span class="s-edit-btn-group">
		          	  <button class="btn btn-xs s-btn-ten24" id="j-save-btn" ng-click="saveCollection()" ng-show="collectionDetails.isOpen">
		          		<i class="fa fa-floppy-o"></i> 
		          		Save
			          </button> 
			          <button class="btn btn-xs s-btn-lgrey" id="j-edit-btn" ng-click="collectionDetails.openCollectionDetails()" ng-show="!collectionDetails.isOpen">
			          	<i class="fa fa-pencil"></i> 
			          	Edit
			          </button>
		         </span>
		          <form  class="form-horizontal s-properties" role="form" name="collectionForm" ng-init="setCollectionFormScope(collectionForm)" >
		            <input  style="display:none" name="entityID" ng-model="collection.collectionID" type="hidden" value="">
		            	
		           <!-- <span 	sw-property-display
		            		object="collection"
		            		property="collectionName",
							is-editable="true"
		            ></span>-->
		            <div class="form-group">
		              <label class="col-sm-2 control-label">Title:<span class="j-tool-tip-item" data-toggle="tooltip" data-placement="top" title="The collection title"> <i class="fa fa-question-circle"></i></span></label>
		              <div class="col-sm-10">
		                <input ng-show="collectionDetails.isOpen"  ng-model="collection.collectionName" name="collectionName" type="text" class="form-control" id="inputPassword" value="" required>
		               	<span style="color:red"
					      ng-show="collectionForm.collectionName.$invalid && collectionForm.collectionName.$dirty">
					      {{errorMessage.collectionName}}
					    </span>
		                <p ng-show="!collectionDetails.isOpen" class="form-control-static" ng-bind="collection.collectionName"><!---collection Name ---></p>
		              </div>
		            </div>
		            <div class="form-group">
		              <label for="inputPassword" class="col-sm-2 control-label">Code: <span class="j-tool-tip-item" data-toggle="tooltip" data-placement="top" title="The collection code"> <i class="fa fa-question-circle"></i></span></label>
		              <div class="col-sm-10">
		                <input ng-show="collectionDetails.isOpen" ng-model="collection.collectionCode"  name="collectionCode" type="text" class="form-control" id="inputPassword" value="" required>
		                <p ng-show="!collectionDetails.isOpen" class="form-control-static" ng-bind="collection.collectionCode"><!---collection Code ---></p>
		              	<span  style="color:red"
					      ng-show="collectionForm.collectionCode.$invalid && collectionForm.collectionCode.$dirty">
					      {{errorMessage.collectionCode}}
					    </span>
		              </div>
		            </div>
		            <div class="form-group">
		              <label for="inputPassword" class="col-sm-2 control-label">Description: <span class="j-tool-tip-item" data-toggle="tooltip" data-placement="top" title="The collection description"> <i class="fa fa-question-circle"></i></span></label>
		              <div class="col-sm-10">
		                <input ng-show="collectionDetails.isOpen"  ng-model="collection.description" name="description" type="text" class="form-control" id="inputPassword" value="" >
		                <p ng-show="!collectionDetails.isOpen" ng-bind="collection.description" class="form-control-static"><!---collection description ---></p>
		              	<span  style="color:red"
					      ng-show="collectionForm.description.$invalid && collectionForm.description.$dirty">
					      {{errorMessage.description}}
					    </span>
		              </div>
		            </div>
		            <div class="form-group">
		              <label for="inputPassword" class="col-sm-2 control-label">Collection Type: <span class="j-tool-tip-item" data-toggle="tooltip" data-placement="top" title="The collection type"> <i class="fa fa-question-circle"></i></span></label>
		              <div class="col-sm-10">
		                <input ng-show="collectionDetails.isOpen" disabled="disabled"  ng-model="collectionConfig.baseEntityAlias" type="text" class="form-control" value="" >
		                <p ng-show="!collectionDetails.isOpen" ng-bind="collectionConfig.baseEntityAlias" class="form-control-static"><!---collection base entity alias ---></p>
		              	
		              </div>
		            </div>
		          </form>
		        </div>
		        <div class="tab-pane" id="j-filters">
		          <div class="s-setting-options">
		            <div class="row s-setting-options-body">
		
		              <!--- Start Filter Group --->
		              <div class="col-xs-12 s-filters-selected">
		                <div class="row">
		                	<!---filterGroups gets taken apart here --->
		                	<ul class="col-xs-12 list-unstyled" 
		                		sw-filter-groups 
		                		data-filter-group="collectionConfig.filterGroups[0]"
		                		data-filter-group-item="collectionConfig.filterGroups[0].filterGroup"
		                		data-filter-properties-list="filterPropertiesList"
		                		data-save-collection="saveCollection()"
		                		>
		                	</ul>
		                </div>
		                <!--- //New Filter Panel --->
		              </div>
		              <!--- //End Filter Group --->
		            </div>
		          </div>
		        </div><!--- //Tab Pane --->
		        <div class="tab-pane s-display-options" id="j-display-options">
					<span  sw-display-options
						data-columns="collectionConfig.columns"
						data-properties-list="filterPropertiesList"
						data-save-collection="saveCollection()"
						data-callbacks="callbacks"
						data-base-entity-alias="collectionConfig.baseEntityAlias"
					>
						<li class="list-group-item" 
								ng-repeat="column in collectionConfig.columns" 
								sw-column-item
								data-column="column"
								data-column-index="$index"
								data-save-collection="saveCollection()"
								data-properties-list="filterPropertiesList"
								data-callbacks="callbacks"
								
						></li>
					</span >
				</div><!--- //Tab Pane --->
		      </div>
		
		    </div><!--- //Row --->
		    <!--- //Tab panes for menu options end--->
		    <div class="row s-table-header-nav">
		      <div class="col-xs-6">
		      	<!---TODO: implement keyword searching and bulk actions --->
			      <ul class="list-inline list-unstyled">
				      <!--<li>
			            <form role="search">
			
			                <label for="name" class="control-label"><i class="fa fa-level-down"></i></label>
			                <select size="1" name="" aria-controls="" class="form-control accordion-dropdown">
			                  <option value="15" selected="selected" disabled="disabled">Bulk Action</option>
			                  <option value="j-export-link" data-toggle="collapse">Export</option>
			                  <option value="j-delete-link" data-toggle="collapse">Delete</option>
			                </select>
			
			            </form>
			          </li>-->
				      <li style="width:200px;">
				        <form   class="s-table-header-search">
				          <div class="input-group">
				            <input  type="text" 
				            		class="form-control input-sm" 
				            		placeholder="Search" 
				            		name="srch-term" 
				            		ng-model="keywords"
				            />
				            <div class="input-group-btn">
				              <button   class="btn btn-default btn-sm" 
				              			type="submit"
				              			ng-click="searchCollection()"
				              >
				              	<i class="fa fa-search"></i>
				              </button>
				            </div>
				          </div>
				        </form>
				      </li>
				    </ul>
			  	</div>
		        <span   sw-pagination-bar
			      		data-collection="collection"
			      		data-current-page="currentPage"
			      		data-page-show="pageShow"
			      		data-page-start="pageStart"
			      		data-page-end="pageEnd"
			      		data-records-count="recordsCount"
		        >
		        </span>
		        
		 	</div>
		 	
		 	<span 	sw-export-action
		 			
		 	>
		 	</span>
		
		    <!--delete batch action-->
		    <div id="j-delete-link" class="row collapse s-batch-options">
		      <div class="col-md-12 s-add-filter">
		
		        <!--- Edit Filter Box --->
		
		          <h4> Delete:<i class="fa fa-times" data-toggle="collapse" data-target="#j-delete-link"></i></h4>
		          <div class="col-xs-12">
		
		            <div class="row">
		              <div class="col-xs-2">
		                <div class="form-group form-group-sm">
		                  <label class="col-sm-12 control-label s-no-padding" for="formGroupInputSmall">Items To Delete:</label>
		                  <div class="col-sm-12 s-no-paddings">
		
		                    <div class="radio">
		                      <input type="radio" name="radio1" id="radio7" value="option2" checked="checked">
		                      <label for="radio7">
		                          All
		                      </label>
		                    </div>
		                    <div class="radio">
		                      <input type="radio" name="radio1" id="radio7" value="option2">
		                      <label for="radio7">
		                          Visable
		                      </label>
		                    </div>
		                    <div class="radio">
		                      <input type="radio" name="radio1" id="radio7" value="option2">
		                      <label for="radio7">
		                          Selected
		                      </label>
		                    </div>
		                  </div>
		                  <div class="clearfix"></div>
		                </div>
		              </div>
		              <div class="col-xs-7 s-criteria">
		
		                <div class="alert alert-danger" role="alert">
		                  <div class="input-group">
		                    <label>Confirm action by typing "DELETE" below.</label>
		                    <input type="text" class="form-control j-delete-text" placeholder="">
		
		                  </div>
		                </div>
		
		              </div>
		              <div class="col-xs-2">
		                <div class="s-button-select-group">
		                  <button type="button" class="btn btn-sm s-btn-ten24 j-delete-btn" disabled="disabled" style="width:100%;">Delete</button>
		                </div>
		              </div>
		            </div>
		          </div>
		
		        <!--- //Edit Filter Box --->
		      </div>
		    </div>
		    <!--//delete batch action-->
		     
			<!---TODO: make this list view section a directive that we pass a collection into --->
		    <!---list view begin --->
		     <div class="table-responsive s-filter-table-box">
			    <table class="table table-bordered table-striped" > 
			        <thead>
			            <tr>
			                <th>Row</span></th>
			                <th ng-repeat="(key,column) in collectionConfig.columns" class="s-sortable" ng-bind="column.title" ng-show="column.isVisible"></th>
			                <th></th>
			            </tr>
			        </thead>
			        <tbody sw-scroll-trigger 
		    		infinite-scroll="appendToCollection()"		
		    		infinite-scroll-disabled="autoScrollDisabled"
		    		infinite-scroll-distance="1">
						<tr class="even-tr" ng-repeat="pageRecord in collection.pageRecords">
				            <td> <div class="s-checkbox"><input type="checkbox" id="j-checkbox"><label for="j-checkbox"></label></div></td>
				            <td ng-repeat="(key,column) in collectionConfig.columns" ng-bind="pageRecord[column.propertyIdentifier.split('.').pop()]" ng-show="column.isVisible"></td>
				           <td class="s-edit-elements">
				              <ul>
				                <li><span class="j-tool-tip-item" data-toggle="tooltip" data-placement="top" title="View"><a href="##"><i class="fa fa-eye"></i></a></span></li>
				                <li><span class="j-tool-tip-item" data-toggle="tooltip" data-placement="top" title="Edit"><a href="##"><i class="fa fa-pencil"></i></a></span></li>
				              </ul>
				            </td>
			          	</tr>
			        </tbody>
			    </table>
			 </div>
			<!---list view end --->
		    <div 	class="row" 
		    		
		    >
		      <div class="col-md-12" span ng-show="pageShow !== 'Auto'">
		        <div class="dataTables_info" id="example3_info" >Showing <b><span ng-bind="pageStart()"><!--- record start ---></span> to <span ng-bind="pageEnd()"><!---records end ---><span></b> of <span ng-bind="recordsCount()"><!--- records Count ---></span> entries</div>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
</div>

<script charset="utf-8">
  //activate tooltips
  $(function(){
    $('.j-tool-tip-item').tooltip();
  });
</script>

<!---<script charset="utf-8">
  //This was created for example only to toggle the edit save icons
  $(function(){
    $('#j-edit-btn').click(function(){
      $(this).toggle();
      $(this).siblings('#j-save-btn').toggle();
      $('.s-properties p').toggle();
      $('.s-properties input').toggle();
    });
    $('#j-save-btn').click(function(){
      $(this).toggle();
      $(this).siblings('#j-edit-btn').toggle();
      $('.s-properties p').toggle();
      $('.s-properties input').toggle();
    });
  });
</script>--->





<script charset="utf-8">
  $('.s-filter-item .panel-body').click(function(){
    $(this).parent().parent().parent().siblings('li').toggleClass('s-disabled');
    $(this).parent().toggleClass('s-focus');
  });
</script>

<script charset="utf-8">
  !function(a){"use strict";a(window.jQuery,window,document)}(function(a,b,c,d){"use strict";a.widget("selectBox.selectBoxIt",{VERSION:"3.8.1",options:{showEffect:"none",showEffectOptions:{},showEffectSpeed:"medium",hideEffect:"none",hideEffectOptions:{},hideEffectSpeed:"medium",showFirstOption:!0,defaultText:"",defaultIcon:"",downArrowIcon:"",theme:"default",keydownOpen:!0,isMobile:function(){var a=navigator.userAgent||navigator.vendor||b.opera;return/iPhone|iPod|iPad|Silk|Android|BlackBerry|Opera Mini|IEMobile/.test(a)},"native":!1,aggressiveChange:!1,selectWhenHidden:!0,viewport:a(b),similarSearch:!1,copyAttributes:["title","rel"],copyClasses:"button",nativeMousedown:!1,customShowHideEvent:!1,autoWidth:!0,html:!0,populate:"",dynamicPositioning:!0,hideCurrent:!1},getThemes:function(){var b=this,c=a(b.element).attr("data-theme")||"c";return{bootstrap:{focus:"active",hover:"",enabled:"enabled",disabled:"disabled",arrow:"caret",button:"btn",list:"dropdown-menu",container:"bootstrap",open:"open"},jqueryui:{focus:"ui-state-focus",hover:"ui-state-hover",enabled:"ui-state-enabled",disabled:"ui-state-disabled",arrow:"ui-icon ui-icon-triangle-1-s",button:"ui-widget ui-state-default",list:"ui-widget ui-widget-content",container:"jqueryui",open:"selectboxit-open"},jquerymobile:{focus:"ui-btn-down-"+c,hover:"ui-btn-hover-"+c,enabled:"ui-enabled",disabled:"ui-disabled",arrow:"ui-icon ui-icon-arrow-d ui-icon-shadow",button:"ui-btn ui-btn-icon-right ui-btn-corner-all ui-shadow ui-btn-up-"+c,list:"ui-btn ui-btn-icon-right ui-btn-corner-all ui-shadow ui-btn-up-"+c,container:"jquerymobile",open:"selectboxit-open"},"default":{focus:"selectboxit-focus",hover:"selectboxit-hover",enabled:"selectboxit-enabled",disabled:"selectboxit-disabled",arrow:"selectboxit-default-arrow",button:"selectboxit-btn",list:"selectboxit-list",container:"selectboxit-container",open:"selectboxit-open"}}},isDeferred:function(b){return a.isPlainObject(b)&&b.promise&&b.done},_create:function(b){var d=this,e=d.options.populate,f=d.options.theme;if(d.element.is("select"))return d.widgetProto=a.Widget.prototype,d.originalElem=d.element[0],d.selectBox=d.element,d.options.populate&&d.add&&!b&&d.add(e),d.selectItems=d.element.find("option"),d.firstSelectItem=d.selectItems.slice(0,1),d.documentHeight=a(c).height(),d.theme=a.isPlainObject(f)?a.extend({},d.getThemes()["default"],f):d.getThemes()[f]?d.getThemes()[f]:d.getThemes()["default"],d.currentFocus=0,d.blur=!0,d.textArray=[],d.currentIndex=0,d.currentText="",d.flipped=!1,b||(d.selectBoxStyles=d.selectBox.attr("style")),d._createDropdownButton()._createUnorderedList()._copyAttributes()._replaceSelectBox()._addClasses(d.theme)._eventHandlers(),d.originalElem.disabled&&d.disable&&d.disable(),d._ariaAccessibility&&d._ariaAccessibility(),d.isMobile=d.options.isMobile(),d._mobile&&d._mobile(),d.options["native"]&&this._applyNativeSelect(),d.triggerEvent("create"),d},_createDropdownButton:function(){var b=this,c=b.originalElemId=b.originalElem.id||"",d=b.originalElemValue=b.originalElem.value||"",e=b.originalElemName=b.originalElem.name||"",f=b.options.copyClasses,g=b.selectBox.attr("class")||"";return b.dropdownText=a("<span/>",{id:c&&c+"SelectBoxItText","class":"selectboxit-text",unselectable:"on",text:b.firstSelectItem.text()}).attr("data-val",d),b.dropdownImageContainer=a("<span/>",{"class":"selectboxit-option-icon-container"}),b.dropdownImage=a("<i/>",{id:c&&c+"SelectBoxItDefaultIcon","class":"selectboxit-default-icon",unselectable:"on"}),b.dropdown=a("<span/>",{id:c&&c+"SelectBoxIt","class":"selectboxit "+("button"===f?g:"")+" "+(b.selectBox.prop("disabled")?b.theme.disabled:b.theme.enabled),name:e,tabindex:b.selectBox.attr("tabindex")||"0",unselectable:"on"}).append(b.dropdownImageContainer.append(b.dropdownImage)).append(b.dropdownText),b.dropdownContainer=a("<span/>",{id:c&&c+"SelectBoxItContainer","class":"selectboxit-container "+b.theme.container+" "+("container"===f?g:"")}).append(b.dropdown),b},_createUnorderedList:function(){var b,c,d,e,f,g,h,i,j,k,l,m,n,o=this,p="",q=o.originalElemId||"",r=a("<ul/>",{id:q&&q+"SelectBoxItOptions","class":"selectboxit-options",tabindex:-1});if(o.options.showFirstOption||(o.selectItems.first().attr("disabled","disabled"),o.selectItems=o.selectBox.find("option").slice(1)),o.selectItems.each(function(q){m=a(this),c="",d="",b=m.prop("disabled"),e=m.attr("data-icon")||"",f=m.attr("data-iconurl")||"",g=f?"selectboxit-option-icon-url":"",h=f?"style=\"background-image:url('"+f+"');\"":"",i=m.attr("data-selectedtext"),j=m.attr("data-text"),l=j?j:m.text(),n=m.parent(),n.is("optgroup")&&(c="selectboxit-optgroup-option",0===m.index()&&(d='<span class="selectboxit-optgroup-header '+n.first().attr("class")+'"data-disabled="true">'+n.first().attr("label")+"</span>")),m.attr("value",this.value),p+=d+'<li data-id="'+q+'" data-val="'+this.value+'" data-disabled="'+b+'" class="'+c+" selectboxit-option "+(a(this).attr("class")||"")+'"><a class="selectboxit-option-anchor"><span class="selectboxit-option-icon-container"><i class="selectboxit-option-icon '+e+" "+(g||o.theme.container)+'"'+h+"></i></span>"+(o.options.html?l:o.htmlEscape(l))+"</a></li>",k=m.attr("data-search"),o.textArray[q]=b?"":k?k:l,this.selected&&(o._setText(o.dropdownText,i||l),o.currentFocus=q)}),o.options.defaultText||o.selectBox.attr("data-text")){var s=o.options.defaultText||o.selectBox.attr("data-text");o._setText(o.dropdownText,s),o.options.defaultText=s}return r.append(p),o.list=r,o.dropdownContainer.append(o.list),o.listItems=o.list.children("li"),o.listAnchors=o.list.find("a"),o.listItems.first().addClass("selectboxit-option-first"),o.listItems.last().addClass("selectboxit-option-last"),o.list.find("li[data-disabled='true']").not(".optgroupHeader").addClass(o.theme.disabled),o.dropdownImage.addClass(o.selectBox.attr("data-icon")||o.options.defaultIcon||o.listItems.eq(o.currentFocus).find("i").attr("class")),o.dropdownImage.attr("style",o.listItems.eq(o.currentFocus).find("i").attr("style")),o},_replaceSelectBox:function(){var b,c,e,f=this,g=f.originalElem.id||"",h=f.selectBox.attr("data-size"),i=f.listSize=h===d?"auto":"0"===h?"auto":+h;return f.selectBox.css("display","none").after(f.dropdownContainer),f.dropdownContainer.appendTo("body").addClass("selectboxit-rendering"),b=f.dropdown.height(),f.downArrow=a("<i/>",{id:g&&g+"SelectBoxItArrow","class":"selectboxit-arrow",unselectable:"on"}),f.downArrowContainer=a("<span/>",{id:g&&g+"SelectBoxItArrowContainer","class":"selectboxit-arrow-container",unselectable:"on"}).append(f.downArrow),f.dropdown.append(f.downArrowContainer),f.listItems.removeClass("selectboxit-selected").eq(f.currentFocus).addClass("selectboxit-selected"),c=f.downArrowContainer.outerWidth(!0),e=f.dropdownImage.outerWidth(!0),f.options.autoWidth&&(f.dropdown.css({width:"auto"}).css({width:f.list.outerWidth(!0)+c+e}),f.list.css({"min-width":f.dropdown.width()})),f.dropdownText.css({"max-width":f.dropdownContainer.outerWidth(!0)-(c+e)}),f.selectBox.after(f.dropdownContainer),f.dropdownContainer.removeClass("selectboxit-rendering"),"number"===a.type(i)&&(f.maxHeight=f.listAnchors.outerHeight(!0)*i),f},_scrollToView:function(a){var b=this,c=b.listItems.eq(b.currentFocus),d=b.list.scrollTop(),e=c.height(),f=c.position().top,g=Math.abs(f),h=b.list.height();return"search"===a?e>h-f?b.list.scrollTop(d+(f-(h-e))):-1>f&&b.list.scrollTop(f-e):"up"===a?-1>f&&b.list.scrollTop(d-g):"down"===a&&e>h-f&&b.list.scrollTop(d+(g-h+e)),b},_callbackSupport:function(b){var c=this;return a.isFunction(b)&&b.call(c,c.dropdown),c},_setText:function(a,b){var c=this;return c.options.html?a.html(b):a.text(b),c},open:function(a){var b=this,c=b.options.showEffect,d=b.options.showEffectSpeed,e=b.options.showEffectOptions,f=b.options["native"],g=b.isMobile;return!b.listItems.length||b.dropdown.hasClass(b.theme.disabled)?b:(f||g||this.list.is(":visible")||(b.triggerEvent("open"),b._dynamicPositioning&&b.options.dynamicPositioning&&b._dynamicPositioning(),"none"===c?b.list.show():"show"===c||"slideDown"===c||"fadeIn"===c?b.list[c](d):b.list.show(c,e,d),b.list.promise().done(function(){b._scrollToView("search"),b.triggerEvent("opened")})),b._callbackSupport(a),b)},close:function(a){var b=this,c=b.options.hideEffect,d=b.options.hideEffectSpeed,e=b.options.hideEffectOptions,f=b.options["native"],g=b.isMobile;return f||g||!b.list.is(":visible")||(b.triggerEvent("close"),"none"===c?b.list.hide():"hide"===c||"slideUp"===c||"fadeOut"===c?b.list[c](d):b.list.hide(c,e,d),b.list.promise().done(function(){b.triggerEvent("closed")})),b._callbackSupport(a),b},toggle:function(){var a=this,b=a.list.is(":visible");b?a.close():b||a.open()},_keyMappings:{38:"up",40:"down",13:"enter",8:"backspace",9:"tab",32:"space",27:"esc"},_keydownMethods:function(){var a=this,b=a.list.is(":visible")||!a.options.keydownOpen;return{down:function(){a.moveDown&&b&&a.moveDown()},up:function(){a.moveUp&&b&&a.moveUp()},enter:function(){var b=a.listItems.eq(a.currentFocus);a._update(b),"true"!==b.attr("data-preventclose")&&a.close(),a.triggerEvent("enter")},tab:function(){a.triggerEvent("tab-blur"),a.close()},backspace:function(){a.triggerEvent("backspace")},esc:function(){a.close()}}},_eventHandlers:function(){var b,c,d=this,e=d.options.nativeMousedown,f=d.options.customShowHideEvent,g=d.focusClass,h=d.hoverClass,i=d.openClass;return this.dropdown.on({"click.selectBoxIt":function(){d.dropdown.trigger("focus",!0),d.originalElem.disabled||(d.triggerEvent("click"),e||f||d.toggle())},"mousedown.selectBoxIt":function(){a(this).data("mdown",!0),d.triggerEvent("mousedown"),e&&!f&&d.toggle()},"mouseup.selectBoxIt":function(){d.triggerEvent("mouseup")},"blur.selectBoxIt":function(){d.blur&&(d.triggerEvent("blur"),d.close(),a(this).removeClass(g))},"focus.selectBoxIt":function(b,c){var e=a(this).data("mdown");a(this).removeData("mdown"),e||c||setTimeout(function(){d.triggerEvent("tab-focus")},0),c||(a(this).hasClass(d.theme.disabled)||a(this).addClass(g),d.triggerEvent("focus"))},"keydown.selectBoxIt":function(a){var b=d._keyMappings[a.keyCode],c=d._keydownMethods()[b];c&&(c(),!d.options.keydownOpen||"up"!==b&&"down"!==b||d.open()),c&&"tab"!==b&&a.preventDefault()},"keypress.selectBoxIt":function(a){var b=a.charCode||a.keyCode,c=d._keyMappings[a.charCode||a.keyCode],e=String.fromCharCode(b);d.search&&(!c||c&&"space"===c)&&d.search(e,!0,!0),"space"===c&&a.preventDefault()},"mouseenter.selectBoxIt":function(){d.triggerEvent("mouseenter")},"mouseleave.selectBoxIt":function(){d.triggerEvent("mouseleave")}}),d.list.on({"mouseover.selectBoxIt":function(){d.blur=!1},"mouseout.selectBoxIt":function(){d.blur=!0},"focusin.selectBoxIt":function(){d.dropdown.trigger("focus",!0)}}),d.list.on({"mousedown.selectBoxIt":function(){d._update(a(this)),d.triggerEvent("option-click"),"false"===a(this).attr("data-disabled")&&"true"!==a(this).attr("data-preventclose")&&d.close(),setTimeout(function(){d.dropdown.trigger("focus",!0)},0)},"focusin.selectBoxIt":function(){d.listItems.not(a(this)).removeAttr("data-active"),a(this).attr("data-active","");var b=d.list.is(":hidden");(d.options.searchWhenHidden&&b||d.options.aggressiveChange||b&&d.options.selectWhenHidden)&&d._update(a(this)),a(this).addClass(g)},"mouseup.selectBoxIt":function(){e&&!f&&(d._update(a(this)),d.triggerEvent("option-mouseup"),"false"===a(this).attr("data-disabled")&&"true"!==a(this).attr("data-preventclose")&&d.close())},"mouseenter.selectBoxIt":function(){"false"===a(this).attr("data-disabled")&&(d.listItems.removeAttr("data-active"),a(this).addClass(g).attr("data-active",""),d.listItems.not(a(this)).removeClass(g),a(this).addClass(g),d.currentFocus=+a(this).attr("data-id"))},"mouseleave.selectBoxIt":function(){"false"===a(this).attr("data-disabled")&&(d.listItems.not(a(this)).removeClass(g).removeAttr("data-active"),a(this).addClass(g),d.currentFocus=+a(this).attr("data-id"))},"blur.selectBoxIt":function(){a(this).removeClass(g)}},".selectboxit-option"),d.list.on({"click.selectBoxIt":function(a){a.preventDefault()}},"a"),d.selectBox.on({"change.selectBoxIt, internal-change.selectBoxIt":function(a,e){var f,g;e||(f=d.list.find('li[data-val="'+d.originalElem.value+'"]'),f.length&&(d.listItems.eq(d.currentFocus).removeClass(d.focusClass),d.currentFocus=+f.attr("data-id"))),f=d.listItems.eq(d.currentFocus),g=f.attr("data-selectedtext"),b=f.attr("data-text"),c=b?b:f.find("a").text(),d._setText(d.dropdownText,g||c),d.dropdownText.attr("data-val",d.originalElem.value),f.find("i").attr("class")&&(d.dropdownImage.attr("class",f.find("i").attr("class")).addClass("selectboxit-default-icon"),d.dropdownImage.attr("style",f.find("i").attr("style"))),d.triggerEvent("changed")},"disable.selectBoxIt":function(){d.dropdown.addClass(d.theme.disabled)},"enable.selectBoxIt":function(){d.dropdown.removeClass(d.theme.disabled)},"open.selectBoxIt":function(){var a,b=d.list.find("li[data-val='"+d.dropdownText.attr("data-val")+"']");b.length||(b=d.listItems.not("[data-disabled=true]").first()),d.currentFocus=+b.attr("data-id"),a=d.listItems.eq(d.currentFocus),d.dropdown.addClass(i).removeClass(h).addClass(g),d.listItems.removeClass(d.selectedClass).removeAttr("data-active").not(a).removeClass(g),a.addClass(d.selectedClass).addClass(g),d.options.hideCurrent&&(d.listItems.show(),a.hide())},"close.selectBoxIt":function(){d.dropdown.removeClass(i)},"blur.selectBoxIt":function(){d.dropdown.removeClass(g)},"mouseenter.selectBoxIt":function(){a(this).hasClass(d.theme.disabled)||d.dropdown.addClass(h)},"mouseleave.selectBoxIt":function(){d.dropdown.removeClass(h)},destroy:function(a){a.preventDefault(),a.stopPropagation()}}),d},_update:function(a){var b,c,d,e=this,f=e.options.defaultText||e.selectBox.attr("data-text"),g=e.listItems.eq(e.currentFocus);"false"===a.attr("data-disabled")&&(b=e.listItems.eq(e.currentFocus).attr("data-selectedtext"),c=g.attr("data-text"),d=c?c:g.text(),(f&&e.options.html?e.dropdownText.html()===f:e.dropdownText.text()===f)&&e.selectBox.val()===a.attr("data-val")?e.triggerEvent("change"):(e.selectBox.val(a.attr("data-val")),e.currentFocus=+a.attr("data-id"),e.originalElem.value!==e.dropdownText.attr("data-val")&&e.triggerEvent("change")))},_addClasses:function(a){var b=this,c=(b.focusClass=a.focus,b.hoverClass=a.hover,a.button),d=a.list,e=a.arrow,f=a.container;return b.openClass=a.open,b.selectedClass="selectboxit-selected",b.downArrow.addClass(b.selectBox.attr("data-downarrow")||b.options.downArrowIcon||e),b.dropdownContainer.addClass(f),b.dropdown.addClass(c),b.list.addClass(d),b},refresh:function(a,b){var c=this;return c._destroySelectBoxIt()._create(!0),b||c.triggerEvent("refresh"),c._callbackSupport(a),c},htmlEscape:function(a){return String(a).replace(/&/g,"&amp;").replace(/"/g,"&quot;").replace(/'/g,"&#39;").replace(/</g,"&lt;").replace(/>/g,"&gt;")},triggerEvent:function(a){var b=this,c=b.options.showFirstOption?b.currentFocus:b.currentFocus-1>=0?b.currentFocus:0;return b.selectBox.trigger(a,{selectbox:b.selectBox,selectboxOption:b.selectItems.eq(c),dropdown:b.dropdown,dropdownOption:b.listItems.eq(b.currentFocus)}),b},_copyAttributes:function(){var a=this;return a._addSelectBoxAttributes&&a._addSelectBoxAttributes(),a},_realOuterWidth:function(a){if(a.is(":visible"))return a.outerWidth(!0);var b,c=a.clone();return c.css({visibility:"hidden",display:"block",position:"absolute"}).appendTo("body"),b=c.outerWidth(!0),c.remove(),b}});var e=a.selectBox.selectBoxIt.prototype;e.add=function(b,c){this._populate(b,function(b){var d,e,f=this,g=a.type(b),h=0,i=[],j=f._isJSON(b),k=j&&f._parseJSON(b);if(b&&("array"===g||j&&k.data&&"array"===a.type(k.data))||"object"===g&&b.data&&"array"===a.type(b.data)){for(f._isJSON(b)&&(b=k),b.data&&(b=b.data),e=b.length;e-1>=h;h+=1)d=b[h],a.isPlainObject(d)?i.push(a("<option/>",d)):"string"===a.type(d)&&i.push(a("<option/>",{text:d,value:d}));f.selectBox.append(i)}else b&&"string"===g&&!f._isJSON(b)?f.selectBox.append(b):b&&"object"===g?f.selectBox.append(a("<option/>",b)):b&&f._isJSON(b)&&a.isPlainObject(f._parseJSON(b))&&f.selectBox.append(a("<option/>",f._parseJSON(b)));return f.dropdown?f.refresh(function(){f._callbackSupport(c)},!0):f._callbackSupport(c),f})},e._parseJSON=function(b){return JSON&&JSON.parse&&JSON.parse(b)||a.parseJSON(b)},e._isJSON=function(a){var b,c=this;try{return b=c._parseJSON(a),!0}catch(d){return!1}},e._populate=function(b,c){var d=this;return b=a.isFunction(b)?b.call():b,d.isDeferred(b)?b.done(function(a){c.call(d,a)}):c.call(d,b),d},e._ariaAccessibility=function(){var b=this,c=a("label[for='"+b.originalElem.id+"']");return b.dropdownContainer.attr({role:"combobox","aria-autocomplete":"list","aria-haspopup":"true","aria-expanded":"false","aria-owns":b.list[0].id}),b.dropdownText.attr({"aria-live":"polite"}),b.dropdown.on({"disable.selectBoxIt":function(){b.dropdownContainer.attr("aria-disabled","true")},"enable.selectBoxIt":function(){b.dropdownContainer.attr("aria-disabled","false")}}),c.length&&b.dropdownContainer.attr("aria-labelledby",c[0].id),b.list.attr({role:"listbox","aria-hidden":"true"}),b.listItems.attr({role:"option"}),b.selectBox.on({"open.selectBoxIt":function(){b.list.attr("aria-hidden","false"),b.dropdownContainer.attr("aria-expanded","true")},"close.selectBoxIt":function(){b.list.attr("aria-hidden","true"),b.dropdownContainer.attr("aria-expanded","false")}}),b},e._addSelectBoxAttributes=function(){var b=this;return b._addAttributes(b.selectBox.prop("attributes"),b.dropdown),b.selectItems.each(function(c){b._addAttributes(a(this).prop("attributes"),b.listItems.eq(c))}),b},e._addAttributes=function(b,c){var d=this,e=d.options.copyAttributes;return b.length&&a.each(b,function(b,d){var f=d.name.toLowerCase(),g=d.value;"null"===g||-1===a.inArray(f,e)&&-1===f.indexOf("data")||c.attr(f,g)}),d},e.destroy=function(a){var b=this;return b._destroySelectBoxIt(),b.widgetProto.destroy.call(b),b._callbackSupport(a),b},e._destroySelectBoxIt=function(){var b=this;return b.dropdown.off(".selectBoxIt"),a.contains(b.dropdownContainer[0],b.originalElem)&&b.dropdownContainer.before(b.selectBox),b.dropdownContainer.remove(),b.selectBox.removeAttr("style").attr("style",b.selectBoxStyles),b.triggerEvent("destroy"),b},e.disable=function(a){var b=this;return b.options.disabled||(b.close(),b.selectBox.attr("disabled","disabled"),b.dropdown.removeAttr("tabindex").removeClass(b.theme.enabled).addClass(b.theme.disabled),b.setOption("disabled",!0),b.triggerEvent("disable")),b._callbackSupport(a),b},e.disableOption=function(b,c){var d,e,f,g=this,h=a.type(b);return"number"===h&&(g.close(),d=g.selectBox.find("option").eq(b),g.triggerEvent("disable-option"),d.attr("disabled","disabled"),g.listItems.eq(b).attr("data-disabled","true").addClass(g.theme.disabled),g.currentFocus===b&&(e=g.listItems.eq(g.currentFocus).nextAll("li").not("[data-disabled='true']").first().length,f=g.listItems.eq(g.currentFocus).prevAll("li").not("[data-disabled='true']").first().length,e?g.moveDown():f?g.moveUp():g.disable())),g._callbackSupport(c),g},e._isDisabled=function(){var a=this;return a.originalElem.disabled&&a.disable(),a},e._dynamicPositioning=function(){var b=this;if("number"===a.type(b.listSize))b.list.css("max-height",b.maxHeight||"none");else{var c=b.dropdown.offset().top,d=b.list.data("max-height")||b.list.outerHeight(),e=b.dropdown.outerHeight(),f=b.options.viewport,g=f.height(),h=a.isWindow(f.get(0))?f.scrollTop():f.offset().top,i=g+h>=c+e+d,j=!i;if(b.list.data("max-height")||b.list.data("max-height",b.list.outerHeight()),j)if(b.dropdown.offset().top-h>=d)b.list.css("max-height",d),b.list.css("top",b.dropdown.position().top-b.list.outerHeight());else{var k=Math.abs(c+e+d-(g+h)),l=Math.abs(b.dropdown.offset().top-h-d);l>k?(b.list.css("max-height",d-k-e/2),b.list.css("top","auto")):(b.list.css("max-height",d-l-e/2),b.list.css("top",b.dropdown.position().top-b.list.outerHeight()))}else b.list.css("max-height",d),b.list.css("top","auto")}return b},e.enable=function(a){var b=this;return b.options.disabled&&(b.triggerEvent("enable"),b.selectBox.removeAttr("disabled"),b.dropdown.attr("tabindex",0).removeClass(b.theme.disabled).addClass(b.theme.enabled),b.setOption("disabled",!1),b._callbackSupport(a)),b},e.enableOption=function(b,c){var d,e=this,f=a.type(b);return"number"===f&&(d=e.selectBox.find("option").eq(b),e.triggerEvent("enable-option"),d.removeAttr("disabled"),e.listItems.eq(b).attr("data-disabled","false").removeClass(e.theme.disabled)),e._callbackSupport(c),e},e.moveDown=function(a){var b=this;b.currentFocus+=1;var c="true"===b.listItems.eq(b.currentFocus).attr("data-disabled")?!0:!1,d=b.listItems.eq(b.currentFocus).nextAll("li").not("[data-disabled='true']").first().length;if(b.currentFocus===b.listItems.length)b.currentFocus-=1;else{if(c&&d)return b.listItems.eq(b.currentFocus-1).blur(),b.moveDown(),void 0;c&&!d?b.currentFocus-=1:(b.listItems.eq(b.currentFocus-1).blur().end().eq(b.currentFocus).focusin(),b._scrollToView("down"),b.triggerEvent("moveDown"))}return b._callbackSupport(a),b},e.moveUp=function(a){var b=this;b.currentFocus-=1;var c="true"===b.listItems.eq(b.currentFocus).attr("data-disabled")?!0:!1,d=b.listItems.eq(b.currentFocus).prevAll("li").not("[data-disabled='true']").first().length;if(-1===b.currentFocus)b.currentFocus+=1;else{if(c&&d)return b.listItems.eq(b.currentFocus+1).blur(),b.moveUp(),void 0;c&&!d?b.currentFocus+=1:(b.listItems.eq(this.currentFocus+1).blur().end().eq(b.currentFocus).focusin(),b._scrollToView("up"),b.triggerEvent("moveUp"))}return b._callbackSupport(a),b},e._setCurrentSearchOption=function(a){var b=this;return(b.options.aggressiveChange||b.options.selectWhenHidden||b.listItems.eq(a).is(":visible"))&&b.listItems.eq(a).data("disabled")!==!0&&(b.listItems.eq(b.currentFocus).blur(),b.currentIndex=a,b.currentFocus=a,b.listItems.eq(b.currentFocus).focusin(),b._scrollToView("search"),b.triggerEvent("search")),b},e._searchAlgorithm=function(a,b){var c,d,e,f,g=this,h=!1,i=g.textArray,j=g.currentText;for(c=a,e=i.length;e>c;c+=1){for(f=i[c],d=0;e>d;d+=1)-1!==i[d].search(b)&&(h=!0,d=e);if(h||(g.currentText=g.currentText.charAt(g.currentText.length-1).replace(/[|()\[{.+*?$\\]/g,"\\$0"),j=g.currentText),b=new RegExp(j,"gi"),j.length<3){if(b=new RegExp(j.charAt(0),"gi"),-1!==f.charAt(0).search(b))return g._setCurrentSearchOption(c),(f.substring(0,j.length).toLowerCase()!==j.toLowerCase()||g.options.similarSearch)&&(g.currentIndex+=1),!1}else if(-1!==f.search(b))return g._setCurrentSearchOption(c),!1;if(f.toLowerCase()===g.currentText.toLowerCase())return g._setCurrentSearchOption(c),g.currentText="",!1}return!0},e.search=function(a,b,c){var d=this;c?d.currentText+=a.replace(/[|()\[{.+*?$\\]/g,"\\$0"):d.currentText=a.replace(/[|()\[{.+*?$\\]/g,"\\$0");var e=d._searchAlgorithm(d.currentIndex,new RegExp(d.currentText,"gi"));return e&&d._searchAlgorithm(0,d.currentText),d._callbackSupport(b),d},e._updateMobileText=function(){var a,b,c,d=this;a=d.selectBox.find("option").filter(":selected"),b=a.attr("data-text"),c=b?b:a.text(),d._setText(d.dropdownText,c),d.list.find('li[data-val="'+a.val()+'"]').find("i").attr("class")&&d.dropdownImage.attr("class",d.list.find('li[data-val="'+a.val()+'"]').find("i").attr("class")).addClass("selectboxit-default-icon")},e._applyNativeSelect=function(){var a=this;return a.dropdownContainer.append(a.selectBox),a.dropdown.attr("tabindex","-1"),a.selectBox.css({display:"block",visibility:"visible",width:a._realOuterWidth(a.dropdown),height:a.dropdown.outerHeight(),opacity:"0",position:"absolute",top:"0",left:"0",cursor:"pointer","z-index":"999999",margin:a.dropdown.css("margin"),padding:"0","-webkit-appearance":"menulist-button"}),a.originalElem.disabled&&a.triggerEvent("disable"),this},e._mobileEvents=function(){var a=this;a.selectBox.on({"changed.selectBoxIt":function(){a.hasChanged=!0,a._updateMobileText(),a.triggerEvent("option-click")},"mousedown.selectBoxIt":function(){a.hasChanged||!a.options.defaultText||a.originalElem.disabled||(a._updateMobileText(),a.triggerEvent("option-click"))},"enable.selectBoxIt":function(){a.selectBox.removeClass("selectboxit-rendering")},"disable.selectBoxIt":function(){a.selectBox.addClass("selectboxit-rendering")}})},e._mobile=function(){var a=this;return a.isMobile&&(a._applyNativeSelect(),a._mobileEvents()),this},e.remove=function(b,c){var d,e,f=this,g=a.type(b),h=0,i="";if("array"===g){for(e=b.length;e-1>=h;h+=1)d=b[h],"number"===a.type(d)&&(i+=i.length?", option:eq("+d+")":"option:eq("+d+")");f.selectBox.find(i).remove()}else"number"===g?f.selectBox.find("option").eq(b).remove():f.selectBox.find("option").remove();return f.dropdown?f.refresh(function(){f._callbackSupport(c)},!0):f._callbackSupport(c),f},e.selectOption=function(b,c){var d=this,e=a.type(b);return"number"===e?d.selectBox.val(d.selectItems.eq(b).val()).change():"string"===e&&d.selectBox.val(b).change(),d._callbackSupport(c),d},e.setOption=function(b,c,d){var e=this;return"string"===a.type(b)&&(e.options[b]=c),e.refresh(function(){e._callbackSupport(d)},!0),e},e.setOptions=function(b,c){var d=this;return a.isPlainObject(b)&&(d.options=a.extend({},d.options,b)),d.refresh(function(){d._callbackSupport(c)},!0),d},e.wait=function(a,b){var c=this;return c.widgetProto._delay.call(c,b,a),c}});
</script>


<!---<script charset="utf-8">

$('form').submit(function(){
	alert($(this["options"]).val());
    return false;
});
</script>--->

<!---<script charset="utf-8">
  //Make panels dragable
  jQuery(function($) {
      var panelList = $('.s-j-draggablePanelList');

      panelList.sortable({
          // Only make the .panel-heading child elements support dragging.
          // Omit this to make then entire <li>...</li> draggable.
          handle: '.s-pannel-name',
          update: function() {
              $('.s-pannel-name', panelList).each(function(index, elem) {
                   var $listItem = $(elem),
                       newIndex = $listItem.index();

                   // Persist the new indices.
              });
          }
      });
  });
</script>--->

<!---<script charset="utf-8">
  //Dragable pannel for filters
  $('.s-j-draggablePanelList .btn-group a').click(function(e){
    e.preventDefault();
    if($(this).hasClass('s-sort')){
      $(this).children('i').toggle();
    }else{
      $(this).toggleClass('active');
    };
  });
</script>--->

<script charset="utf-8">
  //Remove sortable items and add message when none are left
  $('.s-remove').click(function(){
    $(this).closest('.list-group-item').remove();
    if($('.s-j-draggablePanelList .list-group-item').length < 1){$('.s-none-selected').show()};
  });
</script>
<script charset="utf-8">
  //Sort filter - rename header
  $('.list-group-item .s-pannel-name .s-pannel-title').click(function(){
    $(this).fadeToggle('fast');
    $(this).siblings(".s-title-edit-menu").toggle('slide', { direction: 'left' }, 300);
  });
  $('.list-group-item .s-pannel-name .s-save-btn').click(function(){
    $(this).parent().siblings('.s-pannel-title').fadeToggle();
    $(this).parent().toggle('slide', { direction: 'left' }, 300);
  });
</script>

<script charset="utf-8">
  // Trigger select option to open collapes
  $('document').ready(function(){
    $('.accordion-dropdown').on('change', function(e){
      var collapseOptions = $(this).val();
      $('.s-batch-options.in').collapse('hide');
      $('#' + collapseOptions).collapse('show');
      $('.s-filter-table-box input[type="checkbox"]').prop('checked', true);
    });
  });
</script>


<!--- Add new default font --->
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,800,700' rel='stylesheet' type='text/css'>


<!---If you uncomment this content you will be able to drag table columns to sort them
<style media="screen">
  .dragtable-sortable { list-style-type: none; margin: 0; padding: 0; -moz-user-select: none;}
  .dragtable-sortable li {float: left; background: white;}
  .dragtable-sortable th, .dragtable-sortable td{border-left: 0px;}
  .dragtable-sortable li:first-child th, .dragtable-sortable li:first-child td {border-left: 1px solid #CCC;}
  .ui-sortable-helper {opacity: 0.7;filter: alpha(opacity=70);}
  .ui-sortable-placeholder {-moz-box-shadow: 4px 5px 4px #C6C6C6 inset;-webkit-box-shadow: 4px 5px 4px #C6C6C6 inset;box-shadow: 4px 5px 4px #C6C6C6 inset;border-bottom: 1px solid #CCCCCC;border-top: 1px solid #CCCCCC;visibility: visible !important;background: #EFEFEF !important;visibility: visible !important;}
  .ui-sortable-placeholder * {opacity: 0.0; visibility: hidden;}
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<script charset="utf-8">
  (function(e){function r(){var t=e('<style id="__dragtable_disable_text_selection__" type="text/css">body { -ms-user-select:none;-moz-user-select:-moz-none;-khtml-user-select:none;-webkit-user-select:none;user-select:none; }</style>');e(document.head).append(t);e(document.body).attr("onselectstart","return false;").attr("unselectable","on");if(window.getSelection){window.getSelection().removeAllRanges()}else{document.selection.empty()}}function i(){e("#__dragtable_disable_text_selection__").remove();if(t){e(document.body).attr("onselectstart",t)}else{e(document.body).removeAttr("onselectstart")}if(n){e(document.body).attr("unselectable",n)}else{e(document.body).removeAttr("unselectable")}}function s(e,t){var n=e.parentNode;var r=e.nextSibling===t?e:e.nextSibling;t.parentNode.insertBefore(e,t);n.insertBefore(t,r)}e.widget("akottr.dragtable",{options:{revert:false,dragHandle:".table-handle",maxMovingRows:40,excludeFooter:false,onlyHeaderThreshold:100,dragaccept:null,persistState:null,restoreState:null,exact:true,clickDelay:10,containment:null,cursor:"move",cursorAt:false,distance:0,tolerance:"pointer",axis:"x",beforeStart:e.noop,beforeMoving:e.noop,beforeReorganize:e.noop,beforeStop:e.noop},originalTable:{el:null,selectedHandle:null,sortOrder:null,startIndex:0,endIndex:0},sortableTable:{el:e(),selectedHandle:e(),movingRow:e()},persistState:function(){var t=this;this.originalTable.el.find("th").each(function(e){if(this.id!==""){t.originalTable.sortOrder[this.id]=e}});e.ajax({url:this.options.persistState,data:this.originalTable.sortOrder})},_restoreState:function(t){for(var n in t){this.originalTable.startIndex=e("#"+n).closest("th").prevAll().size()+1;this.originalTable.endIndex=parseInt(t[n]+1,10);this._bubbleCols()}},_bubbleCols:function(){var e,t,n,r;var i=this.originalTable.startIndex;var o=this.originalTable.endIndex;var u=this.originalTable.el.children();if(this.options.excludeFooter){u=u.not("tfoot")}if(i<o){for(e=i;e<o;e++){n=u.find("> tr > td:nth-child("+e+")").add(u.find("> tr > th:nth-child("+e+")"));r=u.find("> tr > td:nth-child("+(e+1)+")").add(u.find("> tr > th:nth-child("+(e+1)+")"));for(t=0;t<n.length;t++){s(n[t],r[t])}}}else{for(e=i;e>o;e--){n=u.find("> tr > td:nth-child("+e+")").add(u.find("> tr > th:nth-child("+e+")"));r=u.find("> tr > td:nth-child("+(e-1)+")").add(u.find("> tr > th:nth-child("+(e-1)+")"));for(t=0;t<n.length;t++){s(n[t],r[t])}}}},_rearrangeTableBackroundProcessing:function(){var t=this;return function(){t._bubbleCols();t.options.beforeStop(t.originalTable);t.sortableTable.el.remove();i();if(t.options.persistState!==null){e.isFunction(t.options.persistState)?t.options.persistState(t.originalTable):t.persistState()}}},_rearrangeTable:function(){var e=this;return function(){e.originalTable.selectedHandle.removeClass("dragtable-handle-selected");e.sortableTable.el.sortable("disable");e.sortableTable.el.addClass("dragtable-disabled");e.options.beforeReorganize(e.originalTable,e.sortableTable);e.originalTable.endIndex=e.sortableTable.movingRow.prevAll().size()+1;setTimeout(e._rearrangeTableBackroundProcessing(),50)}},_generateSortable:function(t){!t.cancelBubble&&(t.cancelBubble=true);var n=this;var i=this.originalTable.el[0].attributes;var s="";for(var o=0;o<i.length;o++){if(i[o].nodeValue&&i[o].nodeName!="id"&&i[o].nodeName!="width"){s+=i[o].nodeName+'="'+i[o].nodeValue+'" '}}var u=[];var a=[];this.originalTable.el.find("tr").slice(0,this.options.maxMovingRows).each(function(t,n){var r=this.attributes;var i="";for(var s=0;s<r.length;s++){if(r[s].nodeValue&&r[s].nodeName!="id"){i+=" "+r[s].nodeName+'="'+r[s].nodeValue+'"'}}u.push(i);a.push(e(this).height())});var f=[];var l=0;var c=n.originalTable.el.children();if(this.options.excludeFooter){c=c.not("tfoot")}c.find("> tr > th").each(function(t,n){var r=e(this).outerWidth();f.push(r);l+=r});if(n.options.exact){var h=l-n.originalTable.el.outerWidth();f[0]-=h}l+=2;var p='<ul class="dragtable-sortable" style="position:absolute; width:'+l+'px;">';c.find("> tr > th").each(function(t,r){p+="<li>";p+="<table "+s+">";var i=c.find("> tr > th:nth-child("+(t+1)+")");if(n.options.maxMovingRows>1){i=i.add(c.find("> tr > td:nth-child("+(t+1)+")").slice(0,n.options.maxMovingRows-1))}i.each(function(t){var n=e(this).clone().wrap("<div></div>").parent().html();if(n.toLowerCase().indexOf("<th")===0)p+="<thead>";p+="<tr "+u[t]+'" style="height:'+a[t]+'px;">';p+=n;if(n.toLowerCase().indexOf("<th")===0)p+="</thead>";p+="</tr>"});p+="</table>";p+="</li>"});p+="</ul>";this.sortableTable.el=this.originalTable.el.before(p).prev();this.sortableTable.el.find("> li > table").each(function(t,n){e(this).css("width",f[t]+"px")});this.sortableTable.selectedHandle=this.sortableTable.el.find("th .dragtable-handle-selected");var d=!this.options.dragaccept?"li":"li:has("+this.options.dragaccept+")";this.sortableTable.el.sortable({items:d,stop:this._rearrangeTable(),revert:this.options.revert,tolerance:this.options.tolerance,containment:this.options.containment,cursor:this.options.cursor,cursorAt:this.options.cursorAt,distance:this.options.distance,axis:this.options.axis});this.originalTable.startIndex=e(t.target).closest("th").prevAll().size()+1;this.options.beforeMoving(this.originalTable,this.sortableTable);this.sortableTable.movingRow=this.sortableTable.el.find("> li:nth-child("+this.originalTable.startIndex+")");r();this.sortableTable.movingRow.trigger(e.extend(e.Event(t.type),{which:1,clientX:t.clientX,clientY:t.clientY,pageX:t.pageX,pageY:t.pageY,screenX:t.screenX,screenY:t.screenY}));var v=this.sortableTable.el.find(".ui-sortable-placeholder");if(!v.height()<=0){v.css("height",this.sortableTable.el.find(".ui-sortable-helper").height())}v.html('<div class="outer" style="height:100%;"><div class="inner" style="height:100%;"></div></div>')},bindTo:{},_create:function(){this.originalTable={el:this.element,selectedHandle:e(),sortOrder:{},startIndex:0,endIndex:0};this.bindTo=this.originalTable.el.find("th");if(this.options.dragaccept){this.bindTo=this.bindTo.filter(this.options.dragaccept)}if(this.bindTo.find(this.options.dragHandle).size()>0){this.bindTo=this.bindTo.find(this.options.dragHandle)}if(this.options.restoreState!==null){e.isFunction(this.options.restoreState)?this.options.restoreState(this.originalTable):this._restoreState(this.options.restoreState)}var t=this;this.bindTo.mousedown(function(n){if(n.which!==1)return;if(t.options.beforeStart(t.originalTable)===false){return}clearTimeout(this.downTimer);this.downTimer=setTimeout(function(){t.originalTable.selectedHandle=e(this);t.originalTable.selectedHandle.addClass("dragtable-handle-selected");t._generateSortable(n)},t.options.clickDelay)}).mouseup(function(e){clearTimeout(this.downTimer)})},redraw:function(){this.destroy();this._create()},destroy:function(){this.bindTo.unbind("mousedown");e.Widget.prototype.destroy.apply(this,arguments)}});var t=e(document.body).attr("onselectstart"),n=e(document.body).attr("unselectable")})(jQuery)
</script>
<script charset="utf-8">
$(document).ready(function() {
  $('.table-striped').dragtable();
});
</script>--->
