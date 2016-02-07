<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

  <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8"/>
  
  <!-- ICI CHANGER 'all' POUR LE NOM DE L'AUTEUR VOULU -->
  <!-- ENTRER LE NOM DE L'AUTEUR AVEC UN ESPACE ENTRE LE PRENOM ET LE NOM -->
  <!-- LE PRENOM DOIT APPARAITRE EN PREMIER -->
  <xsl:param name="prenom_nom" select="'all'"/>
  
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
    
    <!-- Visualitation des auteurs -->
    <h1>Auteurs</h1>
    <table border="1">
      <tr>
        <th>Photo</th>
        <th>Informations</th>
        <th>Livre Ecrits</th>
        <th>Commentaire</th>
      </tr>
      <xsl:choose>
        <xsl:when test="$prenom_nom = 'all'">
          <xsl:apply-templates select="auteur"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="auteur[prenom = tokenize($prenom_nom, '\s+')[1] and nom = tokenize($prenom_nom, '\s+')[2]]"/>
        </xsl:otherwise>
      </xsl:choose>
    </table>
  </xsl:template>
 
 <xsl:template match='auteur'>
   <tr> 
     <xsl:attribute name="id"><xsl:value-of select="concat(prenom,nom)"/></xsl:attribute>
     <!-- Photo -->
     <td>
       <xsl:if test="photo[string-length(text()) > 0]">
         <img height="200px" width="200px"><xsl:attribute name="src"><xsl:value-of select="photo"/></xsl:attribute></img>
       </xsl:if>
     </td>
     <!-- Information -->
     <td>
       <p><xsl:value-of select="concat(prenom,', ',nom)"/></p>
       <p><xsl:value-of select="pays"/></p>
     </td>
     <!-- Livre ecrits -->
     <td>
       <xsl:for-each select="//livre[contains(@auteurs,current()/@ident)]">        
         <li>
           <xsl:value-of select="titre"/>
         </li>       
       </xsl:for-each>
     </td>
     <!-- Commentaire -->
     <td>
       <p><xsl:value-of select="commentaire"/></p>
     </td>
   </tr>
 </xsl:template>
</xsl:stylesheet>
