<?xml version="1.0"?>
<!--
Snap Websites Server == bookkeeping add client form parser
Copyright (c) 2016-2018  Made to Order Software Corp.  All Rights Reserved

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
															xmlns:xs="http://www.w3.org/2001/XMLSchema"
															xmlns:fn="http://www.w3.org/2005/xpath-functions"
															xmlns:snap="snap:snap">

	<!-- some special variables to define the theme -->
	<xsl:variable name="layout-area">bookkeeping-add-client-parser</xsl:variable>
	<xsl:variable name="layout-modified">2016-01-10 02:17:47</xsl:variable>
	<xsl:variable name="layout-editor">bookkeeping-add-client-page</xsl:variable>

	<xsl:template match="snap">
		<output> <!-- lang="{$lang}" 'lang variable undefined' -->
			<div class="editor-form" form_name="bookkeeping_add_client">
				<xsl:attribute name="session"><xsl:value-of select="page/body/editor/session/div/div/node()"/></xsl:attribute>
				<xsl:attribute name="timeout"><xsl:value-of select="page/body/editor/timeout/div/div/node()"/></xsl:attribute>

				<div class="editor-block">
					<label for="client_name" class="editor-title">Name:</label>
					<xsl:copy-of select="page/body/bookkeeping/client_name/node()"/>
				</div>
				<div class="editor-block">
					<label for="client_name" class="editor-title">Address:</label>
					<xsl:copy-of select="page/body/bookkeeping/client_address1/node()"/>
				</div>
				<div class="editor-block">
					<label for="client_name" class="editor-title city">City:</label>
					<label for="client_name" class="editor-title state">State:</label>
					<label for="client_name" class="editor-title zip">Zip:</label>
					<xsl:copy-of select="page/body/bookkeeping/client_city/node()"/>
					<xsl:copy-of select="page/body/bookkeeping/client_state/node()"/>
					<xsl:copy-of select="page/body/bookkeeping/client_zip/node()"/>
				</div>

				<div class="buttons">
					<a class="bookkeeping-button cancel-button" href="#cancel">Cancel</a>
					<a class="bookkeeping-button save-button editor-default-button" href="#save">Save</a>
				</div>

			</div>

			<css name="bookkeeping"/>
			<javascript name="bookkeeping-add-client"/>
		</output>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: ts=2 sw=2
-->
