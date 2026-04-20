<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:template name="nav_bar">
        <header>
            <nav aria-label="Primary" class="navbar navbar-expand-lg" style="background-color: #bfb7a4;">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.html">
                        <!--
                        <xsl:value-of select="$project_short_title"/>
                        -->
                        <img>
                            <xsl:attribute name="class">img-fluid d-none d-lg-block</xsl:attribute>
                            <xsl:attribute name="src">https://letters1916.ie/static/media/logo-update.8166fb93.png</xsl:attribute>
                            <xsl:attribute name="alt">Letters 1916 logo</xsl:attribute>
                            <xsl:attribute name="width">450px</xsl:attribute>
                        </img>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Project</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="about.html">About</a>
                                    </li>
                                    <!--
                                    <li>
                                        <a class="dropdown-item" href="imprint.html">Impressum</a>
                                    </li>
                                    -->
                                </ul>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" href="toc.html">Explore the collection</a>
                            </li>

                            <li class="nav-item dropdown disabled">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Index</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="listperson.html">Persons</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listplace.html">Places</a>
                                    </li>
                                    <!--
                                    <li>
                                        <a class="dropdown-item" href="listorg.html">Organisationen</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listbibl.html">Werke</a>
                                    </li>
                                    -->
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a title="API" class="nav-link" href="api.xml">API</a>
                            </li>
                            <li class="nav-item">
                                <a title="Suche" class="nav-link" href="search.html">Search</a>
                            </li>
                            <li class="nav-item">
                                <a title="Suche" class="nav-link" href="noske-search.html">Noske-Suche</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
    </xsl:template>
</xsl:stylesheet>