﻿/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.filebrowserBrowseUrl = $.slatwall.getConfig()['baseURL'] + '/org/Hibachi/ckfinder/ckfinder.html';
	config.filebrowserImageBrowseUrl = $.slatwall.getConfig()['baseURL'] + '/org/Hibachi/ckfinder/ckfinder.html?Type=Images';
	config.filebrowserUploadUrl = $.slatwall.getConfig()['baseURL'] + '/org/Hibachi/ckfinder/core/connector/cfm/connector.cfm?command=QuickUpload&type=Files';
	config.filebrowserImageUploadUrl = $.slatwall.getConfig()['baseURL'] + '/org/Hibachi/ckfinder/core/connector/cfm/connector.cfm?command=QuickUpload&type=Images';
};
