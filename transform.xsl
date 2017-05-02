<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

   <xsl:template match = "/">
      <html>
         <head>
            <title>
               Event: <xsl:value-of select="event/@id"/>
            </title>
            <link href="style.css" rel="stylesheet"/>
            <link href="https://fonts.googleapis.com/css?family=Arvo" rel="stylesheet"/>
         </head>
         <body>
            <xsl:apply-templates/>
         </body>
      </html>
   </xsl:template>

   <xsl:template match="doc-level">
      <div>
         <xsl:choose>
            <xsl:when test="@position">
               <xsl:attribute name="class" select="@position"/>
               <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@type">
               <xsl:attribute name="class" select="@type"/>
               <xsl:apply-templates/>
            </xsl:when>
         </xsl:choose>
      </div>
   </xsl:template>

   <xsl:template match="h1">
      <h1>
         <xsl:choose>
            <xsl:when test="following-sibling::h2">
               <xsl:if test="following-sibling::subheading">
                  <xsl:value-of select="."/>
                  <xsl:value-of select="following-sibling::subheading"/>
               </xsl:if>
            </xsl:when>
            <xsl:when test="preceding-sibling::para[@type='num']/num[text()]">
               <xsl:value-of select="."/>
               <xsl:value-of select="preceding-sibling::para[@type='num']/num[text()]"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates/>
            </xsl:otherwise>
         </xsl:choose>
      </h1>
   </xsl:template>

   <xsl:template match="subheading">
      <xsl:choose>
         <xsl:when test="preceding-sibling::h2">
            <xsl:if test="preceding-sibling::h1"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <xsl:template match="para[@type='num']/num[text()]">
      <xsl:choose>
         <xsl:when test="following-sibling::h1"/>
         <xsl:otherwise>
            <p>
               <xsl:apply-templates/>
            </p>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="h2">
      <h2>
         <xsl:apply-templates/>
      </h2>
   </xsl:template>

   <xsl:template match="para">
      <xsl:if test="@type='ordered-list'">
         <p>
            <xsl:attribute name="class" select="@style"/>
            <ol>
               <xsl:for-each select="list-item">
                  <li>
                     <xsl:apply-templates/>
                  </li>
               </xsl:for-each>
            </ol>
         </p>
      </xsl:if>
   </xsl:template>

   <xsl:template match="image">
      <img src="{@source}" alt="{@description}"/>
   </xsl:template>

   <xsl:template match="table">
      <table>
         <caption>
            <xsl:value-of select="table-heading"/>
         </caption>
         <xsl:for-each select="table-row">
            <tr>
               <xsl:for-each select="table-cell">
                    <th colspan="{@colspan}">
                       <xsl:apply-templates/>
                    </th>
               </xsl:for-each>
            </tr>
         </xsl:for-each>
      </table>
   </xsl:template>

</xsl:stylesheet>