<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="xsl">
<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="CP866"/>

<xsl:template match="ROOT">
	<xsl:apply-templates select="//OK"/>
</xsl:template>

<xsl:template match="*">

<xsl:if test="position()=1">
<!-- print csv header -->
<xsl:for-each select="child::*">
	<!--<xsl:sort select="$name"/>-->
<xsl:variable name="name" select="name()"/>
<xsl:variable name="title">
	<xsl:choose> <!-- enumerate duplicate and shorten too long field names for FoxPro-->
	<xsl:when test="count(preceding::*[substring(name(),1,10)=substring($name,1,10)]) &gt; 0">
		<xsl:value-of select="concat(substring($name,1,9),count(preceding::*[substring(name(),1,10)=substring($name,1,10)]))"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="substring($name,1,10)"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:variable name="separator">
<xsl:if test="following-sibling::*"> <!-- do not add separator to the end of line-->
	<xsl:text>,</xsl:text>
</xsl:if>
</xsl:variable>
<xsl:value-of select="concat($title,$separator)"/>
</xsl:for-each>
<xsl:text>&#xD;</xsl:text>
</xsl:if>

<xsl:for-each select="child::*">
	<!--<xsl:sort select="$name"/>-->
<xsl:variable name="value" select="."/>
<xsl:variable name="separator">
<xsl:if test="following-sibling::*">
	<xsl:text>,</xsl:text>
</xsl:if>
</xsl:variable>
<xsl:value-of select="concat($value,$separator)"/>
</xsl:for-each>
<xsl:text>&#xD;</xsl:text>
</xsl:template>

</xsl:stylesheet>