<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:d="http://docbook.org/ns/docbook" xmlns:xlink="http://www.w3.org/1999/xlink">

   <xsl:param name="date" />
   <xsl:param name="firstname" />
   <xsl:param name="surname" />
   <xsl:param name="email" />
   <xsl:param name="commit" />
   <xsl:param name="productnumber" />
   <xsl:param name="revision" />

   <xsl:template match="@*|node()">
     <xsl:copy>
       <xsl:apply-templates select="@*|node()"/>
     </xsl:copy>
   </xsl:template>

   <xsl:template match="d:revision/d:revnumber">
     <xsl:element name="revnumber" namespace="http://docbook.org/ns/docbook">
       <xsl:value-of select="$productnumber"/><xsl:text>-</xsl:text><xsl:value-of select="$revision"/>
     </xsl:element>
   </xsl:template>

   <xsl:template match="d:revision/d:date">
     <xsl:element name="date" namespace="http://docbook.org/ns/docbook">
       <xsl:value-of select="$date"/>
     </xsl:element>
   </xsl:template>

   <xsl:template match="d:revision/d:author/d:personname/d:firstname">
     <xsl:element name="firstname" namespace="http://docbook.org/ns/docbook">
       <xsl:value-of select="$firstname"/>
     </xsl:element>
   </xsl:template>

   <xsl:template match="d:revision/d:author/d:personname/d:surname">
     <xsl:element name="surname" namespace="http://docbook.org/ns/docbook">
       <xsl:value-of select="$surname"/>
     </xsl:element>
   </xsl:template>

   <xsl:template match="d:revision/d:author/d:email">
     <xsl:element name="email" namespace="http://docbook.org/ns/docbook">
       <xsl:value-of select="$email" />
     </xsl:element>
   </xsl:template>

   <xsl:template match="d:revision/d:revdescription/d:simplelist/d:member">
     <xsl:element name="member" namespace="http://docbook.org/ns/docbook">
       <xsl:text>Rebased from commit </xsl:text>
       <xsl:element name="link" namespace="http://docbook.org/ns/docbook">
         <xsl:attribute name="xlink:href">
           <xsl:text>http://git.openstack.org/cgit/openstack/openstack-manuals/commit/tools/autogenerate-config-docs?id=</xsl:text><xsl:value-of select="$commit" />
         </xsl:attribute>
         <xsl:value-of select="$commit" />
       </xsl:element>
       <xsl:text> of the </xsl:text><xsl:element name="literal" namespace="http://docbook.org/ns/docbook">openstack-manuals</xsl:element><xsl:text> project.</xsl:text>
     </xsl:element>
   </xsl:template>

</xsl:stylesheet>
