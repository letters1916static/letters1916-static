<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0"
    exclude-result-prefixes="xsl tei xs">
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/blockquote.xsl"/>
    <xsl:import href="./partials/zotero.xsl"/>
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>


    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
        </xsl:variable>
        <xsl:variable name="teiSource">
            <xsl:value-of select="data(tei:TEI/@xml:id)"/>
        </xsl:variable>
        <xsl:variable name="link">
            <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
        </xsl:variable>
        <html class="h-100" lang="{$default_lang}">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="zoterMetaTags">
                    <xsl:with-param name="pageId" select="$link"></xsl:with-param>
                    <xsl:with-param name="zoteroTitle" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <!-- add the name of the author of the current article -->
                <meta name="citation_author" content="Foo, Bar"/> 
            </head>
            
            <body class="d-flex flex-column h-100">
            <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0 flex-grow-1">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="ps-0 pt-3 pb-3">
                        <div class="container">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="index.html">
                                        <xsl:value-of select="$project_short_title"/>
                                    </a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">
                                    <xsl:value-of select="$doc_title"/>
                                </li>
                            </ol>
                        </div>
                    </nav>
                    <div class="container">                        
                        <h1><xsl:value-of select="$doc_title"/></h1>    
                        <xsl:apply-templates select=".//tei:body" />
                        <div class="text-center p-4">
                            <xsl:call-template name="blockquote">
                                <xsl:with-param name="pageId" select="$link"/>
                            </xsl:call-template>
                        </div>

                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:p">
        <p id="{generate-id()}"><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="tei:div">
        <div id="{generate-id()}"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <abbr title="unclear"><xsl:apply-templates/></abbr>
    </xsl:template>
    <xsl:template match="tei:del">
        <del><xsl:apply-templates/></del>
    </xsl:template>  
    <xsl:template match="tei:div[@type='section']/tei:head">
        <h2 class="fs-3"><xsl:value-of select="."/></h2>
    </xsl:template>
    <!--
    <xsl:template match="tei:list/tei:head">
        <h3 class="fs-4"><xsl:value-of select="."/></h3>
    </xsl:template>
    -->
    <xsl:template match="tei:div[@n='2']">
        <h2 class="fs-3"><xsl:value-of select="tei:head"/></h2>
        <div class="accordion accordion-flush" id="accordionFlushTeam" style="--bs-accordion-active-bg: #efefef; --bs-accordion-btn-focus-box-shadow: none">
            <xsl:for-each select="tei:div[@type='subsection']">
                <xsl:variable name="section-id" select="./@xml:id"/>
                <div class="accordion-item">
                    <h3 class="fs-4 accordion-header" id="flush-heading-{$section-id}">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse-{$section-id}" aria-expanded="false" aria-controls="flush-collapse-{$section-id}">
                            <xsl:value-of select="tei:head"/>
                        </button>
                    </h3>
                    <div id="flush-collapse-{$section-id}" class="accordion-collapse collapse" aria-labelledby="flush-heading-{$section-id}" data-bs-parent="#accordionFlushTeam">
                        <div class="accordion-body">
                            <xsl:apply-templates select="tei:list"/>
                        </div>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>     
</xsl:stylesheet>