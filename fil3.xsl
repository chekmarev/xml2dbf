<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
exclude-result-prefixes="xsl msxsl">
<xsl:output omit-xml-declaration="yes" indent="yes"/>
<xsl:strip-space elements="*"/>
<xsl:key name="key1" match="//OK/*" use="name()"/>


<xsl:template match="/">
<ROOT>
	<xsl:apply-templates select="//OK">
		<xsl:with-param name="tet3" select="document('tet3.xml')/ROOT/*"/>
	</xsl:apply-templates>
</ROOT> 
<!--
process and append non existent
-->
</xsl:template>


<xsl:template match="//OK">
<xsl:param name="tet3"/>
<OK>
<xsl:variable name="self" select="."/>
	<xsl:for-each select="msxsl:node-set($tet3)">
<xsl:variable name="s1" select="name(.)"/>
<!--<xsl:for-each select="$self/*">
<xsl:value-of select="concat($s1,' ',name(.))"/>
<xsl:if test="name(.)=$s1">
eq
</xsl:if>
	</xsl:for-each>
<xsl:value-of select="concat(count($self/*[name()=$s1]),') ',generate-id($self/*[1]))"/>
<xsl:value-of select="concat(name(.),' ',generate-id(.))"/>-->

<xsl:choose>

<xsl:when test="$self/*[name()=$s1]">
<!--	<xsl:copy-of select="$self/*[name()=name(.)]"/>-->
<xsl:copy-of select="$self/*[name()=$s1]"/>
</xsl:when>
<xsl:otherwise>
	<xsl:copy-of select="."/>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</OK>
</xsl:template>

<xsl:template match="text()">
</xsl:template>


</xsl:stylesheet>





