<cfimport prefix="swa" taglib="../../../../tags" />
<cfimport prefix="hb" taglib="../../../../org/Hibachi/HibachiTags" />
<form></form>
<span ng-controller="create-bundle-controller">
	  <section class="col-xs-12" ng-if="product.defaultSku.productBundleGroups">
			<form name="form.createProductBundle">
				<span ng-init="setForm(form.createProductBundle)"></span>
				<input type="hidden" ng-model="product.productID">
			    <span
			    		sw-product-bundle-groups
			    		data-product-bundle-groups="product.defaultSku.productBundleGroups"
			    >
			    </span>
			    <button class="btn btn-sm s-btn-grey s-create-bundle-btn"
			    		data-toggle="collapse"
			    		ng-click="addProductBundleGroup()"
			    >
			    	<i class="fa fa-plus"></i> Bundle Group
			    </button>
			    <ul class="nav navbar-nav pull-right">
			        <li class="active">
			        	<a  ng-href="#" style="padding: 9px 12px;font-size: 16px;"
			        		ng-click="saveProductBundle()"
			        	>Save & New</a>
			        </li>
			    </ul>
	   		</form>
	  </section>

</span>
