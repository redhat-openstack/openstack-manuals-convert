<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xi="http://www.w3.org/2001/XInclude">

  <xsl:output method="text" omit-xml-declaration="yes" indent="yes" />

  <xsl:template match="xi:include[@href]">
    <xsl:if test="matches(@href,'.*\.xml$')">
      <xsl:value-of select="@href"/><xsl:text>&#10;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="text()" />

</xsl:stylesheet>
