<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:d="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">

  <xsl:param name="title" />
  <xsl:param name="subtitle" />

  <xsl:param name="productname" />
  <xsl:param name="productnumber" />

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
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

  <!-- If title, subtitle productname or productnumber elements exist, and values were
       provided as parameters, then update the elements with the values. Note that
       we do make an exception for title and assume that the source material will
       always have this node.-->
  <xsl:template match="d:book/d:title | d:book/d:info/d:title">
    <xsl:choose>
      <xsl:when test="$title != ''">
        <xsl:element name="title" namespace="http://docbook.org/ns/docbook">
          <xsl:value-of select="$title" />
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="d:book/d:subtitle | d:book/d:info/d:subtitle">
    <xsl:choose>
      <xsl:when test="$subtitle != ''">
        <xsl:element name="subtitle" namespace="http://docbook.org/ns/docbook">
          <xsl:value-of select="$subtitle" />
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="d:book/d:info/d:productname">
    <xsl:choose>
      <xsl:when test="$productname != ''">
        <xsl:element name="productname" namespace="http://docbook.org/ns/docbook">
          <xsl:value-of select="$productname"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="d:book/d:info/d:productnumber">
    <xsl:choose>
      <xsl:when test="$productnumber != ''">
        <xsl:element name="productnumber" namespace="http://docbook.org/ns/docbook">
          <xsl:value-of select="$productnumber"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Inject preface after end of book info, inject productname and
       productnumber if they didn't already exist (if they do exist then they
       are updated in the previous step). -->
  <xsl:template match="d:book/d:info">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
      <xsl:if test="not(d:book/d:subtitle) and not(d:book/d:info/d:subtitle)">
        <xsl:if test="$subtitle != ''">
          <xsl:element name="subtitle" namespace="http://docbook.org/ns/docbook">
            <xsl:value-of select="$subtitle" />
          </xsl:element>
          <xsl:text>&#10;</xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:if test="not(//d:productname)">
        <xsl:if test="$productname != ''">
          <xsl:element name="productname" namespace="http://docbook.org/ns/docbook">
            <xsl:value-of select="$productname" />
          </xsl:element>
          <xsl:text>&#10;</xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:if test="not(//d:productnumber)">
        <xsl:choose>
          <xsl:when test="$productnumber != ''">
            <xsl:element name="productnumber" namespace="http://docbook.org/ns/docbook">
              <xsl:value-of select="$productnumber" />
            </xsl:element>
            <xsl:text>&#10;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="productnumber" namespace="http://docbook.org/ns/docbook">
              <xsl:text>1</xsl:text>
            </xsl:element>
            <xsl:text>&#10;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:copy>
    <xsl:element name="xi:include">
      <xsl:attribute name="href">Preface.xml</xsl:attribute>
    </xsl:element>
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
