<!---

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

--->
<cfparam name="rc.setting" type="any">
<cfparam name="rc.settingName" type="string">
<cfparam name="rc.edit" type="boolean">

<cfparam name="rc.brandID" default="" />
<cfparam name="rc.productTypeID" default="" />
<cfparam name="rc.productID" default="" />
<cfparam name="rc.skuID" default="" />

<cfset local.returnActionQueryString="productID=#rc.productID#&brandID=#rc.brandID#&productTypeID=#rc.productTypeID#&skuID=#rc.skuID#" />

<!--- This logic set the setting name if the setting entity is new --->
<cfset rc.setting.setSettingName(rc.settingName) />

<cfoutput>
	<cf_SlatwallDetailForm object="#rc.setting#" edit="#rc.edit#" saveActionQueryString="#local.returnActionQueryString#">
		<cf_SlatwallActionBar type="detail" object="#rc.setting#" />
		
		<input type="hidden" name="settingName" value="#rc.settingName#" />
		
		<input type="hidden" name="brand.brandID" value="#rc.brandID#" /> 
		<input type="hidden" name="productType.productTypeID" value="#rc.productTypeID#" />
		<input type="hidden" name="product.productID" value="#rc.productID#" />
		<input type="hidden" name="sku.skuID" value="#rc.skuID#" />
		
		<cf_SlatwallDetailHeader>
			<cf_SlatwallPropertyList>
				<cf_SlatwallPropertyDisplay object="#rc.setting#" property="settingValue" edit="#rc.edit#">
			</cf_SlatwallPropertyList>
			<cfif !rc.setting.isNew() && (len(rc.brandID) || len(rc.productTypeID) || len(rc.productID) || len(rc.skuID))>
				<cf_SlatwallActionCaller action="admin:setting.deletesetting" queryString="settingID=#rc.setting.getSettingID()#&returnAction=#request.context.returnAction#&#local.returnActionQueryString#" class="btn btn-danger" />
			</cfif>
		</cf_SlatwallDetailHeader>
	</cf_SlatwallDetailForm>
</cfoutput>
