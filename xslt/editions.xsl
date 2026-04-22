<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0"
    exclude-result-prefixes="xsl tei xs">
    
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/blockquote.xsl"/>
    <xsl:import href="./partials/zotero.xsl"/>
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>

    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:titleStmt/tei:title[1]/text()"/>
    </xsl:variable>
    <xsl:variable name="summary">
        <xsl:value-of select='.//tei:note[@type="summary"]/tei:p/text()'/>
    </xsl:variable>
    <!-- Variables to display letter image -->
    <xsl:variable name="img_base">https://letters1916.ie/diyhistory/archive/fullsize/</xsl:variable>
    <xsl:variable name="img_url">
        <xsl:value-of select="concat($img_base, data(.//tei:graphic[1]/@url))"/>
    </xsl:variable>


    <xsl:template match="/">
        <html class="h-100" lang="{$default_lang}">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="zoterMetaTags">
                    <xsl:with-param name="pageId" select="$link"></xsl:with-param>
                    <xsl:with-param name="zoteroTitle" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <!-- Provide the names of the authors/editors of the current unit, ideally fetched from the data via xslt or hard coded as below -->
                <meta name="citation_author" content="Foo, Bar"/>
                <meta name="citation_author" content="Bar, Foo"/> 
            </head>
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0 flex-grow-1">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="ps-5 p-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.html">
                                    <xsl:value-of select="$project_short_title"/>
                                </a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="toc.html">
                                    <xsl:value-of select="'Inhaltsverzeichnis'"/>
                                </a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                <xsl:value-of select="$doc_title"/>
                            </li>
                        </ol>
                    </nav>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-2 col-lg-2 col-sm-12 text-start">
                                <xsl:if test="ends-with($prev,'.html')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$prev"/>
                                        </xsl:attribute>
                                        <i class="fs-2 bi bi-chevron-left" title="Zurück zum vorigen Dokument" visually-hidden="true">
                                            <span class="visually-hidden">Zurück zum vorigen Dokument</span>
                                        </i>
                                    </a>
                                </xsl:if>
                            </div>
                            <div class="col-md-8 col-lg-8 col-sm-12 text-center">
                                <h1>
                                    <xsl:value-of select="$doc_title"/>
                                </h1>
                                <div>
                                    <a href="{$teiSource}">
                                        <i class="bi bi-download fs-2" title="Zum TEI/XML Dokument" visually-hidden="true">
                                            <span class="visually-hidden">Zum TEI/XML Dokument</span>
                                        </i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-2 col-lg-2 col-sm-12 text-end">
                                <xsl:if test="ends-with($next, '.html')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$next"/>
                                        </xsl:attribute>
                                        <i class="fs-2 bi bi-chevron-right" title="Weiter zum nächsten Dokument" visually-hidden="true">
                                            <span class="visually-hidden">Weiter zum nächsten Dokument</span>
                                        </i>
                                    </a>
                                </xsl:if>
                            </div>
                        </div>
                        <div class="row pt-3">
                        <!-- Tabbed navigation (left)-->
                            <div class="col-md-5 pt-5">
                                <nav>
                                    <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                        <button class="nav-link active" id="nav-read-tab" data-bs-toggle="tab" data-bs-target="#nav-read" type="button" role="tab" aria-controls="nav-read" aria-selected="true">Transcription</button>
                                        <button class="nav-link" id="nav-about-tab" data-bs-toggle="tab" data-bs-target="#nav-about" type="button" role="tab" aria-controls="nav-about" aria-selected="false">About this letter</button>
                                        <button class="nav-link" id="nav-meta-tab" data-bs-toggle="tab" data-bs-target="#nav-meta" type="button" role="tab" aria-controls="nav-meta" aria-selected="false">Meta</button>
                                    </div>
                                </nav>
                                <div class="tab-content" id="nav-tabContent">
                                    <div class="tab-pane fade show active" id="nav-read" role="tabpanel" aria-labelledby="nav-read-tab"><xsl:apply-templates select="//tei:body"/></div>
                                    <div class="tab-pane fade" id="nav-about" role="tabpanel" aria-labelledby="nav-about-tab"><p><i><xsl:value-of select="$summary"/></i></p></div>
                                    <div class="tab-pane fade" id="nav-meta" role="tabpanel" aria-labelledby="nav-meta-tab">
                                        <div class="card" style="width: 100%;">
                                            <ul class="list-group list-group-flush">
                                                <li class="list-group-item">
                                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6" style="width: 1.5rem; height: 1.5rem; display: inline-block;">
                                                        <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                                    </svg>
                                                    &#160;
                                                    <xsl:value-of select='.//tei:correspAction[@type="sent"]/tei:persName/text()'/>
                                                </li>
                                                <li class="list-group-item">
                                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6" style="width: 1.5rem; height: 1.5rem; display: inline-block;">
                                                        <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 9v.906a2.25 2.25 0 0 1-1.183 1.981l-6.478 3.488M2.25 9v.906a2.25 2.25 0 0 0 1.183 1.981l6.478 3.488m8.839 2.51-4.66-2.51m0 0-1.023-.55a2.25 2.25 0 0 0-2.134 0l-1.022.55m0 0-4.661 2.51m16.5 1.615a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V8.844a2.25 2.25 0 0 1 1.183-1.981l7.5-4.039a2.25 2.25 0 0 1 2.134 0l7.5 4.039a2.25 2.25 0 0 1 1.183 1.98V19.5Z" />
                                                    </svg>
                                                    &#160;
                                                    <xsl:value-of select='.//tei:correspAction[@type="received"]/tei:persName/text()'/>
                                                </li>
                                                <li class="list-group-item">
                                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6" style="width: 1.5rem; height: 1.5rem; display: inline-block;">
                                                        <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 0 1 2.25-2.25h13.5A2.25 2.25 0 0 1 21 7.5v11.25m-18 0A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75m-18 0v-7.5A2.25 2.25 0 0 1 5.25 9h13.5A2.25 2.25 0 0 1 21 11.25v7.5m-9-6h.008v.008H12v-.008ZM12 15h.008v.008H12V15Zm0 2.25h.008v.008H12v-.008ZM9.75 15h.008v.008H9.75V15Zm0 2.25h.008v.008H9.75v-.008ZM7.5 15h.008v.008H7.5V15Zm0 2.25h.008v.008H7.5v-.008Zm6.75-4.5h.008v.008h-.008v-.008Zm0 2.25h.008v.008h-.008V15Zm0 2.25h.008v.008h-.008v-.008Zm2.25-4.5h.008v.008H16.5v-.008Zm0 2.25h.008v.008H16.5V15Z" />
                                                    </svg>
                                                    &#160;
                                                    <xsl:value-of select='.//tei:correspAction[@type="sent"]/tei:date/text()'/>
                                                </li>
                                                <li class="list-group-item">
                                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 " style="width: 1.5rem; height: 1.5rem; display: inline-block;">
                                                        <path stroke-linecap="round" stroke-linejoin="round" d="M9.568 3H5.25A2.25 2.25 0 0 0 3 5.25v4.318c0 .597.237 1.17.659 1.591l9.581 9.581c.699.699 1.78.872 2.607.33a18.095 18.095 0 0 0 5.223-5.223c.542-.827.369-1.908-.33-2.607L11.16 3.66A2.25 2.25 0 0 0 9.568 3Z" />
                                                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 6h.008v.008H6V6Z" />
                                                    </svg>
                                                    &#160;
                                                    <xsl:value-of select='//tei:keywords/tei:list/tei:item[@n="topic"]/text()'/>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>     
                            </div>
                            <!-- Image viewer (right)-->
                            <div class="col-md-7 text-center">
                                <div id="osd_viewer"/>
                                    <a target="_blank">
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$img_url"/>
                                        </xsl:attribute>
                                        Open image in new tab
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div>
                        
                        <!--
                            <p style="text-align:center;">
                                <xsl:for-each select=".//tei:note[not(./tei:p)]">
                                    <div class="footnotes">
                                        <xsl:element name="a">
                                            <xsl:attribute name="name">
                                                <xsl:text>fn</xsl:text>
                                                <xsl:number level="any" format="1" count="tei:note"/>
                                            </xsl:attribute>
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:text>#fna_</xsl:text>
                                                    <xsl:number level="any" format="1" count="tei:note"/>
                                                </xsl:attribute>
                                                <span style="font-size:7pt;vertical-align:super; margin-right: 0.4em">
                                                    <xsl:number level="any" format="1" count="tei:note"/>
                                                </span>
                                            </a>
                                        </xsl:element>
                                        <xsl:apply-templates/>
                                    </div>
                                </xsl:for-each>
                            </p>
                            -->

                            <div class="text-center p-4">
                                <xsl:call-template name="blockquote">
                                    <xsl:with-param name="pageId" select="$link"/>
                                </xsl:call-template>
                            </div>
                        </div>
                    <xsl:for-each select="//tei:back">
                        <div class="tei-back">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:for-each>
                </main>
                <xsl:call-template name="html_footer"/>
                <script src="vendor/openseadragon-bin-4.1.1/openseadragon.min.js"/>
                <script type="text/javascript">
                    var viewer = OpenSeadragon({
                        id: "osd_viewer",
                        sequenceMode: true,
                        showReferenceStrip: true,
                        tileSources: [
                            <xsl:for-each select=".//tei:graphic/@url">
                                {
                                type: 'image',
                                url: '<xsl:value-of select="concat($img_base, .)"/>'
                                },
                            </xsl:for-each>
                        ],
                        prefixUrl:"https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.1.0/images/",
                    });
                </script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>