<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

  <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8"/>
  
  <xsl:key name='book-search' match='bibliotheque/livre' use='@auteurs' />
  <xsl:template match="/">
    <html>
      <head>
        <title>Auteurs</title>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="bibliotheque">
    <!-- Displaying authors information -->
    <xsl:for-each select="auteur">
      <h2><xsl:value-of select="nom"/>, <xsl:value-of select="prenom"/></h2>
      <h3><xsl:value-of select="pays"/></h3>
      <!-- Author's photo -->
      <img height='200px' width="200px" align="right">
        <xsl:attribute name="src">
          <xsl:value-of select="photo"/>
        </xsl:attribute>
      </img>
      <h3>Livres ecrits</h3>
      <xsl:for-each select="//livre[contains(@auteurs,current()/@ident)]">
        <li>
          <xsl:value-of select="titre"/>
        </li>
      </xsl:for-each>
      <h4>Commentaires:</h4>
      <p><xsl:value-of select="commentaire"/></p>
    </xsl:for-each>
  </xsl:template>
 
</xsl:stylesheet>
