<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m="http://maven.apache.org/POM/4.0.0">

  <xsl:output method="text" omit-xml-declaration="yes" indent="yes" />

  <xsl:template match="m:plugin/m:configuration/m:includes">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

  <xsl:template match="text()" />

</xsl:stylesheet>
