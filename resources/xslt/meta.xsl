<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="2.0"><!-- <xsl:strip-space elements="*"/>-->
    <xsl:import href="shared/base.xsl"/>
    <xsl:param name="document"/>
    <xsl:param name="app-name"/>
    <xsl:param name="collection-name"/>
    <xsl:param name="path2source"/>
    <xsl:param name="ref"/>
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="authors"/>
    <!--
##################################
### Seitenlayout und -struktur ###
##################################
-->
    <xsl:template match="/">
        <div class="container">
            <div class="card">
                <div class="card-header">
                    <div class="row" style="text-align:left">
                        <div class="col-md-2">
                            <xsl:if test="$prev">
                                <h1>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$prev"/>
                                        </xsl:attribute>
                                        <i class="fas fa-chevron-left" title="prev"/>
                                    </a>
                                </h1>
                            </xsl:if>
                        </div>
                        <div class="col-md-8" align="center">
                            <h1>
                                <xsl:value-of select="//tei:title[@type='main']"/>                                
                            </h1>
                            <h5>
                                <muted>
                                    <xsl:value-of select="//tei:title[@type='sub']"/>
                                </muted>
                            </h5>
                            
                        </div>
                        <div class="col-md-2" style="text-align:right">
                            <xsl:if test="$next">
                                <h1>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$next"/>
                                        </xsl:attribute>
                                        <i class="fas fa-chevron-right" title="next"/>
                                    </a>
                                </h1>
                            </xsl:if>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <xsl:apply-templates select="//tei:body"/>
                    <h3>Anmerkungen</h3>
                    <p>
                        <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note">
                            <div class="footnotes">
                                <xsl:element name="a">
                                    <xsl:attribute name="name">
                                        <xsl:text>fn</xsl:text>
                                        <xsl:number level="any" format="1" count="tei:note[./tei:p]"/>
                                    </xsl:attribute>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:text>#fna_</xsl:text>
                                            <xsl:number level="any" format="1" count="tei:note"/>
                                        </xsl:attribute>
                                        <sup>
                                            <xsl:number level="any" format="1" count="tei:note[./tei:p]"/>
                                        </sup>
                                    </a>
                                </xsl:element>
                                <xsl:apply-templates select="./tei:p/text()"/>
                            </div>
                        </xsl:for-each>
                    </p>
                </div>
                <div class="card-footer text-muted" style="text-align:center">
                    <xsl:value-of select="$authors"/>, 
                    <i>
                        <xsl:value-of select="//tei:title[@type='sub']"/> - 
                        <xsl:value-of select="//tei:title[@type='main']"/>
                    </i>
                    <br/>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$path2source"/>
                        </xsl:attribute>
                        TEI
                    </a>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend='Quote']">
        <blockquote>
            <xsl:apply-templates/>
        </blockquote>
    </xsl:template>
</xsl:stylesheet>