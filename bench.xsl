<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
exclude-result-prefixes="xmlns msxsl">
<xsl:output omit-xml-declaration="yes" indent="no" method="text" encoding="CP866"/>


<xsl:template match="/">
<xsl:apply-templates 
 select="descendant::*[not(descendant::*[child::*[(name()=name(following-sibling::*[1])) or 
   (name()=name(preceding-sibling::*[1]))]]) and child::*[(name()=name(following-sibling::*[1])) or 
   (name()=name(preceding-sibling::*[1]))]]/child::*[(name()=name(following-sibling::*[1])) or 
   (name()=name(preceding-sibling::*[1]))]">
	<xsl:with-param name="total" select="count(descendant::*[not(descendant::*[child::*[(name()=name(following-sibling::*[1])) or 
   (name()=name(preceding-sibling::*[1]))]]) and child::*[(name()=name(following-sibling::*[1])) or 
   (name()=name(preceding-sibling::*[1]))]]/child::*[(name()=name(following-sibling::*[1])) or 
   (name()=name(preceding-sibling::*[1]))])"/>
</xsl:apply-templates>
</xsl:template>


<xsl:template match="*" mode="dna">
<xsl:param name="path"/>



<xsl:choose>
<xsl:when test="not(parent::*)">
	<xsl:copy-of select="$path"/>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates 
   select="parent::*" mode="dna">
	<xsl:with-param name="path">
		<xsl:copy-of select="
  following-sibling::*[(name()!=name(preceding-sibling::*[1])) 
 and (name()!=name(following-sibling::*[1])) and child::*[not(child::*)]]/child::*[not(child::*)] 
| preceding-sibling::*[(name()!=name(preceding-sibling::*[1])) 
 and (name()!=name(following-sibling::*[1])) and child::*[not(child::*)]]/child::*[not(child::*)] 
| child::*[(name()!=name(preceding-sibling::*[1])) 
 and (name()!=name(following-sibling::*[1])) and not(child::*)]"/> 
		<xsl:copy-of select="$path"/>
	</xsl:with-param>
</xsl:apply-templates>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="*">
<!--<DEBUG><xsl:value-of select="name(.)"/></DEBUG>-->
<xsl:param name="path"/>
<xsl:param name="var1"/> 
<xsl:param name="total"/> 

<xsl:choose>
<xsl:when test="(($total &gt; 50) and (position() &lt; 50)) or 
		    (($total &lt; 50) and (position() &lt; $total))">

<!--
collecting not same named nodes in axes to prepend for each line in the resulting table
-->
<xsl:variable name="var">
<xsl:choose>
<xsl:when test="not($var1)">
<xsl:apply-templates 
   select="parent::*" mode="dna">
	<xsl:with-param name="path">
		<xsl:copy-of select="$path"/>
	</xsl:with-param>
</xsl:apply-templates>
</xsl:when>
<xsl:when test="$var1">
	<xsl:copy-of select="$var1"/>
</xsl:when>
</xsl:choose>
</xsl:variable>

<!--
apply templates to every parent's sibling to make multiple copies of the current line
templates in this file are mostly mimic XQuery statement as following(for example data above)
for $i in //a,$j in //c,$k in //h
return $i/* || ' ' || $j/* || ' ' || $k/*
-->

<xsl:apply-templates 
   select="ancestor::*[preceding-sibling::*[((name()=name(preceding-sibling::*[1])) 
or (name()=name(following-sibling::*[1])))]][1]/preceding-sibling::*[
not(descendant::*[(name()=name(preceding-sibling::*[1])) or (name()=name(following-sibling::*[1]))
]) and ((name()=name(preceding-sibling::*[1])) or (name()=name(following-sibling::*[1])))]
         | ancestor::*[preceding-sibling::*[((name()=name(preceding-sibling::*[1])) 
or (name()=name(following-sibling::*[1])))]][1]/following-sibling::*[
not(descendant::*[(name()=name(preceding-sibling::*[1])) or (name()=name(following-sibling::*[1]))
]) and ((name()=name(preceding-sibling::*[1]) or name()=name(following-sibling::*[1])))]">
	<xsl:with-param name="total">
		<xsl:value-of select="$total"/>
	</xsl:with-param>
	<xsl:with-param name="var1">
<xsl:if test="not(descendant::*[(name()=name(preceding-sibling::*[1])) or 
					  (name()=name(following-sibling::*[1]))])">
		<xsl:copy-of select="child::*[not(child::*)]"/> 
</xsl:if>
		<xsl:copy-of select="$var"/>
	</xsl:with-param>
</xsl:apply-templates>

<!--<xsl:if test="$var1">
<OK>
	<xsl:copy-of select="child::*[not(child::*)]"/>
	<xsl:copy-of select="$var1"/>
</OK>
</xsl:if>-->


</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="$total - position() = 0">
	<xsl:value-of select="concat('1 ',$total)"/>
</xsl:when>
<xsl:otherwise>
	<xsl:value-of select="concat('50',' ',$total)"/>
</xsl:otherwise>
</xsl:choose>
<xsl:message terminate="yes">
<xsl:value-of select="concat('total:',$total,'&#xD;div50:',$total div 50,'&#xD;pos:',position())"/>
</xsl:message>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>