<?xml version="1.0"?>
<!--
Snap Websites Server == white layout body parser
Copyright (c) 2014-2018  Made to Order Software Corp.  All Rights Reserved

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
	<xsl:variable name="layout-name">white</xsl:variable>
	<xsl:variable name="layout-area">body-parser</xsl:variable>
	<xsl:variable name="layout-modified">2012-11-10 3:52:39</xsl:variable>
	<xsl:param name="year" select="year-from-date(current-date())"/>
	<xsl:param name="use_dcterms">yes</xsl:param>
	<!-- get the website URI (i.e. URI without any folder other than the website base folder) -->
	<xsl:variable name="website_uri" as="xs:string">
		<xsl:for-each select="snap">
			<xsl:value-of select="head/metadata/desc[@type='website_uri']/data"/>
		</xsl:for-each>
	</xsl:variable>
	<!-- compute the protocol from the main URI -->
	<xsl:variable name="protocol" as="xs:string">
		<xsl:value-of select="substring-before($website_uri, '://')"/>
	</xsl:variable>
	<!-- compute the domain from the main URI -->
	<xsl:variable name="domain" as="xs:string">
		<xsl:choose>
			<xsl:when test="contains($website_uri, '://www.')">
				<xsl:value-of select="substring-before(substring-after($website_uri, '://www.'), '/')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring-before(substring-after($website_uri, '://'), '/')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- get the base URI (i.e. parent URI to this page) -->
	<xsl:variable name="base_uri" as="xs:string">
		<xsl:for-each select="snap">
			<xsl:value-of select="head/metadata/desc[@type='base_uri']/data"/>
		</xsl:for-each>
	</xsl:variable>
	<!-- compute the path from the main URI to this page -->
	<xsl:variable name="path" as="xs:string">
		<xsl:value-of select="substring-after($base_uri, $website_uri)"/>
	</xsl:variable>
	<!-- compute the full path from the main URI to this page -->
	<xsl:variable name="full_path" as="xs:string">
		<xsl:value-of select="concat(substring-after(substring-after($website_uri, '://'), '/'), $path)"/>
	</xsl:variable>
	<!-- get the page URI (i.e. the full path to this page) -->
	<xsl:variable name="page_uri" as="xs:string">
		<xsl:for-each select="snap">
			<xsl:value-of select="head/metadata/desc[@type='page_uri']/data"/>
		</xsl:for-each>
	</xsl:variable>
	<!-- compute the full path from the main URI to this page -->
	<xsl:variable name="page" as="xs:string">
		<xsl:value-of select="substring-after($page_uri, $base_uri)"/>
	</xsl:variable>
	<!-- get the year the page was created -->
	<xsl:variable name="created_year" select="year-from-date(snap/page/body/created)"/>
	<xsl:variable name="year_range">
		<xsl:value-of select="$created_year"/><xsl:if test="$created_year != xs:integer($year)">-<xsl:value-of select="$year"/></xsl:if>
	</xsl:variable>
	<!-- get the page language -->
	<xsl:variable name="lang">
		<xsl:choose><!-- make sure we get some language, we default to English -->
			<xsl:when test="snap/page/body/lang"><xsl:value-of select="snap/page/body/lang"/></xsl:when>
			<xsl:otherwise>en</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<!-- transform the specified path in a full path as required -->
	<xsl:function name="snap:prepend-base" as="xs:string">
		<xsl:param name="website_uri" as="xs:string"/>
		<xsl:param name="base_uri" as="xs:string"/>
		<xsl:param name="path" as="xs:string"/>
		<xsl:variable name="lpath"><xsl:value-of select="lower-case($path)"/></xsl:variable>

		<xsl:choose>
			<xsl:when test="matches($lpath, '^[a-z]+://')">
				<!-- full path, use as is -->
				<xsl:value-of select="$path"/>
			</xsl:when>
			<xsl:when test="starts-with($lpath, '/')">
				<!-- root path, use with website URI -->
				<xsl:value-of select="concat($website_uri, substring($path, 2))"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- relative path, use with base URI -->
				<xsl:value-of select="concat($base_uri, $path)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!--xsl:template name="snap:content" match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template-->

	<xsl:template match="snap">
		<!-- circumvent a QXmlQuery bug, if global variables are not accessed
		     at least once then they may appear as undefined in a function. -->
		<!--xsl:if test="$base_uri != ''"></xsl:if>
		<xsl:if test="$website_uri != ''"></xsl:if-->

		<output lang="{$lang}">
			<div id="content">
			<xsl:copy-of select="page/body/content/*"/>
			</div>
			<div id="footer">White Footer</div>
			<!--div id="content2">
			<xsl:for-each select="page/body/content/*">
				<xsl:call-template name="snap:content"/>
			</xsl:for-each>
			</div-->
		</output>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: ts=2 sw=2
-->
