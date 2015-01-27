<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
exclude-result-prefixes="xmlns msxsl">

<!--
templates in this file are mostly mimic XQuery statement as following(for example data above)
for $i in //a,$j in //c,$k in //h
return $i/* || ' ' || $j/* || ' ' || $k/*
it is used to convert from tree structure to table structure as much as it's possible to do
-->

<xsl:template match="/">
<ROOT>
<xsl:apply-templates 
 select="descendant::*[not(descendant::*[child::*[(name()=name(following-sibling::*[1])) or 
   (name()=name(preceding-sibling::*[1]))]]) and child::*[(name()=name(following-sibling::*[1])) or 
   (name()=name(preceding-sibling::*[1]))]]/child::*[(name()=name(following-sibling::*[1])) or 
   (name()=name(preceding-sibling::*[1]))]"/>
<!--
find all same named descendants of root _having_not_ same named descendants
e.g. for example below these would be 'a' nodes only
-->
</ROOT>
<!--
<ex>
	<h>
		<t>123</t>
		<t>124</t>
		<c>
			<t>125</t>
			<a>aa</a>
			<a>bb</a>
		</c>
		<c>
			<t>126</t>
			<a>cc</a>
			<a>dd</a>
		</c>
	</h>
</ex>
for the example file above desired  output is the following
123 124 125 aa cc
123 124 125 aa dd
123 124 126 bb cc
123 124 126 bb dd
this prints out all same named nodes as a new line and the rest of nodes in axes prepends to each line
-->
</xsl:template>


<xsl:template match="*" mode="dna">
<xsl:param name="path"/>
<!--
this templates prints out single nodes in axes ancestors of given and having not same named elements
by single nodes meant those containing text nodes
-->
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
	<xsl:with-param name="var1">
<xsl:if test="not(descendant::*[(name()=name(preceding-sibling::*[1])) or 
					  (name()=name(following-sibling::*[1]))])">
		<xsl:copy-of select="child::*[not(child::*)]"/> 
</xsl:if>
		<xsl:copy-of select="$var"/>
	</xsl:with-param>
</xsl:apply-templates>

<xsl:if test="$var1">
<OK>
	<xsl:copy-of select="child::*[not(child::*)]"/>
	<xsl:copy-of select="$var1"/>
</OK>
</xsl:if>

</xsl:template>

</xsl:stylesheet>