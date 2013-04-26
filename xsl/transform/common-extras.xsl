<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:d="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="xi:iinclude[@href,@parse='text']">
    <xsl:copy>
      <xsl:attribute name="fileref">
        <xsl:value-of select="replace(@href,'^\./extras','./extras/common')" />
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
