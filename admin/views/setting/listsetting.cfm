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
<cfoutput>
	<cf_SlatwallActionBar type="static" />

	<cf_SlatwallSettingTable>
		<cf_SlatwallSetting settingName="globalCurrencyLocale" />
		<cf_SlatwallSetting settingName="globalCurrencyType" />
		<cf_SlatwallSetting settingName="globalDateFormat" />
		<cf_SlatwallSetting settingName="globalEncryptionKeySize" />
		<cf_SlatwallSetting settingName="globalEncryptionKeyLocation" />
		<cf_SlatwallSetting settingName="globalEncryptionKeyGenerator" />
		<cf_SlatwallSetting settingName="globalLogMessages" />
		<cf_SlatwallSetting settingName="globalRemoteIDShowFlag" />
		<cf_SlatwallSetting settingName="globalRemoteIDEditFlag" />
		<cf_SlatwallSetting settingName="globalTimeFormat" />
		<cf_SlatwallSetting settingName="globalMissingImagePath" />
		<cf_SlatwallSetting settingName="globalImageExtension" />
		<cf_SlatwallSetting settingName="globalOrderPlacedEmailFrom" />
		<cf_SlatwallSetting settingName="globalOrderPlacedEmailCC" />
		<cf_SlatwallSetting settingName="globalOrderPlacedEmailBCC" />
		<cf_SlatwallSetting settingName="globalOrderPlacedEmailSubjectString" />
		<cf_SlatwallSetting settingName="globalOrderNumberGeneration" />
		<cf_SlatwallSetting settingName="globalUseProductCacheFlag" />
		<cf_SlatwallSetting settingName="globalURLKeyBrand" />
		<cf_SlatwallSetting settingName="globalURLKeyProduct" />
		<cf_SlatwallSetting settingName="globalURLKeyProductType" />
		<cf_SlatwallSetting settingName="globalWeightUnitCode" />
		<cf_SlatwallSetting settingName="brandDisplayTemplate" />
		<cf_SlatwallSetting settingName="productDisplayTemplate" />
		<cf_SlatwallSetting settingName="productImageSmallWidth" />
		<cf_SlatwallSetting settingName="productImageSmallHeight" />
		<cf_SlatwallSetting settingName="productImageMediumWidth" />
		<cf_SlatwallSetting settingName="productImageMediumHeight" />
		<cf_SlatwallSetting settingName="productImageLargeWidth" />
		<cf_SlatwallSetting settingName="productImageLargeHeight" />
		<cf_SlatwallSetting settingName="skuOrderMinimumQuantity" />
		<cf_SlatwallSetting settingName="skuOrderMaximumQuantity" />
		<cf_SlatwallSetting settingName="productTitleString" />
		<cf_SlatwallSetting settingName="productTypeDisplayTemplate" />
		<cf_SlatwallSetting settingName="skuEligablePaymentMethods" />
		<cf_SlatwallSetting settingName="skuEligableOrderOrigins" />
	</cf_SlatwallSettingTable>
</cfoutput>
