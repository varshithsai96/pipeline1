<?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pom="http://maven.apache.org/POM/4.0.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="1.0">
	
	<xsl:output method="xml" encoding="UTF-8"/>
	
	<xsl:param name="artifacts"/>
	
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="pom:project/pom:version|
	                     pom:parent/pom:version|
	                     pom:dependency/pom:version|
	                     pom:plugin/pom:version">
		<xsl:variable name="artifactId" select="string(parent::*/pom:artifactId)"/>
		<xsl:variable name="groupId">
			<xsl:choose>
				<xsl:when test="parent::*/pom:groupId">
					<xsl:value-of select="string(parent::*/pom:groupId)"/>
				</xsl:when>
				<xsl:when test="parent::pom:project/pom:parent/pom:groupId">
					<xsl:value-of select="parent::pom:project/pom:parent/pom:groupId"/>
				</xsl:when>
				<xsl:when test="parent::pom:plugin"/>
				<xsl:otherwise>
					<xsl:message terminate="yes">error</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="contains(concat(',',$artifacts,','),concat(',',$groupId,':',$artifactId,','))">
					<xsl:text>0.0.0-SNAPSHOT</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="string(.)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="pom:module">
		<xsl:copy>
			<xsl:value-of select="concat(.,'/.versionless-pom.xml')"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="pom:parent/pom:relativePath[not(string(.)='')]">
		<xsl:copy>
			<xsl:value-of select="concat(.,'.versionless-pom.xml')"/>
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>
