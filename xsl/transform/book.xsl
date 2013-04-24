<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:d="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">

  <xsl:param name="productnumber" select="0.0" />

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- If there is no productnumber element then set one. -->
  <xsl:template match="d:productname">
    <xsl:copy-of select="." />
      <xsl:if test="not(//productnumber)">
        <xsl:text>&#xa;</xsl:text>
        <xsl:element name="productnumber" namespace="http://docbook.org/ns/docbook">
            <xsl:value-of select="$productnumber"/>
        </xsl:element>
      </xsl:if>
  </xsl:template>

  <!-- Replace author with an xi include to the author group -->
  <xsl:template match="d:author">
    <xsl:element name="xi:include">
      <xsl:attribute name="href">Author_Group.xml</xsl:attribute>
    </xsl:element>
  </xsl:template>

  <!-- Replace legalnotice with an xi include to the relevant
       legalnotice -->
  <xsl:template match="d:legalnotice">
    <xsl:element name="xi:include">
      <xsl:attribute name="href">Legal_Notice.xml</xsl:attribute>
    </xsl:element>
  </xsl:template>

  <!-- Inject preface at end of book info. -->
  <xsl:template match="d:book/d:info">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
      <xsl:element name="xi:include">
        <xsl:attribute name="href">Preface.xml</xsl:attribute>
      </xsl:element>
    </xsl:copy>
  </xsl:template>

  <!-- Inject revision history at end of book. -->
  <xsl:template match="d:book">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
      <xsl:element name="xi:include">
        <xsl:attribute name="href">Revision_History.xml</xsl:attribute>
      </xsl:element>
    </xsl:copy>
  </xsl:template>

  <!-- Remove copyright elements (now in Legal_Notice.xml. -->
  <xsl:template match="d:copyright"></xsl:template>

  <!-- Remove revhistory elements (now in Revision_History.xml). -->
  <xsl:template match="d:revhistory"></xsl:template>

</xsl:stylesheet>
