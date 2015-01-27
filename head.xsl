<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="xsl">
<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="CP866"/>

<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>


<xsl:template match="ROOT">
<xsl:for-each select="OK[1]//*">
	<!--<xsl:sort select="$name"/>-->
	<xsl:variable name="name" select="name()"/>
	<xsl:variable name="dbfname">
		<xsl:choose> <!-- enumerate duplicate and shorten too long field names for FoxPro-->
		<xsl:when test="count(preceding::*[substring(name(),1,10)=substring($name,1,10)]) &gt; 0">
			<xsl:value-of select="concat(substring($name,1,9),count(preceding::*[substring(name(),1,10)=substring($name,1,10)]))"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="substring($name,1,10)"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:value-of select="concat($dbfname,',C,32,0','&#xA;')"/>
</xsl:for-each>
</xsl:template>


</xsl:stylesheet>