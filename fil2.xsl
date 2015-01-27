<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
exclude-result-prefixes="xsl msxsl">
<xsl:output omit-xml-declaration="yes" indent="yes"/>
<xsl:strip-space elements="*"/>
<xsl:key name="key1" match="//OK/*" use="name()"/>


<xsl:template match="/">
<ROOT>
	<xsl:apply-templates />
</ROOT> 
<!--
select unique key
-->
</xsl:template>

<xsl:template match="//OK/*[count(. | key('key1',name())[1]) = 1]">
<xsl:element name="{name()}"/>
</xsl:template>

<xsl:template match="text()">
</xsl:template>

<xsl:template match="text()" mode="pi">
</xsl:template>

</xsl:stylesheet>





