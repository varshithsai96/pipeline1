<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns="http://www.daisy.org/z3986/2005/dtbook/"
                xpath-default-namespace="http://www.daisy.org/z3986/2005/dtbook/"
                exclude-result-prefixes="#all">

  <!--
      Insert an endnotes section element
  -->

  <xsl:param name="endnotes-section-id" as="xs:string" select="''"/>

  <xsl:template match="/*">
    <xsl:choose>
      <xsl:when test="$endnotes-section-id!=''
                      and //noteref">
        <xsl:copy>
          <xsl:sequence select="@*|node()"/>
          <div id="{$endnotes-section-id}"/>
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>