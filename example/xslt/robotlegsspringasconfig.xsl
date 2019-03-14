<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rsas="https://github.com/dborisenko/robotlegs-spring-actionscript/raw/master/schema/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="https://github.com/dborisenko/robotlegs-spring-actionscript/raw/master/schema/
                https://github.com/dborisenko/robotlegs-spring-actionscript/raw/master/schema/robotlegs-spring-actionscript-1.0.xsd "
	exclude-result-prefixes="xsi rsas">
	<xsl:output method="xml" indent="yes" />
	<xsl:key name="mapsignalclass" match="//rsas:map-signal" use="@signal-class" />
	<xsl:key name="mapcommandclass" match="//rsas:map-signal" use="@command-class" />
	<xsl:key name="mapviewclass" match="//rsas:map-view" use="@view-class" />
	<xsl:key name="mapmediatorclass" match="//rsas:map-view" use="@mediator-class" />
	<xsl:key name="mapviewas" match="//rsas:map-view" use="@inject-view-as" />
	
	<xsl:template match="/">
		<flex-config>
			<includes append="true">
				<xsl:for-each
					select="//rsas:map-signal[count(.|key('mapsignalclass',@signal-class)[1]) = 1]">
					<xsl:sort select="@signal-class" />
					<xsl:if test="@signal-class!=''">
						<symbol>
							<xsl:value-of select="@signal-class" />
						</symbol>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each
					select="//rsas:map-signal[count(.|key('mapcommandclass',@command-class)[1]) = 1]">
					<xsl:sort select="@command-class" />
					<xsl:if test="@command-class!=''">
						<symbol>
							<xsl:value-of select="@command-class" />
						</symbol>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each
					select="//rsas:map-view[count(.|key('mapviewclass',@view-class)[1]) = 1]">
					<xsl:sort select="@view-class" />
					<xsl:if test="@view-class!=''">
						<symbol>
							<xsl:value-of select="@view-class" />
						</symbol>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each
					select="//rsas:map-view[count(.|key('mapmediatorclass',@mediator-class)[1]) = 1]">
					<xsl:sort select="@mediator-class" />
					<xsl:if test="@mediator-class!=''">
						<symbol>
							<xsl:value-of select="@mediator-class" />
						</symbol>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each
					select="//rsas:map-view[count(.|key('mapviewas',@inject-view-as)[1]) = 1]">
					<xsl:sort select="@inject-view-as" />
					<xsl:if test="@inject-view-as!=''">
						<symbol>
							<xsl:value-of select="@inject-view-as" />
						</symbol>
					</xsl:if>
				</xsl:for-each>
			</includes>
		</flex-config>
	</xsl:template>
</xsl:stylesheet>