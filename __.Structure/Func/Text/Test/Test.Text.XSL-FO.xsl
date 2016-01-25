<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:output indent="yes"/>
    
    <xsl:include href="../Text.xsl"/>

    
    <xsl:template name="Test.Text.InsertBreaks.Default">
        <fo:block border="solid 0.3pt" margin="3pt">
            <xsl:call-template name="Text.FO.InsertBreaks">
                <xsl:with-param name="input" select="' &#10; 1 11      111&#13;&#10;&#13;&#10;2 &#10;&#10;3 &#10; 4 &#10; '" />
            </xsl:call-template>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="Test.Text.InsertBreaks.LineFeed">
        <fo:block border="solid 0.3pt" margin="3pt">
            <xsl:call-template name="Text.FO.InsertBreaks">
                <xsl:with-param name="input" select="' &#10; 1 11      111&#13;&#10;&#13;&#10;2 &#10;&#10;3 &#10; 4 &#10; '" />
                <xsl:with-param name="pointer" select="'&#10;'" />
            </xsl:call-template>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="Test.Text.InsertBreaks.IgnorePointerRepetition">
        <fo:block border="solid 0.3pt" margin="3pt">
            <xsl:call-template name="Text.FO.InsertBreaks">
                <xsl:with-param name="input" select="' &#10; 1 11      111&#13;&#10;&#13;&#10;2 &#10;&#10;3 &#10; 4 &#10; '" />
                <xsl:with-param name="ignorePointerRepetition" select="true()" />
            </xsl:call-template>
        </fo:block>
    </xsl:template>
    
    
    <xsl:template name="Test.Text.InsertDelimiters.ContextFontSize">
        <fo:block border="solid 0.3pt" margin="3pt">
            <xsl:call-template name="Text.FO.InsertDelimiters">
                <xsl:with-param name="input" select="' &#10; 1 11      111&#13;&#10;&#13;&#10;2 &#10;&#10;3 &#10; 4 &#10; '" />
            </xsl:call-template>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="Test.Text.InsertDelimiters.DelimiterSize">
        <fo:block border="solid 0.3pt" margin="3pt">
            <xsl:call-template name="Text.FO.InsertDelimiters">
                <xsl:with-param name="input" select="' &#10; 1 11      111&#13;&#10;&#13;&#10;2 &#10;&#10;3 &#10; 4 &#10; '" />
                <xsl:with-param name="size" select="'4pt'" />
            </xsl:call-template>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="Test.Text.InsertDelimiters.IgnorePointerRepetition">
        <fo:block border="solid 0.3pt" margin="3pt">
            <xsl:call-template name="Text.FO.InsertDelimiters">
                <xsl:with-param name="input" select="' &#10; 1 11      111&#13;&#10;&#13;&#10;2 &#10;&#10;3 &#10; 4 &#10; '" />
                <xsl:with-param name="ignorePointerRepetition" select="true()" />
            </xsl:call-template>
        </fo:block>
    </xsl:template>
    
    
    
    
    <xsl:template match="/">
        
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master page-height="297mm" page-width="210mm" margin-top="10mm" margin-left="20mm" margin-right="20mm" margin-bottom="10mm" master-name="PageMaster1">
                    <fo:region-after extent="7mm" />
                    <fo:region-body margin-top="0mm" margin-left="0mm" margin-right="0mm" margin-bottom="10mm" />
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="PageMaster1">
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="8pt" hyphenate="true">
                    
                    <fo:table width="400pt">
                        <fo:table-header>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>Text.FO.InsertBreaks</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>Text.FO.InsertDelimiters</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block margin-top="5pt">Default</fo:block>
                                    <xsl:call-template name="Test.Text.InsertBreaks.Default" />
                                    <fo:block margin-top="5pt">LineFeed</fo:block>
                                    <xsl:call-template name="Test.Text.InsertBreaks.LineFeed" />
                                    <fo:block margin-top="5pt">IgnorePointerRepetition</fo:block>
                                    <xsl:call-template name="Test.Text.InsertBreaks.IgnorePointerRepetition" />
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block margin-top="5pt">ContextFontSize</fo:block>
                                    <xsl:call-template name="Test.Text.InsertDelimiters.ContextFontSize" />
                                    <fo:block margin-top="5pt">DelimiterSize</fo:block>
                                    <xsl:call-template name="Test.Text.InsertDelimiters.DelimiterSize" />
                                    <fo:block margin-top="5pt">IgnorePointerRepetition</fo:block>
                                    <xsl:call-template name="Test.Text.InsertDelimiters.IgnorePointerRepetition" />
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                    
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
        
    </xsl:template>
    

</xsl:stylesheet>
