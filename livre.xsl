<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"
        encoding="UTF-8"/>

    <!-- ICI CHANGER 'all' POUR LE TITRE DU LIVRE VOULU -->
    <xsl:param name="titre_livre" select="'all'"/>

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
                <th>Commentaire</th>
                <th>Personnages</th>
                <th>Film</th>
                <th>Prix</th>
            </tr>

            <!-- Logique pour determiner si on visiualise un seul livre dont le nom a 
            ete passer en parametre ou tout les livres.-->
            <xsl:choose>
                <xsl:when test="$titre_livre = 'all'">
                    <xsl:apply-templates select="livre"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="livre[titre = $titre_livre]"/>
                </xsl:otherwise>
            </xsl:choose>
        </table>

        <!-- Visualitation des personnages -->
        <h2>Personnages</h2>
        <table border="1">
            <tr>
                <th>Photo</th>
                <th>Informations</th>
                <th>Commentaire</th>
            </tr>
            <xsl:choose>
                <xsl:when test="$titre_livre = 'all'">
                    <xsl:apply-templates select="livre/personnage"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="livre[titre = $titre_livre]/personnage"/>
                </xsl:otherwise>
            </xsl:choose>
        </table>
    </xsl:template>

    <xsl:template match="livre">
        <tr>
            <!-- Titre -->
            <td>
                <xsl:value-of select="titre"/>
            </td>
            <td>
                <!-- Couverture -->
                <img height="250px" width="150px">
                    <xsl:attribute name="src">
                        <xsl:value-of select="couverture"/>
                    </xsl:attribute>
                </img>
            </td>
            <!-- Auteurs -->
            <td>
                <ul>
                    <xsl:for-each select="key('author-search', tokenize(@auteurs, '\s+'))">
                        <li>
                            <xsl:value-of select="concat(nom, ', ', prenom)"/>
                        </li>
                    </xsl:for-each>
                </ul>
            </td>
            <!-- Annee de publication -->
            <td>
                <xsl:value-of select="annee"/>
            </td>
            <!-- Commentaires -->
            <td>
                <p>
                    <xsl:value-of select="commentaire"/>
                </p>
            </td>
            <!-- Personnages -->
            <td>
                <!-- On verifie s'il y a effectivement de personnage de defini dans le document xml -->
                <xsl:if test="exists(personnage)">
                    <xsl:for-each select="personnage">
                        <ul>
                            <li>
                                <a>
                                    <xsl:attribute name="href">
                                        <!-- On cree un lien a la table des personnages (VOIR: template de personnage)-->
                                        <xsl:value-of select="concat('#', prenom, nom)"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="concat(prenom, ', ', nom)"/>
                                </a>
                            </li>
                        </ul>
                    </xsl:for-each>
                </xsl:if>
            </td>
            <!-- Adaptation film -->
            <td>
                <xsl:if test="film[string-length(text()) > 0]">
                    <a>
                        <xsl:attribute name="href"><xsl:value-of select="film"/></xsl:attribute>
                        Adaption au Cinema</a>
                </xsl:if>
            </td>
            <!-- Prix -->
            <td>
                <xsl:value-of select="concat(prix/valeur, ' ', prix/valeur/@monnaie)"/>
            </td>
        </tr>


    </xsl:template>

    <xsl:template match="personnage">
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
            <!-- Commentaire -->
            <td>
                <p><xsl:value-of select="commentaire"/></p>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
