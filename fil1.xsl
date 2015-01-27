<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
exclude-result-prefixes="xsl msxsl">
<xsl:output omit-xml-declaration="yes" indent="yes"/>
<xsl:strip-space elements="*"/>

<xsl:template match="/">
<ROOT>
<xsl:apply-templates/>
</ROOT> 
<!--
assign number preceding-sibling
-->
</xsl:template>

<xsl:template match="//OK">
<OK>
	<xsl:apply-templates/>
</OK>
</xsl:template>

<xsl:template match="//OK/*">
<xsl:choose>
<xsl:when test="preceding-sibling::*[name()=name(current())]">
<xsl:element name="{concat(name(),count(preceding-sibling::*[name()=name(current())]))}">
	<xsl:value-of select="."/>
</xsl:element>
</xsl:when>
<xsl:otherwise>
	<xsl:copy-of select="."/>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>





