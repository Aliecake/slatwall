<?xml version="1.0" encoding="UTF-8"?>
<Table tableName="SwCollection">
	<Columns>
		<column name="collectionID" fieldtype="id" />
		<column name="collectionName" />
		<column name="collectionObject" update="false" />
		<column name="collectionConfig" update="false" />
		<column name="reportFlag" update="true" />
	</Columns>
	<Records>
		<!--Average order value-->
		<Record collectionID='2c92808362e398b10162e4c489b5000x' collectionName='Average Order Value by Month' collectionObject='Order' collectionConfig='{"baseEntityAlias":"_order","baseEntityName":"Order","columns":[{"isDeletable":false,"isSearchable":false,"ormtype":"string","title":"Order ID","isVisible":false,"propertyIdentifier":"_order.orderID","type":"none","isExportable":false,"sorting":{"active":false,"sortOrder":"asc","priority":0}},{"title":"Total Average","propertyIdentifier":"_order.calculatedTotal","isVisible":true,"isDeletable":true,"isSearchable":true,"isExportable":true,"ormtype":"string","type":"currency","aggregate":{"aggregateFunction":"AVERAGE","aggregateAlias":"calculatedTotalAverage"},"sorting":{"active":false,"sortOrder":"asc","priority":0},"isMetric":true}],"keywordColumns":[],"filterGroups":[{"filterGroup":[{"comparisonOperator":"IN","ormtype":"string","value":"ostNew,ostProcessing,ostOnHold,ostClosed,ostCanceled","hidden":true,"propertyIdentifier":"_order_orderStatusType.systemCode","breadCrumbs":[{"rbKey":"Order","entityAlias":"_order_orderStatusType","cfc":"_order_orderStatusType","propertyIdentifier":"_order_orderStatusType"}]}]}],"currentPage":1,"pageShow":10,"defaultColumns":false,"dirtyRead":false}' reportFlag='1'/>
		<Record collectionID='2c92808362e398b10162e4c3b3d1000b' collectionName='Average Order Value by Week' collectionObject='Order' collectionConfig='{"baseEntityAlias":"_order","baseEntityName":"Order","columns":[{"isDeletable":false,"isSearchable":false,"ormtype":"string","title":"Order ID","isVisible":false,"propertyIdentifier":"_order.orderID","type":"none","isExportable":false,"sorting":{"active":false,"sortOrder":"asc","priority":0}},{"title":"Total Average","propertyIdentifier":"_order.calculatedTotal","isVisible":true,"isDeletable":true,"isSearchable":true,"isExportable":true,"ormtype":"string","type":"currency","aggregate":{"aggregateFunction":"AVERAGE","aggregateAlias":"calculatedTotalAverage"},"sorting":{"active":false,"sortOrder":"asc","priority":0},"isMetric":true}],"keywordColumns":[],"filterGroups":[{"filterGroup":[{"comparisonOperator":"IN","ormtype":"string","value":"ostNew,ostProcessing,ostOnHold,ostClosed,ostCanceled","hidden":true,"propertyIdentifier":"_order_orderStatusType.systemCode","breadCrumbs":[{"rbKey":"Order","entityAlias":"_order_orderStatusType","cfc":"_order_orderStatusType","propertyIdentifier":"_order_orderStatusType"}]}]}],"currentPage":1,"pageShow":10,"defaultColumns":false,"dirtyRead":false}' reportFlag='1'/>
		<Record collectionID='2c92808362e398b10162e4ba71ab000a' collectionName='Average Order Value by Day' collectionObject='Order' collectionConfig='{"baseEntityAlias":"_order","baseEntityName":"Order","columns":[{"isDeletable":false,"isSearchable":false,"ormtype":"string","title":"Order ID","isVisible":false,"sorting":{"sortOrder":"asc","active":false,"priority":0},"propertyIdentifier":"_order.orderID","type":"none","isExportable":false},{"isDeletable":true,"aggregate":{"aggregateAlias":"calculatedTotalAverage","aggregateFunction":"AVERAGE"},"isSearchable":true,"isMetric":true,"title":"Total Average","isVisible":true,"ormtype":"string","sorting":{"sortOrder":"asc","active":false,"priority":0},"propertyIdentifier":"_order.calculatedTotal","isExportable":true,"type":"currency"}],"keywordColumns":[],"filterGroups":[{"filterGroup":[{"breadCrumbs":[{"cfc":"_order_orderStatusType","entityAlias":"_order_orderStatusType","propertyIdentifier":"_order_orderStatusType","rbKey":"Order"}],"comparisonOperator":"IN","ormtype":"string","value":"ostNew,ostProcessing,ostOnHold,ostClosed,ostCanceled","hidden":true,"propertyIdentifier":"_order_orderStatusType.systemCode"}]}],"currentPage":1,"pageShow":10,"defaultColumns":false,"dirtyRead":false}' reportFlag='1'/>
	</Records>
</Table>