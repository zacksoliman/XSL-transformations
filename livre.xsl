<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8"/>
    
    <xsl:key name="author-search" match="auteur" use="@ident"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Livres</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="bibliotheque">
        <h1>Bibliotheque</h1>
        <table border="1">
            <tr>
                <th>Titre</th>
                <th>Couverture</th>
                <th>Auteur(s)</th>
                <th>Annee de publication</th>
                <th>Prix</th>                
            </tr>
            <xsl:apply-templates select="livre"/>
       
        </table>        
    </xsl:template>
    
    <xsl:template match="livre">
        <tr>
            <!-- Titre -->
            <td><xsl:value-of select="titre"/></td>
            <td>
                <!-- Couverture -->
                <img height="250px" width="150px">
                    <xsl:attribute name="src"><xsl:value-of select="couverture"/></xsl:attribute>                            
                </img>
            </td>     
            <!-- Auteurs -->
            <td>
                <ul>
                    <xsl:for-each select="key('author-search',@auteurs)">
                        <li><xsl:value-of select="concat(nom,', ',prenom)"/></li>
                    </xsl:for-each>
                </ul>
            </td>
            <!-- Annee de publication -->
            <td><xsl:value-of select="annee"/></td>
            <!-- Adaptation film -->
            <td>
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="film"/></xsl:attribute>
                    Adaption au Cinema
                </a>
            </td>
            <!-- Prix -->
            <td><xsl:value-of select="concat(prix/valeur, ' ' ,prix/valeur/@monnaie)"/></td>                    
        </tr>
    </xsl:template>
    
</xsl:stylesheet>