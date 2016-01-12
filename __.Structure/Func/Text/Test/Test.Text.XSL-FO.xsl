<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:include href="../Text.LineBreak.xsl"/>
    
    <xsl:template name="Test.Text.InsertBreaks.LineFeed">
        <fo:block border="solid 0.3pt" margin="3pt">
            <xsl:call-template name="Text.FO.InsertBreaks">
                <xsl:with-param name="input" select="' &#10; 1 11      111&#13;&#10;&#13;&#10;2 &#10; '" />
                <xsl:with-param name="delimiter" select="'&#10;'" />
            </xsl:call-template>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="Test.Text.InsertBreaks.LineFeed.SpacerSized">
        <fo:block border="solid 0.3pt" margin="3pt">
            <xsl:call-template name="Text.FO.InsertBreaks">
                <xsl:with-param name="input" select="' &#10; 1 11      111&#13;&#10;&#13;&#10;2 &#10; '" />
                <xsl:with-param name="delimiter" select="'&#10;'" />
                <xsl:with-param name="spacerSize" select="'22pt'" />
            </xsl:call-template>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="/">
        
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master page-height="297mm" page-width="210mm" margin-top="10mm" margin-left="20mm" margin-right="20mm" margin-bottom="10mm" master-name="PageMaster1">
                    <fo:region-after extent="7mm" />
                    <fo:region-body margin-top="0mm" margin-left="0mm" margin-right="0mm" margin-bottom="10mm" />
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="PageMaster1">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block font-size="0.8em" text-align="right" color="green">
                        <fo:basic-link external-destination="http://www.antennahouse.com/">Antenna House, Inc.</fo:basic-link>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="1em" line-height="1.4" hyphenate="true">
                    
                    <fo:block-container>
                        <fo:block>
                            <xsl:call-template name="Test.Text.InsertBreaks.LineFeed"></xsl:call-template>
                            <xsl:call-template name="Test.Text.InsertBreaks.LineFeed.SpacerSized"></xsl:call-template>
                        </fo:block>
                    </fo:block-container>
                    
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
        
    </xsl:template>
    

</xsl:stylesheet>
