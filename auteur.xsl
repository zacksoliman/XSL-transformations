<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs" version="2.0">

    <xsl:output method="xml"
      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
      indent="yes"
      encoding="UTF-8"/>

      <xsl:template match="/">
        <html>
          <head><title>Auteurs</title><head>
          <body>
            <xsl:apply-templates/>
          </body>
        </html>
      </xsl:template>

</xsl:stylesheet>
