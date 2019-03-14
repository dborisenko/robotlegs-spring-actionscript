<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:springas="http://www.springactionscript.org/schema/objects"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springactionscript.org/schema/objects
                http://www.springactionscript.org/schema/objects/spring-actionscript-objects-1.0.xsd "
	exclude-result-prefixes="xsi springas">
	<xsl:output method="xml" indent="yes" />
	<xsl:key name="restriction" match="//springas:object" use="@class" />
	<xsl:key name="proprestriction" match="//springas:property"
		use="@value" />
	<xsl:key name="valrestriction" match="//springas:value" use="." />
	<xsl:template match="/">
		<flex-config>
			<includes append="true">
				<xsl:for-each
					select="//springas:object[count(.|key('restriction',@class)[1]) = 1]">
					<xsl:sort select="@class" />
					<xsl:if test="@class!=''">
						<symbol>
							<xsl:value-of select="@class" />
						</symbol>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each
					select="//springas:property[count(.|key('proprestriction',@value)[1]) = 1]">
					<xsl:sort select="@value" />
					<xsl:if test="@type='Class'">
						<symbol>
							<xsl:value-of select="@value" />
						</symbol>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each
					select="//springas:value[count(.|key('valrestriction',.)[1]) = 1]">
					<xsl:sort select="." />
					<xsl:if test="@type='Class'">
						<symbol>
							<xsl:value-of select="." />
						</symbol>
					</xsl:if>
				</xsl:for-each>
			</includes>
		</flex-config>
	</xsl:template>
</xsl:stylesheet>