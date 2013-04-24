<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:d="http://docbook.org/ns/docbook">

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="xi:include[@href]">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
      <xsl:attribute name="href">
        <xsl:value-of select="replace(@href,'\.\./common','./common')" />
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="d:imagedata[@fileref]">
    <xsl:copy>
      <xsl:attribute name="fileref">
        <xsl:value-of select="replace(@fileref,'^[\./]*figures','./images')" />
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
