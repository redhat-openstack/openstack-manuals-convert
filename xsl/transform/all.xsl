<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:d="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">

  <xsl:param name="common" />
  <xsl:param name="book" />

  <!-- xsl variables up and lo and translate() are used to change case -->
  <xsl:variable name="up" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="lo" select="'abcdefghijklmnopqrstuvwxyz'"/>

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@audience">
    <xsl:attribute name="condition">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

  <!-- The syntax highlighting engine used by Publican does not have a
       specific handler for JSON. -->
  <xsl:template match="@language">
    <xsl:attribute name="language">
      <xsl:choose>
        <xsl:when test="translate(.,$lo,$up) = 'INI'"></xsl:when>
        <xsl:when test="translate(.,$lo,$up) = 'JSON'">
          <xsl:text>JavaScript</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="." />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <!-- Replace xi:include references with updated locations, when processing
       files in "common" some extra care is required - the caller indicates
       when this is the case using the "common" parameter. -->
  <xsl:template match="xi:include[@href]">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
      <xsl:choose>
        <!-- Remote samples (typically included from GIT) need are downloaded
             by the parent script and placed in a fixed directory. This XSL
             updates the relevant xi:includes to point to the new location. -->
        <xsl:when test="matches(@href,'^http.*')">
          <xsl:attribute name="href">
            <xsl:value-of select="replace(@href,'^.*/','samples/common/remote/')" />
          </xsl:attribute>
        </xsl:when>
        <!-- All other samples are also in a location under the top level
             samples directory. -->
        <xsl:when test="matches(@href, '^[\./]*common/samples')">
          <xsl:attribute name="href">
            <xsl:value-of select="replace(@href,'^[\./]*common/samples','samples/common/')" />
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="matches(@href, '^[\./]*samples')">
          <xsl:attribute name="href">
            <xsl:choose>
              <xsl:when test="$common = '1'">
                <xsl:value-of select="replace(@href,'^[\./]*samples','../samples/common')" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="replace(@href,'^[\./]*samples','samples')" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:when>
        <!-- Update xi:includes that point to common content, catering to the
             fact that common content has been moved. -->
        <xsl:when test="matches(@href, '\.\./common')">
          <xsl:attribute name="href">
            <xsl:choose>
              <xsl:when test="$common = '1'">
                <xsl:value-of select="replace(@href,'\.\./common','.')" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="replace(@href,'\.\./common','common')" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="matches(@href, concat('\.\./', $book))">
          <xsl:attribute name="href">
            <xsl:choose>
              <xsl:when test="$common = '1'">
                <xsl:value-of select="replace(@href, concat('\.\./', $book), '../')" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="replace(@href, concat('\.\./', $book), '')" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:when>
        <!-- Any other xi:includes are passed straight through. -->
        <xsl:otherwise>
          <xsl:attribute name="href">
            <xsl:value-of select="@href" />
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- Replace references to "figures" directory with references to "figures". -->
  <xsl:template match="d:imagedata[@fileref]">
    <xsl:copy>
      <xsl:choose>
        <xsl:when test="matches(@fileref, '^[\./]*figures')">
          <xsl:attribute name="fileref">
            <xsl:choose>
              <xsl:when test="$common = '1'">
                <xsl:value-of select="replace(@fileref,'^[\./]*figures','figures/common')" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="replace(@fileref,'^[\./]*figures','figures')" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="matches(@fileref, '^[\./]*common/figures')">
          <xsl:attribute name="fileref">
            <xsl:value-of select="replace(@fileref,'^[\./]*common/figures','figures/common')" />
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="fileref">
            <xsl:value-of select="@fileref" />
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- Strip revision history in rebase operation. -->
  <xsl:template match="d:revhistory"></xsl:template>

  <!-- Remove computeroutput elements (treated as verbatim instead of inline
       in clouddocs-maven. Unlike other dropped nodes ensure the content is
       kept though. -->
  <xsl:template match="d:computeroutput">
    <xsl:copy-of select="child::* | child::node()" />
  </xsl:template>

</xsl:stylesheet>
